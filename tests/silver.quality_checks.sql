/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Duplicate primary keys.
	  - checking for NULL values
    - Unwanted spaces in string fields.
    - checking for inconsistent formating across datasets

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
*/
-- ===================================================
--	checking silver.beautyspot_prd_details_inv
-- ===================================================

--	 checking for NULL values
SELECT
	internal,
	part_no,
	details
FROM silver.beautyspot_prd_details_inv
WHERE internal IS NULL OR part_no is null OR details IS NULL;

--	Check for unwanted spaces 
-- Expectation: No result
SELECT
	part_no,
	details
FROM silver.beautyspot_prd_details_inv
WHERE part_no != TRIM(part_no) OR details != TRIM(details);

--	Check for duplicates in the primary key
--	Expectation: No result
SELECT 
	part_no,
	COUNT(part_no) AS dup_check
FROM silver.beautyspot_prd_details_inv
GROUP BY part_no
HAVING COUNT(part_no) > 1;

--	Checking for inconsistent formating
--	Expectation: No result
SELECT
	part_no,
	details
FROM silver.beautyspot_prd_details_inv
WHERE part_no != UPPER(part_no) OR details != UPPER(details);


-- ===================================================
--	checking silver.beautyspot_sales_sls
-- ===================================================

--checking for nulls in quantitative and date columns
--Expectation: No result
SELECT 
	qty,
	sales_N,
	cost_N,
	profit_N,
	sales_date
FROM silver.beautyspot_sales_sls
WHERE qty IS NULL OR 
	sales_N IS NULL OR 
	cost_N IS NULL OR 
	profit_N IS NULL OR 
	sales_date IS NULL;

-- Checking for duplicates and null values in primary key
-- Expectation: No result
SELECT 
	part_no,
	sales_date,
	COUNT(part_no) AS dup_count
FROM silver.beautyspot_sales_sls
GROUP BY 
	part_no,
	sales_date
HAVING COUNT(part_no) > 1 OR part_no IS NULL;

-- Checking for nulls in product_name
-- Expectation: No result
SELECT
	part_no,
	product_name
FROM silver.beautyspot_sales_sls
WHERE product_name IS NULL;


