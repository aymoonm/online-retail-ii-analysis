-- Validation 1: Check the total number of rows loaded into SQL Server
Select Count(*) AS Total_Rows
From online_retail_cleaned;

-- Validation 2: Check the distribution of transaction types loaded into SQL Server
Select
	Transaction_Type,
	Count(*) AS Number_of_Transactions
From online_retail_cleaned
Group By Transaction_Type
Order By Number_of_Transactions DESC;

-- Validation 3: Check the data types of all columns loaded into SQL Server
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'online_retail_cleaned'
ORDER BY ORDINAL_POSITION; 

-- Validation 4: Check the number of NULL values in important columns
Select
	Count(*) - Count(Description) AS Missing_Description,
	Count(*) - Count([Customer_ID]) AS missing_Customer_ID,
    COUNT(*) - COUNT(Invoice) AS Missing_Invoice,
    COUNT(*) - COUNT(StockCode) AS Missing_StockCode,
    COUNT(*) - COUNT(Quantity) AS Missing_Quantity,
    COUNT(*) - COUNT(Price) AS Missing_Price,
    COUNT(*) - COUNT(InvoiceDate) AS Missing_InvoiceDate,
    COUNT(*) - COUNT(Country) AS Missing_Country,
    COUNT(*) - COUNT(Transaction_Type) AS Missing_Transaction_Type
FROM online_retail_cleaned;

-- Validation 5: Check the transaction date range loaded into SQL Server
Select 
	MIN(InvoiceDate) AS Frist_Transaction_Date,
	MAX(InvoiceDate) AS Last_Transaction_Date
From online_retail_cleaned