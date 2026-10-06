

create or alter procedure bronze.load_bronze as
begin
	declare @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	Begin try
	set @batch_start_time = GETDATE();
print '============================================';
print 'loading bronze layer';
print '============================================';

print '--------------------------------------------';
print 'loading crm tables';
print '--------------------------------------------';

set @start_time = GETDATE();
print '>>truncating table: bronze.crm_cust_info'
truncate table bronze.crm_cust_info;

print '>> inserting  data into: bronze.crm_cust_info'
bulk insert  bronze.crm_cust_info
from 'C:\SQLData\cust_info.csv'
with(
	Firstrow=2,
	fieldterminator = ',',
	tablock

	);
	set @end_time=getdate();
	print '>> load duration: '+ cast(datediff(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	select count(*) from bronze.crm_cust_info
	
	set @start_time = GETDATE();
	print '>>truncating table: bronze.crm_prd_info'
	truncate table bronze.crm_cust_info;

print '>> inserting  data into: bronze.crm_prd_info'
bulk insert  bronze.crm_prd_info
from 'C:\SQLData\source_crm\prd_info.csv'
with(
	Firstrow=2,
	fieldterminator = ',',
	tablock

	);set @end_time=getdate();
	print '>> load duration: '+ cast(datediff(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	select count(*) from bronze.crm_prd_info
	
	set @start_time = GETDATE();
	print '>>truncating table: bronze.crm_sales_details'
	truncate table bronze.crm_sales_details;
	print '>> inserting  data into: bronze.crm_sales_details'
bulk insert  bronze.crm_sales_details
from 'C:\SQLData\source_crm\sales_details.csv'
with(
	Firstrow=2,
	fieldterminator = ',',
	tablock

	);
	set @end_time=getdate();
	print '>> load duration: '+ cast(datediff(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	select count(*) from bronze.crm_sales_details

	
print '--------------------------------------------';
print 'loading erp tables';
print '--------------------------------------------';

set @start_time = GETDATE();
print '>>truncating table: bronze.erp_cust_az12'
truncate table bronze.erp_cust_az12;
print '>> inserting  data into: bronze.erp_cust_az12'
bulk insert  bronze.erp_cust_az12
from 'C:\SQLData\source_erp\cust_az12.csv'
with(
	Firstrow=2,
	fieldterminator = ',',
	tablock

	);
	set @end_time=getdate();
	print '>> load duration: '+ cast(datediff(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	select count(*) from bronze.erp_cust_az12

set @start_time = GETDATE();
	print '>>truncating table: bronze.erp_loc_a101'
	truncate table bronze.erp_loc_a101;
	print '>> inserting  data into: bronze.erp_loc_a101'
bulk insert  bronze.erp_loc_a101
from 'C:\SQLData\source_erp\loc_a101.csv'
with(
	Firstrow=2,
	fieldterminator = ',',
	tablock

	);
	set @end_time=getdate();
	print '>> load duration: '+ cast(datediff(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	select count(*) from bronze.erp_loc_a101
	
	set @start_time = GETDATE();
print '>>truncating table: bronze.erp_px_cat_g1v2'
truncate table bronze.erp_px_cat_g1v2;
print '>> inserting  data into: bronze.erp_px_cat_g1v2'
bulk insert  bronze.erp_px_cat_g1v2
from 'C:\SQLData\source_erp\px_cat_g1v2.csv'
with(
	Firstrow=2,
	fieldterminator = ',',
	tablock

	);
	set @end_time=getdate();
	print '>> load duration: '+ cast(datediff(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	set @batch_end_time=getdate();
	print '========================================'
	print 'loading bronze layer is completed';
	print '>> Total load duration: '+ cast(datediff(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
	print '========================================'
	select count(*) from bronze.erp_px_cat_g1v2
	end try
	begin catch
	 print '========================================'
	 print 'ERROR OCCURED DURING LOADING BRONZE LAYER'
	 print 'Error message'+ ERROR_MESSAGE();
	 print 'Error message'+ CAST(ERROR_NUMBER() AS NVARCHAR);
	 print 'Error message'+ CAST(ERROR_STATE() AS NVARCHAR);
	 print '========================================'
	end catch
	end;

	


	
