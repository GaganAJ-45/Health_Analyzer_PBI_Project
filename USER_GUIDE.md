# Health Analyzer Dashboard - User Guide

**Project:** Health Analyzer - Patient Waiting List Dashboard  
**Author:** Gagan A J  
**Date:** May 2026  
**Version:** 1.0

---

## Table of Contents

1. [Introduction](#introduction)
2. [Getting Started](#getting-started)
3. [Dashboard Overview](#dashboard-overview)
4. [How to Use Each Page](#how-to-use-each-page)
5. [Key Metrics Explained](#key-metrics-explained)
6. [Common Tasks](#common-tasks)
7. [Troubleshooting](#troubleshooting)
8. [FAQ](#faq)

---

## Introduction

The Health Analyzer Dashboard is a comprehensive Power BI tool designed to analyze and visualize patient waiting list data across inpatient and outpatient categories. It provides real-time insights into waiting list trends, specialty-level performance, and demographic distribution of patients.

### Key Features
- Real-time waiting list metrics with Year-over-Year comparison
- Interactive filtering by date, specialty, and case type
- Drill-down capability for detailed analysis
- Dynamic toggle between Average and Median calculations
- Custom tooltips with specialty group breakup
- Three specialized dashboard pages for different analytical needs

### Who Should Use This Dashboard?
- Healthcare Administrators
- Operations Managers
- Clinical Directors
- Data Analysts
- Executive Leadership

---

## Getting Started

### Accessing the Dashboard

1. Open Power BI Desktop or Power BI Service
2. Load the file: `Patient_Health_Analyzer_Dashboard.pbix`
3. The dashboard will open with the Summary Page active

### System Requirements
- Power BI Desktop (Version 2.100 or later) OR
- Power BI Service (Online)
- Active database connection to PostgreSQL (if refreshing data)
- Screen resolution: 1920x1080 or higher (recommended)

### First Time Setup

**Step 1: Verify Data Connection**
- The dashboard connects to PostgreSQL database
- Ensure your database is running and accessible
- Contact your IT team if connection issues occur

**Step 2: Refresh Data**
- Click **Refresh** button (top toolbar) to load latest data
- Wait for refresh to complete (typically 30-60 seconds)
- You should see "Last Refreshed" timestamp update

**Step 3: Explore the Dashboard**
- Navigate to Summary Page (default view)
- Use filters to explore data
- Visit other pages to understand complete feature set

---

## Dashboard Overview

### Three Main Pages

#### **Page 1: Summary Page** (Default Landing Page)
- High-level KPIs and trends
- Best for: Executive overview and quick status checks
- Key Visuals: KPI cards, trend charts, specialty rankings

#### **Page 2: Detailed Analysis Page**
- Granular data exploration
- Best for: Deep-dive analysis and specific investigations
- Key Visuals: Matrix visualization with drill-down capability

#### **Page 3: Specialty Analysis Page**
- Specialty-level performance ranking
- Best for: Resource allocation and specialty-specific planning
- Key Visuals: Horizontal bar chart, demographic breakdown

---

## How to Use Each Page

### SUMMARY PAGE (Page 1)

#### Top KPI Cards (Purple Cards)

**Latest Month Wait List (Left Card)**
- **What it shows:** Total patients currently on waiting list
- **Current value:** 709,000 patients
- **How to use:** 
  - Check for month-to-month changes
  - Watch for trends indicating capacity issues
  - Use for executive reporting

**Prior Year Latest Month (Right Card)**
- **What it shows:** Same metric from one year ago
- **Previous value:** 640,000 patients
- **How to use:**
  - Compare against current month (shows 10.8% increase)
  - Assess year-over-year growth
  - Identify long-term trends

**Toggle Button (Blue Button)**
- **Purpose:** Switch between Average and Median calculations
- **Click "Average"** for mean waiting list values
- **Click "Median"** for middle value (less affected by outliers)
- **When to use each:**
  - Average: For overall trend analysis
  - Median: When outliers skew results

#### Case Type Distribution (Orange Doughnut Chart)

**What it shows:** Breakdown of cases by type
- **Day Case:** Same-day procedures
- **Inpatient:** Overnight hospitalization cases
- **How to use:**
  - Click segments to filter entire dashboard
  - See relative proportions of each case type
  - Identify case type trends

#### Time Band vs Age Profile (Multi-color Matrix)

**What it shows:** Cross-tabulation of waiting time and age groups
- Rows: Age groups (0-3 months, 0-15, 16-64, 65+)
- Columns: Waiting time bands (<1 month, 1-3 months, etc.)
- Colors: Darker = higher waiting list volume
- **How to use:**
  - Identify which age groups wait longest
  - Spot demographic patterns
  - Find groups needing intervention

#### Monthly Trend Lines (Bottom Section)

**Two Line Charts:**
1. **Left Chart - Day Case & Inpatient Trends**
   - Shows: Inpatient and day case waiting list over time
   - Range: 21,000 - 57,000 patients
   - Peak: July 2018 (57,000)
   - **How to use:** Spot seasonal patterns and growth trends

2. **Right Chart - Outpatient Trends**
   - Shows: Outpatient waiting list over time
   - Range: 500,000 - 610,000 patients
   - Peak: January 2021 (610,000)
   - **How to use:** Understand outpatient demand cycles

#### Filters at Bottom

**Available Slicers:**
- **Archive Date Slider:** Select date range
- **Case Type Filter:** Choose specific case types
- **Specialty Filter:** Filter by medical specialty

**How to Use Filters:**
1. Click on filter element
2. Select desired values
3. Dashboard updates automatically
4. Click "X" to clear filter

---

### DETAILED ANALYSIS PAGE (Page 2)

#### Matrix Visualization

**Structure:**
- Rows: Can show multiple dimensions (Archive Date, Specialty, Age Profile)
- Columns: Case Type breakdown (Inpatient, Outpatient, Total)
- Values: Patient count for each combination

**How to Use:**
1. **Expand/Collapse:** Click arrows next to row labels
   - Click "+" to drill down to detailed level
   - Click "-" to collapse back to summary

2. **Sort:** Click column headers to sort ascending/descending
   - Click "Total" header to rank by highest volume

3. **Focus on Specific Criteria:**
   - Use top-level filters to isolate data
   - Examine detailed breakdown by expanded rows

4. **Export Data:**
   - Right-click on matrix
   - Select "Export data" to copy to Excel

**Common Analysis Scenarios:**

**Scenario 1: Find high-volume specialties**
1. Expand Specialty_Name dimension
2. Sort by Total (descending)
3. Review top specialties

**Scenario 2: Analyze age-based waiting patterns**
1. Expand Age_Profile dimension
2. Look across Time_Bands columns
3. Identify age groups with longest waits

**Scenario 3: Compare inpatient vs outpatient**
1. Compare Inpatient and Outpatient columns
2. Note volume differences
3. Assess relative demand

---

### SPECIALTY ANALYSIS PAGE (Page 3)

#### Large KPI Card (Purple)
- **Shows:** Total wait list across all specialties
- **Value:** 2,464,096 patients (4-year aggregate)
- **How to use:** Understand total system volume

#### Horizontal Bar Chart (Specialty Ranking)

**What it shows:** 28+ medical specialties ranked by waiting list volume

**Top Specialties:**
1. Bones (Orthopedics) - 1.27M patients
2. General - 1.25M patients
3. ENT - 1.02M patients

**How to Use:**
1. **Identify High-Demand Areas:** Longer bars = higher demand
2. **Resource Planning:** Allocate resources to longest bars
3. **Click on Bar:** Filters entire dashboard to that specialty
4. **Hover:** Shows exact values for that specialty

#### Key Indicators Toggle
- Same as Summary Page
- Switch between Average and Median
- Watch metrics update for selected specialty

#### Time Band vs Age Profile (Bottom Matrix)
- Similar to Summary Page
- Shows breakdown for selected specialty
- Helps understand demographic needs by specialty

---

## Key Metrics Explained

### Latest Month Wait List (709K)
**Definition:** Total number of unique patients waiting for treatment in current month  
**Calculation:** Sum of all records for most recent date in dataset  
**Why it Matters:** Indicates current operational load and capacity needs  
**Trend:** Increased 10.8% year-over-year (from 640K)

### Year-over-Year Comparison
**Definition:** Percentage change in waiting list from same month last year  
**Calculation:** ((Current Month - Prior Year) / Prior Year) × 100  
**Interpretation:**
- **Positive %:** Increase in waiting list (capacity pressure)
- **Negative %:** Decrease in waiting list (efficiency gain)
- Current: +10.8% (growing backlog)

### Median Wait List
**Definition:** Middle value when all patient counts are sorted  
**When to Use:** When Average is skewed by extreme values  
**Example:** If outlier specialty has very high numbers, Median better represents typical specialty

### Average Wait List
**Definition:** Mean of all waiting list values  
**When to Use:** For overall trend analysis and forecasting  
**Example:** Useful for predicting future capacity needs

---

## Common Tasks

### Task 1: Check Current Waiting List Status

1. Open Summary Page
2. Look at KPI card: "Latest Month Wait List"
3. Current value: 709,000 patients
4. Compare to Prior Year: 640,000 (shows 10.8% increase)

### Task 2: Analyze Specific Specialty

1. Open Summary Page or Specialty Analysis Page
2. Locate specialty in the bar chart (Page 3) or filter
3. Click on specialty name or bar
4. Dashboard filters to show only that specialty
5. Review all metrics for selected specialty
6. Click X on filter to reset

### Task 3: Examine Waiting Time Patterns

1. Go to Summary Page
2. Look at "Time Band vs Age Profile" matrix
3. Identify combinations with darkest color (longest waits)
4. Focus on 65+ age group if planning elderly patient services
5. Use Detailed Analysis Page for granular breakdown

### Task 4: Compare Case Types

1. Summary Page has Case Type doughnut chart
2. Click on segment (Day Case, Inpatient, or Outpatient) to filter
3. Observe how metrics change by case type
4. Use filter dropdown for more precise selection
5. Clear filter to return to all cases

### Task 5: Export Data for Report

1. Go to Detailed Analysis Page
2. Right-click on Matrix visualization
3. Select "Export data"
4. Save CSV file
5. Open in Excel for additional analysis
6. Use for presentations or further reporting

### Task 6: Refresh Dashboard with New Data

1. Click **Refresh** button (top toolbar)
2. Wait for data to reload (30-60 seconds)
3. Check "Last Refreshed" timestamp
4. All visuals update with new data
5. If errors occur, check database connection

---

## Troubleshooting

### Issue: Dashboard Shows "No Data"

**Possible Causes:**
- Database connection lost
- Data not loaded into PostgreSQL
- Filters too restrictive

**Solutions:**
1. Click the X on filters to clear them
2. Click **Refresh** to reload data
3. Check database connection status
4. Contact IT if connection issue persists

### Issue: Charts Are Blank

**Possible Causes:**
- Data still loading
- Browser cache issue
- Display setting problem

**Solutions:**
1. Wait 30 seconds for data to load
2. Press Ctrl+Shift+Delete to clear browser cache
3. Zoom to 100% (if zoomed in/out)
4. Refresh page (F5)
5. Restart Power BI if issue persists

### Issue: Filter Not Working

**Possible Causes:**
- Filter not properly selected
- Data doesn't match filter criteria
- Display setting obscuring filter

**Solutions:**
1. Click filter element clearly
2. Ensure selection is checked
3. Try clearing filter and reapplying
4. Check if data exists for selected criteria
5. Click **Refresh** and try again

### Issue: Slow Performance

**Possible Causes:**
- Large data volume
- Network connectivity slow
- Multiple filters applied
- Computer resources limited

**Solutions:**
1. Clear filters to reduce data processing
2. Close other applications to free memory
3. Refresh browser or restart Power BI
4. Check internet connection speed
5. Contact IT for server-side optimization

---

## FAQ

### Q: Why are inpatient and outpatient numbers so different?

**A:** Outpatient demand (0.5M-0.6M) significantly exceeds inpatient (21K-57K) because:
- Outpatient includes routine consultations for multiple specialties
- Inpatient is limited to patients requiring overnight hospitalization
- Outpatient volumes reflect broader population seeking care

### Q: How often is the data updated?

**A:** 
- Dashboard data refreshes monthly when new month's data becomes available
- Manual refresh can be triggered anytime via the Refresh button
- Timestamp shows when data was last updated

### Q: What's the difference between "Average" and "Median"?

**A:**
- **Average:** Sum of all values ÷ count (affected by outliers)
- **Median:** Middle value when sorted (not affected by extremes)
- Use **Median** if one specialty has unusually high/low numbers

### Q: Can I export the data?

**A:** Yes! 
1. Go to Detailed Analysis Page
2. Right-click on matrix
3. Select "Export data"
4. Save as CSV to your computer
5. Open in Excel for additional analysis

### Q: How do I filter by multiple specialties?

**A:**
1. Click Specialty filter
2. Click "Select All" to deselect all
3. Click checkboxes next to desired specialties
4. Click "OK" or "Apply"
5. Dashboard updates to show only selected specialties

### Q: What does "Time Bands" represent?

**A:** Time Bands show how long patients have been waiting:
- **<1 Month:** Less than 1 month waiting
- **1-3 Months:** 1 to 3 months waiting
- **3-6 Months:** 3 to 6 months waiting
- **6-12 Months:** 6 to 12 months waiting
- **12+ Months:** More than 12 months waiting

### Q: Can I print the dashboard?

**A:** Yes!
1. Click **File** menu
2. Select **Print**
3. Choose printer settings
4. Click Print
5. Or use Ctrl+P keyboard shortcut

### Q: How do I share the dashboard with others?

**A:**
- **Power BI Service:** Share via "Share" button (requires Power BI Pro license)
- **Power BI Desktop:** Save file and share .pbix file via email or shared drive
- **PDF/Image:** Take screenshot and save as image for email distribution

### Q: What should I do if data seems incorrect?

**A:**
1. Click Refresh to ensure latest data is loaded
2. Check filters to ensure they're correct
3. Compare dates to ensure data exists for selected period
4. Contact Data Analytics team if issue persists
5. Provide specific example of incorrect data

---

## Contact & Support

**Questions about the Dashboard?**
- Email: analytics@nexuscoreinnovations.com
- Slack: #health-analyzer-dashboard

**Technical Support:**
- IT Help Desk: ext. 5000
- Database Issues: database-team@company.com

**Feedback & Suggestions:**
- Submit via: feedback-form@company.com
- We value your input for dashboard improvements!

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | May 2026 | Initial user guide creation |

---

**Last Updated:** May 2026  
**Created By:** Gagan A J  
**For:** Health Analyzer Dashboard v1.0

