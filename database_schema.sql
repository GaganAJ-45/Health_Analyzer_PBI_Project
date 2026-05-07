-- Health Analyzer - PostgreSQL Database Schema
-- Author: Gagan A J
-- Date: May 2026
-- Description: Complete database schema for Health Analyzer project

-- Create database
CREATE DATABASE health_analyzer_db;

-- Connect to database
\c health_analyzer_db;

-- =====================================================================
-- TABLE 1: INPATIENT WAITING LIST
-- =====================================================================
CREATE TABLE inpatient_waiting_list (
    id SERIAL PRIMARY KEY,
    archive_date DATE NOT NULL,
    case_type VARCHAR(100),
    specialty_name VARCHAR(150),
    age_profile VARCHAR(50),
    time_bands VARCHAR(50),
    total INTEGER DEFAULT 0,
    source_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================================
-- TABLE 2: OUTPATIENT WAITING LIST
-- =====================================================================
CREATE TABLE outpatient_waiting_list (
    id SERIAL PRIMARY KEY,
    archive_date DATE NOT NULL,
    specialty_name VARCHAR(150),
    age_profile VARCHAR(50),
    time_bands VARCHAR(50),
    total INTEGER DEFAULT 0,
    source_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================================
-- TABLE 3: SPECIALTY MAPPING LOOKUP
-- =====================================================================
CREATE TABLE specialty_mapping (
    id SERIAL PRIMARY KEY,
    specialty_name VARCHAR(150) NOT NULL UNIQUE,
    specialty_group VARCHAR(100),
    category VARCHAR(50),
    department VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================================
-- TABLE 4: UNIFIED ALL DATA TABLE
-- =====================================================================
CREATE TABLE all_data (
    id SERIAL PRIMARY KEY,
    archive_date DATE NOT NULL,
    case_type VARCHAR(50),
    specialty_name VARCHAR(150),
    age_profile VARCHAR(50),
    time_bands VARCHAR(50),
    inpatient INTEGER DEFAULT 0,
    outpatient INTEGER DEFAULT 0,
    total INTEGER DEFAULT 0,
    source_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_specialty FOREIGN KEY (specialty_name) REFERENCES specialty_mapping(specialty_name)
);

-- =====================================================================
-- INDEXES FOR PERFORMANCE OPTIMIZATION
-- =====================================================================

-- Archive Date Index
CREATE INDEX idx_all_data_archive_date ON all_data(archive_date);
CREATE INDEX idx_inpatient_archive_date ON inpatient_waiting_list(archive_date);
CREATE INDEX idx_outpatient_archive_date ON outpatient_waiting_list(archive_date);

-- Specialty Name Index
CREATE INDEX idx_all_data_specialty ON all_data(specialty_name);
CREATE INDEX idx_inpatient_specialty ON inpatient_waiting_list(specialty_name);
CREATE INDEX idx_outpatient_specialty ON outpatient_waiting_list(specialty_name);

-- Case Type Index
CREATE INDEX idx_all_data_case_type ON all_data(case_type);
CREATE INDEX idx_inpatient_case_type ON inpatient_waiting_list(case_type);

-- Composite Indexes for common queries
CREATE INDEX idx_all_data_date_specialty ON all_data(archive_date, specialty_name);
CREATE INDEX idx_all_data_date_case ON all_data(archive_date, case_type);

-- =====================================================================
-- CONSTRAINTS AND VALIDATIONS
-- =====================================================================

-- Add check constraints
ALTER TABLE inpatient_waiting_list
ADD CONSTRAINT check_total_positive CHECK (total >= 0);

ALTER TABLE outpatient_waiting_list
ADD CONSTRAINT check_total_positive CHECK (total >= 0);

ALTER TABLE all_data
ADD CONSTRAINT check_all_total_positive CHECK (total >= 0);

-- =====================================================================
-- VIEWS FOR COMMON QUERIES
-- =====================================================================

-- View: Monthly Summary by Case Type
CREATE VIEW v_monthly_summary AS
SELECT 
    DATE_TRUNC('month', archive_date)::DATE AS month,
    case_type,
    SUM(total) AS monthly_total,
    AVG(total) AS avg_monthly,
    MAX(total) AS max_monthly,
    MIN(total) AS min_monthly,
    COUNT(*) AS record_count
FROM all_data
GROUP BY DATE_TRUNC('month', archive_date), case_type
ORDER BY month DESC, case_type;

-- View: Specialty Performance
CREATE VIEW v_specialty_performance AS
SELECT 
    specialty_name,
    SUM(CASE WHEN case_type = 'Inpatient' THEN total ELSE 0 END) AS inpatient_count,
    SUM(CASE WHEN case_type = 'Outpatient' THEN total ELSE 0 END) AS outpatient_count,
    SUM(total) AS specialty_total,
    AVG(total) AS avg_waiting,
    MAX(total) AS max_waiting,
    MIN(total) AS min_waiting
FROM all_data
GROUP BY specialty_name
ORDER BY specialty_total DESC;

-- View: Age Profile Analysis
CREATE VIEW v_age_profile_analysis AS
SELECT 
    age_profile,
    time_bands,
    case_type,
    SUM(total) AS total_count,
    AVG(total) AS avg_count,
    MAX(total) AS max_count,
    MIN(total) AS min_count
FROM all_data
GROUP BY age_profile, time_bands, case_type
ORDER BY total_count DESC;

-- View: Current Month Status
CREATE VIEW v_current_month_status AS
SELECT 
    specialty_name,
    case_type,
    SUM(total) AS current_total,
    AVG(total) AS avg_waiting
FROM all_data
WHERE archive_date = (SELECT MAX(archive_date) FROM all_data)
GROUP BY specialty_name, case_type
ORDER BY current_total DESC;

-- =====================================================================
-- STORED PROCEDURES
-- =====================================================================

-- Procedure: Load Inpatient Data
CREATE OR REPLACE PROCEDURE load_inpatient_data(
    p_filename VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- This procedure will be used by ETL process to load inpatient data
    INSERT INTO inpatient_waiting_list (archive_date, case_type, specialty_name, age_profile, time_bands, total, source_name)
    SELECT * FROM inpatient_waiting_list;
    
    RAISE NOTICE 'Inpatient data loaded from %', p_filename;
END;
$$;

-- Procedure: Consolidate Data
CREATE OR REPLACE PROCEDURE consolidate_all_data()
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM all_data;
    
    INSERT INTO all_data (archive_date, case_type, specialty_name, age_profile, time_bands, inpatient, total, source_name)
    SELECT 
        i.archive_date,
        i.case_type,
        i.specialty_name,
        i.age_profile,
        i.time_bands,
        i.total AS inpatient,
        i.total,
        i.source_name
    FROM inpatient_waiting_list i;
    
    INSERT INTO all_data (archive_date, case_type, specialty_name, age_profile, time_bands, outpatient, total, source_name)
    SELECT 
        o.archive_date,
        'Outpatient',
        o.specialty_name,
        o.age_profile,
        o.time_bands,
        o.total AS outpatient,
        o.total,
        o.source_name
    FROM outpatient_waiting_list o;
    
    RAISE NOTICE 'Data consolidated successfully. Total records: %', (SELECT COUNT(*) FROM all_data);
END;
$$;

-- Procedure: Data Validation
CREATE OR REPLACE PROCEDURE validate_data()
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_records INTEGER;
    v_null_dates INTEGER;
    v_negative_totals INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_total_records FROM all_data;
    SELECT COUNT(*) INTO v_null_dates FROM all_data WHERE archive_date IS NULL;
    SELECT COUNT(*) INTO v_negative_totals FROM all_data WHERE total < 0;
    
    RAISE NOTICE 'Data Validation Report:';
    RAISE NOTICE 'Total Records: %', v_total_records;
    RAISE NOTICE 'Records with NULL dates: %', v_null_dates;
    RAISE NOTICE 'Records with negative totals: %', v_negative_totals;
    
    IF v_null_dates > 0 OR v_negative_totals > 0 THEN
        RAISE WARNING 'Data quality issues detected!';
    ELSE
        RAISE NOTICE 'Data validation passed!';
    END IF;
END;
$$;

-- =====================================================================
-- DATA REFRESH PROCEDURE
-- =====================================================================

CREATE OR REPLACE PROCEDURE refresh_all_data()
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        CALL consolidate_all_data();
        CALL validate_data();
        RAISE NOTICE 'Data refresh completed successfully';
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Error during data refresh: %', SQLERRM;
    END;
END;
$$;

-- =====================================================================
-- INITIAL COMMENTS AND DOCUMENTATION
-- =====================================================================

COMMENT ON TABLE inpatient_waiting_list IS 'Stores inpatient waiting list data from 2018-2021';
COMMENT ON TABLE outpatient_waiting_list IS 'Stores outpatient waiting list data from 2018-2021';
COMMENT ON TABLE specialty_mapping IS 'Lookup table for specialty categorization and grouping';
COMMENT ON TABLE all_data IS 'Unified table combining inpatient and outpatient data for analysis';

COMMENT ON COLUMN all_data.archive_date IS 'Date of the record snapshot (primary key)';
COMMENT ON COLUMN all_data.case_type IS 'Type of case: Inpatient, Outpatient, or Day Case';
COMMENT ON COLUMN all_data.specialty_name IS 'Medical specialty or department name';
COMMENT ON COLUMN all_data.age_profile IS 'Age group of patients in waiting list';
COMMENT ON COLUMN all_data.time_bands IS 'Waiting time category (e.g., <1 Month, 1-3 Months)';
COMMENT ON COLUMN all_data.total IS 'Total number of patients in waiting list';

-- =====================================================================
-- GRANT PERMISSIONS
-- =====================================================================

GRANT CONNECT ON DATABASE health_analyzer_db TO PUBLIC;
GRANT USAGE ON SCHEMA public TO PUBLIC;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO PUBLIC;

-- =====================================================================
-- DATABASE CREATION COMPLETE
-- =====================================================================
