/*==========================================================================
Script Purpose:
		This script creates a view that validates the monthly total sales
		summary to ensure aggregation accuracy and data consistency before
		the dataset is used for reporting or analysis.
============================================================================
Usage: Query the view "gold.overall_monthly_sales_report"
============================================================================
*/

IF OBJECT_ID('gold.overall_monthly_sales_report', 'V') IS NOT NULL
	DROP VIEW gold.overall_monthly_sales_report;
GO
CREATE VIEW gold.overall_monthly_sales_report AS
SELECT
	1 AS rownumber,
	'Aug-2025' AS sales_month,
	SUM(quantity) AS quantity,
	SUM(sales_amount_NGN) AS total_sales,
	ROUND(SUM(total_cost_NGN), 2) AS total_cost,
	ROUND(SUM(total_profit_NGN), 2) AS total_profit
	FROM gold.beautyspot_sales_report
WHERE sales_date = '2025-08-01'
UNION ALL
SELECT 
	2,
	'Sep-2025',
	SUM(quantity),
	SUM(sales_amount_NGN),
	ROUND(SUM(total_cost_NGN), 2),
	ROUND(SUM(total_profit_NGN), 2)
	FROM gold.beautyspot_sales_report
WHERE sales_date = '2025-09-01'
UNION ALL
SELECT 
	3,
	'Oct-2025',
	SUM(quantity),
	SUM(sales_amount_NGN),
	ROUND(SUM(total_cost_NGN), 2),
	ROUND(SUM(total_profit_NGN), 2)
	FROM gold.beautyspot_sales_report
WHERE sales_date = '2025-10-01'
UNION ALL
SELECT 
	4,
	'Nov-2025',
	SUM(quantity),
	SUM(sales_amount_NGN),
	ROUND(SUM(total_cost_NGN), 2),
	ROUND(SUM(total_profit_NGN), 2)
	FROM gold.beautyspot_sales_report
WHERE sales_date = '2025-11-01'
UNION ALL
SELECT 
	5,
	'Dec-2025',
	SUM(quantity),
	SUM(sales_amount_NGN),
	ROUND(SUM(total_cost_NGN), 2),
	ROUND(SUM(total_profit_NGN), 2)
	FROM gold.beautyspot_sales_report
WHERE sales_date = '2025-12-01'
