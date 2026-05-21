create or alter procedure bronze.load_bronze as 

begin 
	declare @start_time datetime, @end_time datetime @start_time_batch datetime, @end_time_batch datetime;
	begin try
	set @start_time_batch = getdate();
		print'===========================================';
		print 'Loading Bronze Layer'
		Print '------------------------------------------' ;
		print 'Loading CRM tables';

	set @start_time = GETDATE();
		TRUNCATE table bronze.crm_cust_info;
		bulk insert bronze.crm_cust_info
		from 'C:\Users\Karthik V\Desktop\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
	set @end_time = GETDATE();
	print 'Load Duration for cust_info:' +  CAST(datediff(second, @start_time, @end_time) as VARCHAR) + ' seconds';
 
	set @start_time = GETDATE();
		TRUNCATE table bronze.crm_prd_info;
		bulk insert bronze.crm_prd_info
		from 'C:\Users\Karthik V\Desktop\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
	set @end_time = getdate();
	print 'Load duration for prd_info: ' + cast(datediff(second, @start_time, @end_time) as varchar ) + 'seconds';


	set @start_time = getdate();
		truncate table bronze.crm_sales_details;
		bulk insert bronze.crm_sales_details
		from 'C:\Users\Karthik V\Desktop\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
	set @end_time = getdate();
	print 'Load duration for sales_details: ' + cast(datediff(second, @start_time, @end_time) as varchar ) + 'seconds';

	print '------------------------------------------------------------';
	print 'Loading ERM tables';
		truncate table bronze.erp_cust_az12;
		bulk insert bronze.erp_cust_az12
		from 'C:\Users\Karthik V\Desktop\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
	set @end_time = getdate();
	print 'Load duration for erp_cust_az12: ' + cast(datediff(second, @start_time, @end_time) as varchar ) + 'seconds';


	set @start_time = getdate();
		truncate table bronze.erp_loc_a101;
		bulk insert bronze.erp_loc_a101
		from 'C:\Users\Karthik V\Desktop\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
	set @end_time = getdate();
	print 'Load duration for erp_loc_a101: ' + cast(datediff(second, @start_time, @end_time) as varchar ) + 'seconds';
		
	set @start_time = getdate();
		truncate table bronze.erp_px_cat_g1v2;
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\Users\Karthik V\Desktop\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
	set @end_time = getdate();
	print 'Load duration for px_cat_g1v2: ' + cast(datediff(second, @start_time, @end_time) as varchar ) + 'seconds';

	Print '=======================================================';
set @end_time_batch = getdate(); 
print 'total time to load the bronze layer:' + cast(datediff(second, @start_time_batch, @end_time_batch) as varchar) + ' seconds';

		end try
		begin catch
	Print 'Error Message: ' + error_message();
	Print 'Error Number: ' + cast(error_number() as varchar(10));
	Print 'Error Line: ' + cast(error_line() as varchar(10));
		end catch 

END



