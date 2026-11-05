/*
=============================================================
Create Database and Schema
=============================================================
Script Purpose:
	This script creates a new database called DataWarehouse_dwb after checking if it
	already exists. If the database exists,it is dropped and recreated.Additionally,
	the script sets up three schemas within the database: 'bronze', 'silver' and 'gold'.

Warning:
	Running this script will drop the entire 'DataWarehouse_dwb' Database if it already
	exists. All data in the database will be permanently deleted.Proceed with caution
	and ensure you have proper backup before running this script
*/

USE master;
GO

--Drop and recreate 'DataWarehouse_dwb' Database (set singleuser line disconnects all users from db and locks it so that only the administrator can access it)
IF EXISTS (SELECT 1 FROM sys.databases where name='DataWarehouse_dwb')
BEGIN
	ALTER DATABASE DataWarehouse_dwb set SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse_dwb;
END;
GO

--Create the Database 'DataWarehouse_dwb'
CREATE DATABASE DataWarehouse_dwb;
GO

--Use the database
USE DataWarehouse_dwb;

--Create Schema 
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
