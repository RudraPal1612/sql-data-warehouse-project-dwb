/*
============================================================================
Stored Procedure: Bronze Layer
============================================================================
Script Purpose:
  This stored procedure loads data into the 'bronze' schema from the external csv files.
  It performs the following action:
  - Truncates the bronze layer before loading the data
  - Uses the 'BULK INSERT' command to load the csv files into the bronze tables.

Parameters:
  None.
  This strored procedure does not accept any parameters or returns any values.

Usage Example:
  EXEC bronze.load_bronze
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME,@end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME
	SET @batch_start_time = GETDATE()
	BEGIN TRY
		PRINT('=================================================')
		PRINT('Loading Bronze Layer....')
		PRINT('=================================================')
	
		PRINT('-------------------------------------------------')
		PRINT('Loading CRM Tables.')
		PRINT('-------------------------------------------------')

		SET @start_time = GETDATE()
		PRINT('>>Truncating Table: bronze.crm_cust_info')
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT('>>Inseting Data Into Table: bronze.crm_cust_info')
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Study Material\Data Engineering\sql-data-warehouse-project-main\01_datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',', 
			TABLOCK 
		);
		SET @end_time = GETDATE()
		PRINT '<<Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + ' seconds';
		PRINT '----------------------------'

		SET @start_time = GETDATE()
		PRINT('>>Truncating Table: bronze.crm_prd_info')
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT('>>Inseting Data Into Table: bronze.crm_prd_info')
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Study Material\Data Engineering\sql-data-warehouse-project-main\01_datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',', 
			TABLOCK 
		SET @end_time = GETDATE()
		PRINT '<<Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + ' seconds';
		PRINT '----------------------------'

		SET @start_time = GETDATE()
		PRINT('>>Truncating Table: bronze.crm_sales_details')
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT('>>Inseting Data Into Table: bronze.crm_sales_details')
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Study Material\Data Engineering\sql-data-warehouse-project-main\01_datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',', 
			TABLOCK 
		);
		SET @end_time = GETDATE()
		PRINT '<<Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + ' seconds';
		PRINT '----------------------------'

		PRINT('-------------------------------------------------')
		PRINT('LOADING ERP TABLES.')
		PRINT('-------------------------------------------------')

		SET @start_time = GETDATE()
		PRINT('>>Truncating Table: bronze.erp_CUST_AZ12')
		TRUNCATE TABLE bronze.erp_CUST_AZ12;
		PRINT('>>Inseting Data Into Table: bronze.erp_CUST_AZ12')
		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'C:\Study Material\Data Engineering\sql-data-warehouse-project-main\01_datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',', 
			TABLOCK 
		);
		SET @end_time = GETDATE()
		PRINT '<<Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + ' seconds';
		PRINT '----------------------------'

		SET @start_time = GETDATE()
		PRINT('>>Truncating Table: bronze.erp_LOC_A101')
		TRUNCATE TABLE bronze.erp_LOC_A101;
		PRINT('>>Inseting Data Into Table: bronze.erp_LOC_A101')
		BULK INSERT bronze.erp_LOC_A101
		FROM 'C:\Study Material\Data Engineering\sql-data-warehouse-project-main\01_datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',', 
			TABLOCK 
		);
		SET @end_time = GETDATE()
		PRINT '<<Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + ' seconds';
		PRINT '----------------------------'

		SET @start_time = GETDATE()
		PRINT('>>Truncating Table: bronze.erp_PX_CAT_G1V2')
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
		PRINT('>>Inseting Data Into Table: bronze.erp_LOC_A101')
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'C:\Study Material\Data Engineering\sql-data-warehouse-project-main\01_datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE()
		PRINT '<<Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + ' seconds';
		PRINT '----------------------------'
		SET @batch_end_time = GETDATE()
		PRINT '***************************'
		PRINT 'Loading Bronze Layer is Completed'
		PRINT 'Batch Load Duration:' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + ' seconds';
	END TRY
	BEGIN CATCH
	PRINT('===================================================')
	PRINT('Error Occured during loading the Bronze Layer');
	PRINT 'Error Message' + ERROR_MESSAGE();
	PRINT 'Error Number' + CAST(ERROR_NUMBER() AS VARCHAR);
	PRINT 'Error State' + CAST(ERROR_STATE() AS VARCHAR);
	PRINT('===================================================')
	END CATCH
END
