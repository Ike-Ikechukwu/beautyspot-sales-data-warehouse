/*
========================================================
Create Database and Schemas
========================================================
Script Purpose:
	This Script creates a new Database named 'beauty_spot_DW
	along with three schemas named 'bronze', 'silver', and 
	'gold' within the database afer checking if it exists.

WARNING:
	Running this script will drop the entire 'DataWarehouse'
	database ie. All data in the database will be permantly
	deleted. Please proceed with caution and ensure you have 
	proper backups before running the script.
*/

USE master;

-- Drop and recreate the 'DataWarehouse' database if it exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'beauty_spot_DW')
BEGIN
	DROP DATABASE beauty_spot_DW;
END;
GO

--Create the 'beauty_spot_DW' database
CREATE DATABASE beauty_spot_DW;
GO

USE beauty_spot_DW;
GO

--Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
