# Health Analyzer - Data Dictionary

**Project:** Health Analyzer - Patient Waiting List Dashboard  
**Author:** Gagan A J  
**Date:** May 2026  
**Version:** 1.0

---

## Overview

This document provides comprehensive definitions of all data elements in the Health Analyzer project. It includes column names, data types, descriptions, valid values, and business logic for each field in the database and datasets.

---

## Source Data Files

### Inpatient Waiting List Files
- `IN_WL_2018.csv` - Inpatient waiting list data for 2018
- `IN_WL_2019.csv` - Inpatient waiting list data for 2019
- `IN_WL_2020.csv` - Inpatient waiting list data for 2020
- `IN_WL_2021.csv` - Inpatient waiting list data for 2021

### Outpatient Waiting List Files
- `Op_WL_2018.csv` - Outpatient waiting list data for 2018
- `Op_WL_2019.csv` - Outpatient waiting list data for 2019
- `Op_WL_2020.csv` - Outpatient waiting list data for 2020
- `Op_WL_2021.csv` - Outpatient waiting list data for 2021

### Lookup Files
- `Mapping_Specialty.csv` - Specialty mapping and categorization reference

---

## Core Data Elements

### 1. Archive_Date
**Field Name:** Archive_Date  
**Data Type:** DATE  
**Format:** DD-MM-YYYY  
**Description:** The date on which the waiting list snapshot was taken or recorded

**Characteristics:**
- Primary key component in the unified data table
- Range: 31-01-2018 to 31-03-2021
- Frequency: Monthly snapshots
- Required: YES (NOT NULL)

**Example Values:**
- 31-01-2018
- 28-02-2018
- 31-03-2018

**Validation Rules:**
- Must be a valid date
- Must fall within the project date range (2018-2021)
- Must be the last day of the month

---

### 2. Case_Type
**Field Name:** Case_Type  
**Data Type:** VARCHAR(100)  
**Description:** Classification of the type of case or appointment

**Valid Values:**
- Day Case - Same-day procedures and consultations
- Inpatient - Patients requiring overnight hospitalization
- Outpatient - Patients for clinic/specialist consultations

**Characteristics:**
- Used for filtering and segmentation in dashboards
- Present in inpatient data; added to outpatient data during processing
- Required: YES (NOT NULL)

**Notes:**
- Inpatient data includes specific case type values
- Outpatient data is marked as 'Outpatient' during ETL processing
- Day Case is a subset of inpatient procedures

---

### 3. Specialty_Name
**Field Name:** Specialty_Name  
**Data Type:** VARCHAR(150)  
**Description:** Name of the medical specialty or department

**Examples:**
- Bones (Orthopedics)
- General
- ENT (Ear, Nose, Throat)
- Eyes (Ophthalmology)
- Skin (Dermatology)
- Urology
- Cardiology
- Neurology

**Characteristics:**
- 28+ unique specialties in the dataset
- Key dimension for drill-down analysis
- Used to join with specialty_mapping lookup table
- Required: YES (NOT NULL)

**Foreign Key Relationship:**
- Links to `specialty_mapping` table on specialty_name
- Enables specialty categorization and hierarchical analysis

---

### 4. Age_Profile
**Field Name:** Age_Profile  
**Data Type:** VARCHAR(50)  
**Description:** Age group or demographic category of patients in the waiting list

**Valid Values (Standardized):**
- 0-3 Months
- 0-15 (Age group 0-15 years)
- 16-64 (Age group 16-64 years)
- 65+ (Age group 65 years and above)

**Characteristics:**
- Represents either age of patients or duration in waiting list
- Standardized during data cleaning process
- Required: YES (NOT NULL)

**Validation Rules:**
- Remove leading/trailing spaces
- Standardize format and naming
- Handle variations (e.g., "18+ months" → "18+ Months")

---

### 5. Time_Bands
**Field Name:** Time_Bands  
**Data Type:** VARCHAR(50)  
**Description:** Categorization of waiting time duration

**Valid Values (Standardized):**
- <1 Month (Less than 1 month)
- 1-3 Months (1 to 3 months waiting)
- 3-6 Months (3 to 6 months waiting)
- 6-12 Months (6 to 12 months waiting)
- 12+ Months (More than 12 months waiting)

**Characteristics:**
- Indicates how long patients have been waiting
- Critical metric for service level assessment
- Required: YES (NOT NULL)

**Validation Rules:**
- Trim whitespace from values
- Standardize formatting and terminology
- Ensure consistency across all time periods

---

### 6. Total (Patient Count)
**Field Name:** Total  
**Data Type:** INTEGER  
**Description:** Total number of patients in the waiting list for the given combination of dimensions

**Characteristics:**
- Measured in patient count (individuals)
- Always non-negative (>= 0)
- Aggregated from detailed records
- Required: YES (NOT NULL)

**Validation Rules:**
- Must be >= 0 (no negative values)
- Must be numeric integer
- Check for outliers and anomalies

**Statistical Summary:**
- Range: 0 to millions
- Mean: Varies by specialty
- Median: Used as alternative central tendency measure

---

### 7. Source_Name
**Field Name:** Source_Name  
**Data Type:** VARCHAR(100)  
**Description:** Identifier or name of the data source file

**Valid Values:**
- IN_WL_2018 (Inpatient data 2018)
- IN_WL_2019 (Inpatient data 2019)
- IN_WL_2020 (Inpatient data 2020)
- IN_WL_2021 (Inpatient data 2021)
- Op_WL_2018 (Outpatient data 2018)
- Op_WL_2019 (Outpatient data 2019)
- Op_WL_2020 (Outpatient data 2020)
- Op_WL_2021 (Outpatient data 2021)

**Characteristics:**
- Tracks data lineage and source
- Useful for debugging and validation
- Optional but recommended

---

## Lookup Table: Specialty_Mapping

### Purpose
Provides hierarchical categorization and grouping of medical specialties

### Fields

**Specialty_Name**
- Data Type: VARCHAR(150)
- Description: Detailed specialty name (matches specialty in main tables)
- Example: Bones, General, ENT

**Specialty_Group**
- Data Type: VARCHAR(100)
- Description: Higher-level grouping of specialties
- Example: Surgical, Medical, Diagnostic

**Category**
- Data Type: VARCHAR(50)
- Description: Broader classification category
- Example: Acute Care, Planned Care

**Department**
- Data Type: VARCHAR(100)
- Description: Hospital department classification
- Example: Surgery, Medicine, Diagnostics

---

## Calculated Fields (Power BI/DAX)

### Latest Month Wait List
**Definition:** Sum of total waiting list for the most recent month in the dataset  
**Formula:** CALCULATE(SUM(All_Data[Total]), All_Data[Archive_Date] = MAX(All_Data[Archive_Date]))  
**Data Type:** Integer  
**Usage:** Summary KPI card

### Previous Year Latest Month
**Definition:** Sum of total waiting list for the same month one year prior  
**Formula:** CALCULATE(SUM(All_Data[Total]), All_Data[Archive_Date] = EDATE(MAX(All_Data[Archive_Date]), -12))  
**Data Type:** Integer  
**Usage:** Year-over-year comparison

### Average Wait List
**Definition:** Mean of all waiting list values  
**Formula:** AVERAGE(All_Data[Total])  
**Data Type:** Decimal  
**Usage:** Central tendency measure

### Median Wait List
**Definition:** Middle value of all waiting list values when sorted  
**Formula:** MEDIAN(All_Data[Total])  
**Data Type:** Decimal  
**Usage:** Alternative central tendency measure (less affected by outliers)

### YoY Growth %
**Definition:** Percentage change from prior year to current year  
**Formula:** ((Current - Prior Year) / Prior Year) * 100  
**Data Type:** Decimal  
**Usage:** Performance trend analysis

---

## Data Quality Rules

### Required Fields
All the following fields are mandatory and cannot be NULL:
- Archive_Date
- Specialty_Name
- Age_Profile
- Time_Bands
- Total
- Case_Type

### Valid Range Rules
- Total >= 0 (No negative patient counts)
- Archive_Date between 01-01-2018 and 31-12-2021

### Consistency Rules
- Case_Type must be one of: Inpatient, Outpatient, Day Case
- Age_Profile and Time_Bands must use standardized values
- Specialty_Name must match specialty_mapping table

### Referential Integrity
- Specialty_Name must exist in specialty_mapping lookup table

---

## Data Change Log

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | May 2026 | Initial data dictionary creation |

---

## Contact Information

**Data Owner:** Healthcare Analytics Team  
**Created By:** Gagan A J  
**Last Updated:** May 2026  

For questions or clarifications about the data dictionary, please contact the Data Analytics team.

---
