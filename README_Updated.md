# Health Analyzer - Patient Waiting List Dashboard

**A comprehensive Power BI dashboard for analyzing healthcare patient waiting lists and driving data-driven operational decisions.**

---

## 🎯 Project Overview

Health Analyzer is an end-to-end business intelligence solution that transforms healthcare waiting list data into actionable insights. The project tracks 2.46 million patient records across 4 years (2018-2021) and enables healthcare organizations to monitor, analyze, and optimize patient waiting list management.

### Key Metrics
- **Total Patient Records:** 2,464,096
- **Data Period:** 2018-2021 (4 years)
- **Medical Specialties:** 28+
- **Latest Month Volume:** 709,000 patients
- **Year-over-Year Growth:** 10.8%

---

## 🚀 Quick Start

### Prerequisites
- **Power BI Desktop** v2.100+ or **Power BI Service**
- **PostgreSQL** (for data storage and refresh)
- **Python 3.8+** (for data processing scripts)
- **Git** (for version control)

### Installation

1. **Clone the Repository**
```bash
git clone https://github.com/GaganAJ-45/Health_Analyzer_PBI_Project.git
cd Health_Analyzer_PBI_Project
```

2. **Set Up Database**
```bash
psql -U postgres -f database_schema.sql
```

3. **Install Python Dependencies**
```bash
pip install -r requirements.txt
```

4. **Run Data Cleaning Script**
```bash
python data_cleaning.py
```

5. **Open Dashboard**
```bash
# Open the Power BI file
Patient_Health_Analyzer_Dashboard.pbix
```

---

## 📊 Dashboard Features

### Summary Page (Page 1)
- **KPI Cards:** Latest month (709K) vs prior year (640K) comparison
- **Case Type Distribution:** Breakdown of Day Case, Inpatient, Outpatient
- **Time Band Analysis:** Waiting time distribution by age profile
- **Trend Lines:** Monthly historical analysis (2018-2021)
- **Dynamic Toggle:** Switch between Average and Median calculations

### Detailed Analysis Page (Page 2)
- **Matrix Visualization:** Multi-dimensional drill-down analysis
- **Flexible Filtering:** By Archive Date, Case Type, Specialty
- **Data Export:** Download filtered data to CSV

### Specialty Analysis Page (Page 3)
- **Specialty Ranking:** 28+ specialties ranked by volume
- **Top Specialties:**
  - Bones: 1.27M patients
  - General: 1.25M patients
  - ENT: 1.02M patients
- **Demographic Breakdown:** Age and waiting time analysis

---

## 📁 Project Structure

```
Health_Analyzer_PBI_Project/
│
├── data/
│   ├── raw/
│   │   ├── IN_WL_2018.csv
│   │   ├── IN_WL_2019.csv
│   │   ├── IN_WL_2020.csv
│   │   ├── IN_WL_2021.csv
│   │   ├── Op_WL_2018.csv
│   │   ├── Op_WL_2019.csv
│   │   ├── Op_WL_2020.csv
│   │   ├── Op_WL_2021.csv
│   │   └── Mapping_Specialty.csv
│   └── processed/
│       └── all_data_cleaned.csv
│
├── scripts/
│   ├── data_cleaning.py
│   ├── data_validation.py
│   ├── database_schema.sql
│   └── aggregation_queries.sql
│
├── dashboard/
│   ├── Patient_Health_Analyzer_Dashboard.pbix
│   ├── Slide1.PNG (Summary Page)
│   ├── Slide2.PNG (Detailed Analysis)
│   └── Slide3.PNG (Specialty Analysis)
│
├── documentation/
│   ├── README.md (this file)
│   ├── DATA_DICTIONARY.md
│   ├── USER_GUIDE.md
│   ├── ETL_PROCESS_FLOW.md
│   └── DAX_MEASURES.md
│
├── config/
│   ├── requirements.txt
│   └── .gitignore
│
└── LICENSE
```

---

## 🛠️ Technology Stack

### Data Processing
- **Python:** Pandas, NumPy for data cleaning and transformation
- **SQL:** PostgreSQL for relational database management
- **ETL:** Custom Python scripts for Extract, Transform, Load

### Analytics & Visualization
- **Power BI:** Interactive dashboards and visualizations
- **DAX:** Dynamic measure calculations
- **Power Query:** Data transformation and modeling

### Data Sources
- **Kaggle:** Public healthcare waiting list dataset
- **Time Period:** 2018-2021
- **Format:** CSV files (8 data files + 1 mapping file)

---

## 📋 Data Elements

### Core Columns
| Field | Type | Description | Example |
|-------|------|-------------|---------|
| Archive_Date | DATE | Monthly snapshot date | 31-01-2018 |
| Case_Type | VARCHAR | Inpatient/Outpatient/Day Case | Inpatient |
| Specialty_Name | VARCHAR | Medical specialty | Bones, General, ENT |
| Age_Profile | VARCHAR | Age group | 65+, 0-15 |
| Time_Bands | VARCHAR | Waiting time category | <1 Month, 1-3 Months |
| Total | INTEGER | Patient count | 1,270,000 |

**Full documentation:** See `DATA_DICTIONARY.md`

---

## 🔄 ETL Process (9 Steps)

1. **Data Collection** - Download from Kaggle
2. **Data Assessment** - Identify quality issues
3. **Data Cleaning** - Python preprocessing (standardize, remove duplicates)
4. **Database Design** - PostgreSQL schema creation
5. **Data Loading** - SQL import of cleaned data
6. **Data Modeling** - Power BI relationships and hierarchies
7. **Visualization** - Dashboard design and layout
8. **Testing** - UAT validation
9. **Deployment** - Share and maintain

**Detailed process:** See `ETL_PROCESS_FLOW.md`

---

## 📊 Key Findings

### Waiting List Trends
- **Latest Month:** 709,000 patients (10.8% increase YoY)
- **Inpatient Peak:** July 2018 (57,000)
- **Outpatient Peak:** January 2021 (610,000)
- **4-Year Aggregate:** 2.46M patient records

### Specialty Performance
1. **Bones (Orthopedics):** 1.27M patients
2. **General Surgery:** 1.25M patients
3. **ENT:** 1.02M patients

### Growth Patterns
- **Outpatient demand:** Consistently higher than inpatient
- **Seasonal variation:** Clear peaks in specific months
- **Year-over-year:** Overall growth trend indicating capacity pressure

---

## 🎓 Learning Resources

### For Users
- **Quick Start:** USER_GUIDE.md (dashboard navigation)
- **Data Definitions:** DATA_DICTIONARY.md (column meanings)
- **Common Tasks:** USER_GUIDE.md (step-by-step instructions)

### For Developers
- **Database Schema:** database_schema.sql (table structure)
- **Python Scripts:** data_cleaning.py (transformation logic)
- **DAX Measures:** DAX_MEASURES.md (calculations)
- **ETL Process:** ETL_PROCESS_FLOW.md (pipeline details)

---

## 🔧 Development

### Running Data Processing

```bash
# Clean and transform data
python data_cleaning.py

# Validate data quality
python data_validation.py

# Load into PostgreSQL
psql -U postgres -d health_analyzer_db -f database_schema.sql
```

### Database Operations

```bash
# Connect to database
psql -U postgres -d health_analyzer_db

# Refresh all data
CALL refresh_all_data();

# Check data quality
CALL validate_data();

# View specialty performance
SELECT * FROM v_specialty_performance;
```

### Power BI Development

1. Open `Patient_Health_Analyzer_Dashboard.pbix` in Power BI Desktop
2. Modify visuals, measures, or pages as needed
3. Refresh data to load latest
4. Publish to Power BI Service for sharing
5. Test all functionality before release

---

## 📈 Business Impact

### Operational Benefits
- **Real-time Visibility:** Current waiting list status (709K patients)
- **Performance Tracking:** YoY growth analysis (10.8% increase)
- **Resource Planning:** Specialty-level demand insights
- **Trend Analysis:** 4-year historical perspective

### Decision Support
- Identify capacity bottlenecks (top 3 specialties = 42% of volume)
- Plan specialty-specific interventions
- Optimize resource allocation by specialty and age group
- Track progress toward waiting time reduction targets

---

## 🐛 Troubleshooting

### Data Issues
**No Data in Dashboard?**
- Check database connection
- Verify data was loaded via `refresh_all_data()`
- Review filters - may be too restrictive

**Incorrect Calculations?**
- Validate data via `validate_data()` procedure
- Check DAX formula definitions in DATA_MEASURES.md
- Ensure all data preprocessing steps completed

### Performance Issues
**Dashboard Slow?**
- Check database connection speed
- Verify indices on Archive_Date, Specialty_Name, Case_Type
- Clear Power BI cache (Ctrl+Shift+Delete)
- Reduce filter complexity

---

## 📞 Support & Contribution

### Questions?
- Email: analytics@nexuscoreinnovations.com
- Issues: GitHub Issues tab
- Discussions: GitHub Discussions

### Want to Contribute?
1. Fork the repository
2. Create feature branch (`git checkout -b feature/improvement`)
3. Commit changes (`git commit -am 'Add improvement'`)
4. Push to branch (`git push origin feature/improvement`)
5. Create Pull Request

---

## 📜 License

This project is licensed under the MIT License - see LICENSE file for details.

---

## 🙏 Acknowledgments

- **Data Source:** Kaggle Healthcare Dataset
- **Company:** Nexus Core Innovations
- **Team:** Data Analytics Team
- **Institution:** PES Institute of Technology and Management

---

## 📝 Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | May 2026 | Initial dashboard release |

---

## 🔗 Quick Links

- **Dashboard File:** `Patient_Health_Analyzer_Dashboard.pbix`
- **User Guide:** `USER_GUIDE.md`
- **Data Dictionary:** `DATA_DICTIONARY.md`
- **GitHub Repository:** https://github.com/GaganAJ-45/Health_Analyzer_PBI_Project
- **Live Dashboard:** [Power BI Service Link]

---

**Last Updated:** May 2026  
**Created By:** Gagan A J  
**For:** Health Analyzer Dashboard v1.0  
**Organization:** Nexus Core Innovations

---

## 📊 Project Statistics

- **Total Patient Records:** 2,464,096
- **Specialties Covered:** 28+
- **Data Years:** 4 (2018-2021)
- **Dashboard Pages:** 3
- **DAX Measures:** 7+
- **Database Tables:** 4
- **Lines of Code:** 1000+
- **Documentation Pages:** 5+

---

**Ready to explore? Start with the USER_GUIDE.md and open the dashboard in Power BI!**
