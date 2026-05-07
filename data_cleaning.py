"""
Health Analyzer - Data Cleaning Script
Author: Gagan A J
Date: May 2026
Description: This script performs data cleaning and preprocessing on healthcare waiting list data
"""

import pandas as pd
import numpy as np
from datetime import datetime
import os

# Configuration
DATA_INPUT_PATH = './data/raw/'
DATA_OUTPUT_PATH = './data/processed/'
LOG_FILE = './logs/data_cleaning_log.txt'

def create_output_directories():
    """Create necessary output directories if they don't exist"""
    os.makedirs(DATA_OUTPUT_PATH, exist_ok=True)
    os.makedirs('./logs', exist_ok=True)

def log_message(message):
    """Log messages to file and console"""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    log_entry = f"[{timestamp}] {message}"
    print(log_entry)
    with open(LOG_FILE, 'a') as f:
        f.write(log_entry + '\n')

def load_csv_files(path):
    """Load all CSV files from the specified path"""
    log_message("=" * 60)
    log_message("STARTING DATA LOADING PROCESS")
    log_message("=" * 60)
    
    dataframes = {}
    csv_files = [f for f in os.listdir(path) if f.endswith('.csv')]
    
    for file in csv_files:
        try:
            df = pd.read_csv(os.path.join(path, file))
            dataframes[file.replace('.csv', '')] = df
            log_message(f"✓ Loaded {file} - Shape: {df.shape}")
        except Exception as e:
            log_message(f"✗ Error loading {file}: {str(e)}")
    
    return dataframes

def assess_data_quality(dataframes):
    """Assess and report data quality issues"""
    log_message("\n" + "=" * 60)
    log_message("DATA QUALITY ASSESSMENT")
    log_message("=" * 60)
    
    for name, df in dataframes.items():
        log_message(f"\nDataframe: {name}")
        log_message(f"  Shape: {df.shape}")
        log_message(f"  Missing Values:\n{df.isnull().sum()}")
        log_message(f"  Duplicate Records: {df.duplicated().sum()}")
        log_message(f"  Data Types:\n{df.dtypes}")

def standardize_column_names(df):
    """Standardize column names - remove spaces, convert to snake_case"""
    df.columns = df.columns.str.strip()
    df.columns = df.columns.str.replace(' ', '_')
    df.columns = df.columns.str.lower()
    return df

def handle_missing_values(df):
    """Handle missing values in the dataset"""
    # Fill missing categorical values
    if 'case_type' in df.columns:
        df['case_type'].fillna('Unknown', inplace=True)
    if 'specialty_name' in df.columns:
        df['specialty_name'].fillna('Unknown', inplace=True)
    if 'age_profile' in df.columns:
        df['age_profile'].fillna('Unknown', inplace=True)
    
    # Forward fill for time-series data
    if 'archive_date' in df.columns:
        df = df.sort_values('archive_date')
    
    return df

def remove_duplicates(df):
    """Remove duplicate records from the dataset"""
    initial_rows = len(df)
    df = df.drop_duplicates()
    removed_rows = initial_rows - len(df)
    
    if removed_rows > 0:
        log_message(f"Removed {removed_rows} duplicate records")
    
    return df

def trim_whitespace(df):
    """Remove trailing and leading whitespace from string columns"""
    string_columns = df.select_dtypes(include=['object']).columns
    
    for col in string_columns:
        df[col] = df[col].str.strip()
    
    return df

def standardize_date_format(df):
    """Convert archive_date to datetime format"""
    if 'archive_date' in df.columns:
        try:
            df['archive_date'] = pd.to_datetime(df['archive_date'], format='%d-%m-%Y')
            log_message("✓ Converted archive_date to datetime format")
        except Exception as e:
            log_message(f"✗ Error converting date format: {str(e)}")
    
    return df

def standardize_categorical_values(df):
    """Standardize categorical values for consistency"""
    # Age Profile standardization
    if 'age_profile' in df.columns:
        age_mappings = {
            '18+ months': '18+ Months',
            '18 month +': '18+ Months',
            '0-3 months': '0-3 Months',
            '3-6 months': '3-6 Months',
            '6-12 months': '6-12 Months',
            '12-18 months': '12-18 Months'
        }
        df['age_profile'] = df['age_profile'].replace(age_mappings)
    
    # Time Bands standardization
    if 'time_bands' in df.columns:
        time_mappings = {
            '<1 month': '<1 Month',
            '1-3 months': '1-3 Months',
            '3-6 months': '3-6 Months',
            '6-12 months': '6-12 Months',
            '12+ months': '12+ Months'
        }
        df['time_bands'] = df['time_bands'].replace(time_mappings)
    
    return df

def validate_numeric_columns(df):
    """Ensure numeric columns have valid values"""
    numeric_cols = ['total']
    
    for col in numeric_cols:
        if col in df.columns:
            # Remove negative values
            df[col] = df[col].apply(lambda x: x if x >= 0 else 0)
            # Convert to integer
            df[col] = df[col].astype('int64')
    
    return df

def clean_dataframe(df):
    """Apply all cleaning operations to a dataframe"""
    df = standardize_column_names(df)
    df = handle_missing_values(df)
    df = remove_duplicates(df)
    df = trim_whitespace(df)
    df = standardize_date_format(df)
    df = standardize_categorical_values(df)
    df = validate_numeric_columns(df)
    
    return df

def combine_inpatient_outpatient(inpatient_dfs, outpatient_dfs):
    """Combine inpatient and outpatient data with consistent structure"""
    log_message("\n" + "=" * 60)
    log_message("COMBINING INPATIENT AND OUTPATIENT DATA")
    log_message("=" * 60)
    
    inpatient_list = []
    outpatient_list = []
    
    # Process inpatient data
    for name, df in inpatient_dfs.items():
        log_message(f"Processing {name}...")
        df = clean_dataframe(df)
        inpatient_list.append(df)
    
    # Process outpatient data and add case_type column
    for name, df in outpatient_dfs.items():
        log_message(f"Processing {name}...")
        df = clean_dataframe(df)
        
        # Add Case_Type column if missing
        if 'case_type' not in df.columns:
            df['case_type'] = 'Outpatient'
        
        outpatient_list.append(df)
    
    # Combine all data
    if inpatient_list and outpatient_list:
        all_inpatient = pd.concat(inpatient_list, ignore_index=True)
        all_outpatient = pd.concat(outpatient_list, ignore_index=True)
        
        # Ensure both have same columns
        all_inpatient['case_type'] = 'Inpatient'
        
        all_data = pd.concat([all_inpatient, all_outpatient], ignore_index=True)
        log_message(f"✓ Combined data shape: {all_data.shape}")
        
        return all_data
    
    return None

def export_cleaned_data(df, output_path):
    """Export cleaned data to CSV"""
    try:
        output_file = os.path.join(output_path, 'all_data_cleaned.csv')
        df.to_csv(output_file, index=False)
        log_message(f"✓ Exported cleaned data to {output_file}")
        log_message(f"  Total records: {len(df)}")
        log_message(f"  Date range: {df['archive_date'].min()} to {df['archive_date'].max()}")
    except Exception as e:
        log_message(f"✗ Error exporting data: {str(e)}")

def main():
    """Main execution function"""
    log_message("Starting Health Analyzer Data Cleaning Process...")
    log_message(f"Input Path: {DATA_INPUT_PATH}")
    log_message(f"Output Path: {DATA_OUTPUT_PATH}")
    
    # Create directories
    create_output_directories()
    
    # Load data
    dataframes = load_csv_files(DATA_INPUT_PATH)
    
    if not dataframes:
        log_message("✗ No CSV files found. Exiting.")
        return
    
    # Assess data quality
    assess_data_quality(dataframes)
    
    # Separate inpatient and outpatient
    inpatient_dfs = {k: v for k, v in dataframes.items() if 'IN_WL' in k}
    outpatient_dfs = {k: v for k, v in dataframes.items() if 'Op_WL' in k}
    
    # Combine and clean data
    all_data = combine_inpatient_outpatient(inpatient_dfs, outpatient_dfs)
    
    if all_data is not None:
        # Export cleaned data
        export_cleaned_data(all_data, DATA_OUTPUT_PATH)
        
        log_message("\n" + "=" * 60)
        log_message("DATA CLEANING COMPLETED SUCCESSFULLY")
        log_message("=" * 60)
    else:
        log_message("✗ Failed to combine data. Exiting.")

if __name__ == "__main__":
    main()
