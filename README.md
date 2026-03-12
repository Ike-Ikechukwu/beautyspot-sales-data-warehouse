# BeautySpot Sales Analytics Project


## Overview
This project focuses on transforming raw retail sales reports and inventory product data into a structured analytics workflow using SQL Server and Power BI.

The goal was to take unstructured monthly reports, clean and standardize the data, organize it within a layered data warehouse, and then build a dashboard that provides clear insight into product and category performance.

The final output includes:

-  A Bronze–Silver–Gold data warehouse built in SQL Server
-  Product categorization using SQL
-  Category performance and revenue contribution analysis
-  A Power BI dashboard for business reporting

## Tools Used
-  Excel Power Query: Extract and prepare data from PDF reports
-  SQL Server: Data storage, transformation, and analysis
-  Power BI: Data visualization and reporting
-  GitHub: Project documentation and version control

## Data Sources
Two datasets were used for this project.

1. **Monthly Sales Reports**

The sales reports were provided as five monthly PDF files.

Each report contained the following columns:

-  Group(product description)
-  Quantity
-  Discount N
-  %
-  Sales N
-  %
-  Cost N
-  Profit N
-  %

**Note:** The Product Description column(Group) contained both the part number and product name, which required additional transformation.

2. **Inventory Product Dataset**

The inventory dataset contained product reference information.

Columns included:
-  internal
-  part_no
-  details (product name)
-  category

This dataset was used to help identify products and support the categorization process.

## Data Preparation

Since the sales reports were provided in PDF format, the first step involved extracting and cleaning the data using Excel Power Query.

Each monthly report was imported and transformed using the same process.

**Transformations performed**:

-  Removed unnecessary columns such as discount and percentage fields
-  Split the Product Description column into: part_no and product_name
-  Added a sales_date column to identify the reporting month
-  Verified data types for all columns

Once the transformations were complete, the five datasets were appended into a single dataset.

The final dataset was exported as a CSV file and loaded into SQL Server.

## Data Warehouse Design

A layered data warehouse structure was implemented using Medallion Architecture.

The database created for the project: beauty_spot_DW

Schemas used: bronze, silver and gold

click to view script

Each layer serves a different purpose:

-  Bronze	Store raw data
-  Silver	Clean and standardize data
-  Gold	Create analytical views for reporting

### Bronze Layer

The Bronze layer stores the raw datasets exactly as they were received.

The CSV files were imported using the SQL Server Flat File Import Wizard.

Tables created:
-  bronze.beautyspot_sales_sls
-  bronze.beautyspot_prd_details_inv

No transformations were performed at this stage.
The goal was simply to preserve the original data for reference and traceability.

### Silver Layer: Data Cleaning and Structuring

The silver layer is were the data was cleaned and standardized

**Creating The Silver Tables** 
Two tables were created in this layer:

-  silver.beautyspot_sales_sls
-  silver.beautyspot_prd_details_inv

click to view the script.

Before moving data from bronze into the Silver layer, the tables structure were created and several quality checks were performed.
**Data Quality Checks**
The following data quality checks were performed:

-  Checking for duplicate part numbers
-  Identifying null values in text, numeric, and date columns
-  Removing unwanted spaces in string fields
-  Verifying consistent formatting

click to view the script.

**Data Discrepancy Investigation**

During validation, 15 part numbers from the sales dataset did not match records in the inventory dataset.

After raising the issue with the inventory officer, it was confirmed that:

Some products had previously shared the same part number and the part numbers had been manually updated internally

The inventory officer provided complete product names for those records so they could still be categorized correctly

click to view script

**Data Insertion**
-  The inventory data was cleaned and inserted into the table "silver.beautyspot_prd_details_inv
-  The sales data was also cleaned and structured before being loaded into the table "silver.beautyspot_sales_sls.
To enrich the sales data with  product information a LEFT JOIN was performed using the part number.
For matched records product information from the product table were used while For unmatched records, the product names provided by the inventory officer were manually included.
click to view scripts

### Gold layer
The Gold Layer contains business ready viiews designed for analysis and reporting. This views apply business logic and prepare the data for use in SQL analysis and Power BI dashboards.

### Sales Analysis View & Product Categorization
To support business analysis and reporting, a primary analytical view was created in the Gold layer known as "gold.beautyspot_sales_sls"

This view serves as the main reporting dataset and contains all fields required for analysis. It pulls the cleaned sales data from the Silver layer and introduces a product category column used for performance analysis.

Product categorization was implemented directly within this view.
The categorization process involved:
1.  Extracting distinct product names from the dataset.
2.  Identifying category groups used by the business.
3.  Generating keyword mappings associated with each category.
4.  implementing a SQL CASE statement to assign categories based on product name keywords.

This logic allows products to be automatically classified into categories during query execution.
Example Structure of the View
The view includes the following fields:
part_no
product_name
category
quantity_sold
cost_amount
sales_amount
profit_amount
sales_date
This view acts as the central dataset used for both SQL analysis and the Power BI dashboard, ensuring that all reporting and visualizations are based on the same structured and categorized sales data.

click to view script.

### Monthly Sales Summary Validation

A monthly summary view was created to validate the transformed dataset against the original PDF sales reports. Key metrics such as total quantity sold, revenue, cost, and profit were aggregated by month and compared with the source reports to ensure the numbers matched

click to view script

## Analysis

### Category Performance Analysis
Using the gold.beautyspot_sales_sls view, a category-level analysis was performed to evaluate the contribution of each product category.
The analysis calculated:
Number of products per category
Total quantity sold
Total cost
Total revenue
Total profit
Revenue contribution percentage
This analysis helps identify which product categories generate the most revenue and profit for the business.

click to view script

### Budget Allocation Model
A simple budget allocation model was developed based on category revenue contribution.
The idea was to distribute a marketing or purchasing budget across product categories according to their revenue performance.
Example formula:
Revenue Allocation = New Budget × Revenue Contribution
This approach ensures that higher-performing categories receive a proportionally larger share of the budget.

click to view script.

## Power BI Dashboard

A Power BI dashboard was built on top of the Gold layer view gold.beautyspot_sales_sls to visualize key business metrics.

**Key Performance Indicators:**
-  Unique Products
-  Total Quantity Sold
-  Total Cost
-  Total Revenue
-  Total Profit

**Visualizations**
-  The dashboard includes:
-  Monthly Revenue Trend
-  Category Performance
-  Profit Contribution (%)
-  Top Performing Products
-  Bottom Performing Products

These visuals allow stakeholders to quickly understand overall sales performance and identify high and low performing products.

(Insert dashboard screenshot here)

