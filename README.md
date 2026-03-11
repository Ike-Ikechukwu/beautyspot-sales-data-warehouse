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
-  Split the Product Description column into:
  -  part_no
  -  product_name
-  Added a sales_date column to identify the reporting month
-  Verified data types for all columns

Once the transformations were complete, the five datasets were appended into a single dataset.

The final dataset was exported as a CSV file and loaded into SQL Server.
