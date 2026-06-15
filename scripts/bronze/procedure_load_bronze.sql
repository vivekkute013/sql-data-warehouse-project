/*
=====================================================================================================================================
Stored Procedures : Load Bronze Layer (Source -> Bronze)
=====================================================================================================================================
Script Purpose : 
    This stored procedure loads data into the 'bronze' schema from external csv files.
    It perform the following actions :
        - Truncate the bronze tables before loading data.
        - Uses the 'BULK INSERT' command to load data from csv files to bronze tables.

Parameters : 
    None.
  no parameters nor returns any values.

Usage Example : 
    EXEC bronze.load_bronze;
=====================================================================================================================================
*/


-- Create stored procedures --
create or alter procedure bronze.load_bronze as
begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
	begin try
	set @batch_start_time = getdate();
		print '==================================================================='
		print 'Loading the Bronze Layer'
		print '==================================================================='
		--------------------------------------------------------------------------
		print '--------------------------------------------------------------------'
		print 'Loading CRM Table'
		print '--------------------------------------------------------------------'

		set @start_time = getdate();
		print '>> Truncating table : bronze.crm_cust_info'
		truncate table bronze.crm_cust_info;

		print '>> Inserting Data into table : bronze.crm_cust_info'
		bulk insert bronze.crm_cust_info
		from 'D:\Laptop Data\SQL - Data WareHouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print '>> Load duration : ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		
		-----------------------------------------------------------------------------------------------------
		print '-------------------------------------------------------------------------------'
		print '>> Truncating table : bronze.crm_prd_info'
		truncate table bronze.crm_prd_info;

		print '>> Inserting Data into table : bronze.crm_prd_info'
		bulk insert bronze.crm_prd_info
		from 'D:\Laptop Data\SQL - Data WareHouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		-------------------------------------------------------------------------------
		print '>> Truncating table : bronze.crm_sales_details'
		truncate table bronze.crm_sales_details

		print '>> Inserting Data into table : bronze.crm_sales_details'
		bulk insert bronze.crm_sales_details
		from 'D:\Laptop Data\SQL - Data WareHouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		-------------------------------------------------------------------------------
		print '--------------------------------------------------------------------'
		print 'Loading ERP Table'
		print '--------------------------------------------------------------------'

		print '>> Truncating table : bronze.erp_cust_az12'
		truncate table bronze.erp_cust_az12

		print '>> Inserting Data into table : bronze.erp_cust_az12'
		bulk insert bronze.erp_cust_az12
		from 'D:\Laptop Data\SQL - Data WareHouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		-----------------------------------------------------------------------------
		print '>> Truncating table : bronze.erp_loc_a101'
		truncate table bronze.erp_loc_a101

		print '>> Inserting Data into table : bronze.erp_loc_a101'
		bulk insert bronze.erp_loc_a101
		from 'D:\Laptop Data\SQL - Data WareHouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		-------------------------------------------------------------------------------
		print '>> Truncating table : bronze.erp_px_cat_g1v2'
		truncate table bronze.erp_px_cat_g1v2

		print '>> Inserting Data into table : bronze.erp_px_cat_g1v2'
		bulk insert bronze.erp_px_cat_g1v2
		from 'D:\Laptop Data\SQL - Data WareHouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		
		set @batch_end_time = getdate();
		print '============================================================'
		print 'Bronze Layer Time Duration : ' + cast(datediff(second, @batch_start_time, @batch_end_time) as nvarchar) + 'seconds';
		print '============================================================'
	end try
	begin catch
	print '=========================================================='
	print 'ERROR OCCURED DURING LOADING BRONZE LAYER'
	print 'Error Message' + ERROR_MESSAGE();
	print 'Error Message' + CAST(ERROR_NUMBER() as nvarchar);
	print 'Error Message' + CAST(ERROR_STATE() as nvarchar);
	print '=========================================================='
	end catch
end

--------------------------------------------------------------------------------
--  executing procedure once --------------------
--  add prints to track execution, debug issues and understand its flow -----------
--- add try and catch for error handling, data integrity and issue logging -----
exec bronze.load_bronze 

---------------------------------------------------------------------------------
