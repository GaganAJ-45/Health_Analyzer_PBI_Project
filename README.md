##                      End-End Power BI Dashboard Development
<img width="1344" height="768" alt="generated-image" src="https://github.com/user-attachments/assets/053e4e1d-50eb-4f2d-a5dd-c7fd438418fc" />

##  The process of creating a dashboard in Power BI consist of following steps:  
1. Requirement Gathering
2. Data Collection
3. Data Transformation & Modelling
4. Data Visualization Blueprint
5. Dashboard Layout & Design
6. Adding Interactivity & Navigation
7. Testing
8. Sharing
9. Maintenance & Routine Refresh
- Now lets see all of these steps in detail and develop a Power BI dashboard from scratch. For this exercise we will be using publicly available Healthcare data about the Patient Waiting List.
  
## You can download the resources used in this entire process from the above github csv files
note: combine all the files make a folder as all_data
## 1. Requirement Gathering
### 1. Identify Stakeholders

- Determine primary stakeholder and establish a point of contact who might be the domain experts or leaders who will eventually use the dashboard

### 2. Understand Business Objectives 

- Through meetings and calls  with stakeholders you should get an outline of Goals from the entire endeavor. Asking open ended questions will help you gain more insights to understand the data and how this dashboard will help achieve a specific business goa
### 3. High Level Data Study

- A high level overview of data is required before you initiate discussions around scope, metrics and other granular topics. So here we will try to understand the data in terms of:

1. Data Sources
2. Column Description
3. Data Type
4. Volume and frequency
5. Data Quality – Missing Values or Anomalies

### 4.Define Scope

- This is the perfect stage to discuss Key Metrics, KPIs & Deployment Timelines. Document the calculations, time frames & scope which will help in setting the expectations and avoiding any future disagreements. Also as a best practice remember to keep a 20% buffer while finalizing deadlines because it’s always better to over deliver after a standard commitment than to underdeliver after an extraordinary delivery pitch.

## What is the problem statement for this exercise?
 Overall Objective
1. Track current status of patient waiting list
2. Analyze historical monthly trend of waiting list in Inpatient & Outpatient categories
3. Detailed specialty level & age profile analysis

Data Scope
  (2018 – 2021)

Metrics
1.  Average & Median Waiting List
2. Current Total Wait List

View
1. Summary Page
2. Detailed Page for Granular Analysis

## 2.Data Collection
There are over 200 different data connectors available to collect data inside power bi, but below are the most widely used connectors:

1. Excel / CSV
2. Folder Connection
3. SQL Server or Any database
4. Power BI services
5. Cloud Platforms – Azure, AWS, GCP etc.
6. ERP Systems – Salesforce, SAP etc.
7. Sharepoint
8. Web or JSON

   
### steps by step to how connect to data source:
1. Open Power BI desktop and click on GET DATA and select FOLDER option. Click Connect button at the bottom right
![unnamed](https://github.com/user-attachments/assets/d7b3d6e2-bc7c-43b7-9ea4-ef4707329a88)

2. Now browse the folder path where we have stored all_data and press ok
<img width="528" height="169" alt="unnamed" src="https://github.com/user-attachments/assets/8249a732-42fc-413d-8fe2-929fb751182b" />

3. The next prompt will show you the files available in the folder path. Then click on Combine button and select Combine & Load


##  3.Data Transformation
Data transformation is a process of changing the structure of your data or applying additional steps which will clean or process your data for final usage. We do these transformations in the Power Query Editor which is inbuilt into Power BI.
<img width="1600" height="516" alt="unnamed" src="https://github.com/user-attachments/assets/42eb0d2b-dc56-491c-bc45-b10cd96f6349" />

Now for this project purposes we will mainly see below steps:

1. Renaming Columns
2. Rearranging Columns
3. Appending 2 Tables
4. Replacing & trimming values

### There are many other transformation steps which you can apply like Pivot/Unpivot, Merge, Filtering etc. but for now we only need the above 3 steps

1. Renaming Columns

While studying the data, I noticed that the Specialty column in Inpatient data is named as Specialty_Name, whereas in Outpatient it is named as just Specialty. So we will rename the Outpatient column to match with the Inpatient data. Make sure to name it exactly the same, otherwise it will create an issue in following steps.

2. Rearranging Columns

We will now rearrange our columns of the outpatient so that it matches with inpatient. You can just left click on the column header and drag it to the required position. Now while rearranging, I noticed that we have an additional column in Inpatient i.e. Case_Type which is missing from Outpatient. So lets create one additional column in Outpatient table called Case_Type by

Go to Add Columns
Click on Custom Columns
Name the column as Case_Type
Enter the formula =”Outpatient”
Remember to place this new column at the same position as inpatients
Appending Tables

Now that both our tables have the same column structure, we can safely append them together. To do that come to Home tab and click on “Append Queries” button and click on “Append Queries as New”. Select 1st table as inpatient and 2nd table as outpatient. Rename this new table as “All_Data”. Finally click on “Close & Apply”.

3. Appending Tables

Observe that Age_Profile & Time_Band columns have some redundant data, so first use the Replace function button in power query to clean the data, for eg: “18+ months” and “18 month +”, both are the same, so replace either one to match the other. Secondly there are some trailing blanks in values of these columns so remove trailing blanks by using the Trim function button.

### Data Modelling

- Data modelling is a way to create relationship with one table to another, so that we can fetch valuable information from them in our reporting layer.
- Lets jump into the Data Modelling View, which is located at the left hand panel on Power BI.

- We will be using All_Data from now onwards, so we can safely hide inpatient and outpatient data. We can also stop it from loading into the data model by disabling it from the power query editor. Just right click on the table name in power query and uncheck Enable Load.

- Now since specialty name is one of the key attributes that we are looking in this project, lets focus on that column now. As you have seen in the data, we have a huge number of specialty available and using all of them in our report layer directly will create a clutter in our visualization. A better approach would be to distribute them in buckets. So to do this I have created a specialty mapping file which you will find in the downloaded resources. Lets import that file in power bi to create the relationship with All_Data.

Once you import this file, Power BI should auto detect relationship and connect both the tables. However if it does not then you can do it manually by following below steps:

1. Go to the model view
2. Click on Specialty_Name column in All_Data
3. Drag this column over the Specialty column in Mapping table
Now you should see a line connecting both the tables and an arrow pointing towards All_Data from Mapping table. This means that we have created a relationship between both the tables. The arrow signifies the filter context and tells you that now you can use columns from Mapping table to filter data in All_Data.

## 4.Visualization Blueprint
For this project, I have already created a blueprint, however in live scenarios you will sit down with your team and create a wireframe of the required dashboard. You will then get this approved from the end stakeholder before starting your development activities.
<img width="1536" height="682" alt="image-1-1536x682" src="https://github.com/user-attachments/assets/6cb9088e-bebc-4bbb-a8d9-489cf61fdf9e" />

## 5.Dashboard Layout & Design
Now lets use DAX to create our measures which will be used in our visuals. For now we will create 2 measures for calculating Latest Month & Previous Year Wait List

1. Latest Month Wait List = CALCULATE(SUM(All_Data[Total]),All_Data[Archive_Date] = MAX(All_Data[Archive_Date])) + 0

2. PY Latest Month Wait List = CALCULATE(SUM(All_Data[Total]),All_Data[Archive_Date]= EDATE(MAX(All_Data[Archive_Date]),-12)) + 0
 
Now as per our design blueprint, insert these 2 measures in a card visual. After this create a blank table where we will store calculation method headers, i.e. in our dashboard we want to show Average values and Median values.

So enter a blank table from power bi and enter 2 row items manually i.e. Average & Median. Now with the newly created table create a button slicer, so that user can toggle between the two calculation.

### Now create below measures which will help us get the calculation we need and also to make few chart titles dynamic

1. Median Wait List = MEDIAN(All_Data[Total]) 

2. Average Wait List = AVERAGE(All_Data[Total]) 

3. Avg/Med Wait List = SWITCH(VALUES('Calculation Method'[Calc Method]),"Average",[Average Wait List],"Median",[Median Wait List]) 

4. Dynamic Title = SWITCH(VALUES('Calculation Method'[Calc Method]),"Average","Key Indicators - Patient Wait List (Average)","Median","Key Indicators - Patient Wait List (Median)") 

5. NoDataLeft = IF(ISBLANK(CALCULATE(SUM(All_Data[Total]),All_Data[Case_Type]<>"Outpatient")),"No data for selected criteria","")  

6. NoDataRight = IF(ISBLANK(CALCULATE(SUM(All_Data[Total]),All_Data[Case_Type]="Outpatient")),"No data for selected criteria","")
   
### Summary Page

Now place the charts based on our blueprint i.e doughnut, clustered column chart & top five Multi Row card. And remember to use the new measure which is Avg/Med Wait List in the values section.

Finally in the line chart at the bottom use Total column directly along with the Archive_Date. Remember to add a visual filter for Case_Type. So one chart will show Day Case & Inpatients and the other chart will show Outpatients. Add slicers for Archive_Date, Case_Type and Specialty.

### Detailed View

- Add a new page here add a matrix view using the Archive_Date, Specialty_Name, Age_Profile, Time_Bands, Case_Type and Total.

### Tooltip Page

- Create a new page which will be used as a tooltip. Add a chart to show Specialty and Total waitlist. Also add a card to show the Total sum of Wait List. Now set this page as tooltip by going to formatting >> Page Information >> Enable Allow Use as Tooltip

- Now go back to summary page and select the line chart. General section of formatting, go to Tooltips and select the page i.e. the new tooltip page.

### Beautify the Dashboard

- This is very subjective but I usually go to Google or Adobe Stock website to draw inspiration. Once you have selected a dashboard as your inspiration. Go to Color.Adobe.com to extract the colors from your reference dashboard. Keep a note of these colors somewhere.

- Now you can go to PowerPoint or Canva to design the background of your dashboard. You can play around as much as you like using the colors and different shapes. Once done extract your design as png file and use that image as a background for your Power BI canvas.

* TIP: I Have Created Dashboard Background for all three pages check in the slide(1/2/3).
## 6.Adding Interactivity
Now add interactivity in your dashboard like navigation buttons, chart alt display text and hovering info.

## 7 & 8 Testing and Sharing
Ensure to conduct an extensive UAT session which will identify any bugs or data issues. After this you are ready to share your dashboard with a larger audience. Before sharing/publishing consider Row Level Security features within Power BI services.
## 9.Routine Refresh & Maintenance
Hurraayyy, work is finally done. You can now focus on implementing a BAU process to run monthly refresh process and maintenance.

## These Are The Three pages of Dashboard

### Page 1

<img width="1920" height="1140" alt="Screenshot 2025-09-21 155210" src="https://github.com/user-attachments/assets/1d3925d9-2436-4546-bc4f-72e6b5cb9588" />


### Page 2

<img width="1920" height="1140" alt="Screenshot 2025-09-21 155223" src="https://github.com/user-attachments/assets/4fa92aae-8d6f-47e6-ae9a-5bf2f1f8b6c3" />


### Page 3

<img width="1905" height="942" alt="Screenshot 2025-09-21 160019" src="https://github.com/user-attachments/assets/c8cac17a-9036-485e-a306-4abc4189f107" />
