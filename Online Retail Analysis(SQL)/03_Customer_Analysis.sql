-- Identify the customers who generated the highest sales revenue
-- to understand which customers are the most valuable to the business
Select
	Customer_ID,
	COUNT(DISTINCT Invoice) AS Total_Orders,
	SUM(Quantity * Price) As Total_Sales
From online_retail_cleaned
WHERE Transaction_Type = 'Sales'
	AND Customer_ID IS NOT NULL
Group By Customer_ID
Order By Total_Sales DESC;



-- Compare customers based on their average order value
-- to understand whether high-value customers are driven by larger orders
-- rather than simply placing more orders
Select 
	Customer_ID,
	COUNT(DISTINCT Invoice) AS Total_Orders,
	SUM(Quantity * Price) AS Total_Sales,
	SUM(Quantity * Price) / COUNT(DISTINCT Invoice) AS Average_Order_Value
From online_retail_cleaned
WHERE Transaction_Type = 'Sales'
	AND Customer_ID IS NOT NULL 
Group By Customer_ID
ORDER By Average_Order_Value DESC;



-- Compare the top revenue-generating customers
-- to understand how order frequency and average order value contribute to customer value
Select Top 10
	Customer_ID,
	COUNT(DISTINCT Invoice) AS Total_Orders,
	SUM(Quantity * Price) AS Total_Sales,
	SUM(Quantity * Price) / COUNT(DISTINCT Invoice) AS Average_Order_Value
From online_retail_cleaned
WHERE Transaction_Type = 'Sales'
	AND Customer_ID IS NOT NULL 
Group By Customer_ID
ORDER By Average_Order_Value DESC;



-- Segment customers based on their purchase frequency
-- to understand the distribution of one-time and repeat customers
WITH CustomerOrders AS (
    SELECT 
        Customer_ID,
        COUNT(DISTINCT Invoice) AS Total_Orders
    FROM online_retail_cleaned
    WHERE Transaction_Type = 'Sales'
      AND Customer_ID IS NOT NULL
    GROUP BY 
        Customer_ID
),
CustomerSegments AS (
    SELECT 
        Customer_ID,
        CASE 
            WHEN Total_Orders = 1 THEN '1 Order'
            WHEN Total_Orders BETWEEN 2 AND 5 THEN '2-5 Orders'
            WHEN Total_Orders BETWEEN 6 AND 10 THEN '6-10 Orders'
            ELSE '10+ Orders'
        END AS Customer_Segment
    FROM CustomerOrders
)
SELECT 
    Customer_Segment,
    COUNT(Customer_ID) AS Number_of_Customers
FROM CustomerSegments
GROUP BY 
    Customer_Segment
ORDER BY 
    CASE Customer_Segment
        WHEN '1 Order' THEN 1
        WHEN '2-5 Orders' THEN 2
        WHEN '6-10 Orders' THEN 3
        WHEN '10+ Orders' THEN 4
    END;



-- Compare sales contribution across customer segments
-- to identify which customer segments generate the most revenue
WITH CustomerMetrics AS (
    SELECT 
        Customer_ID,
        COUNT(DISTINCT Invoice) AS Total_Orders,
        SUM(Quantity * Price) AS Total_Sales
    FROM online_retail_cleaned
    WHERE Transaction_Type = 'Sales'
      AND Customer_ID IS NOT NULL
    GROUP BY 
        Customer_ID
),
CustomerSegments AS (
    SELECT 
        Customer_ID,
        Total_Sales,
        CASE 
            WHEN Total_Orders = 1 THEN '1 Order'
            WHEN Total_Orders BETWEEN 2 AND 5 THEN '2-5 Orders'
            WHEN Total_Orders BETWEEN 6 AND 10 THEN '6-10 Orders'
            ELSE '10+ Orders'
        END AS Customer_Segment
    FROM CustomerMetrics
)
SELECT 
    Customer_Segment,
    COUNT(Customer_ID) AS Number_of_Customers,
    SUM(Total_Sales) AS Total_Sales
FROM CustomerSegments
GROUP BY 
    Customer_Segment
ORDER BY 
    CASE Customer_Segment
        WHEN '1 Order' THEN 1
        WHEN '2-5 Orders' THEN 2
        WHEN '6-10 Orders' THEN 3
        WHEN '10+ Orders' THEN 4
    END;



-- Compare average order value across customer frequency segments
-- to determine whether high-frequency customers also place higher-value orders
WITH CustomerMetrics AS (
    SELECT 
        Customer_ID,
        COUNT(DISTINCT Invoice) AS Total_Orders,
        SUM(Quantity * Price) AS Total_Sales
    FROM online_retail_cleaned
    WHERE Transaction_Type = 'Sales'
      AND Customer_ID IS NOT NULL
    GROUP BY 
        Customer_ID
),
CustomerSegments AS (
    SELECT 
        Customer_ID,
        Total_Orders,
        Total_Sales,
        CASE 
            WHEN Total_Orders = 1 THEN '1 Order'
            WHEN Total_Orders BETWEEN 2 AND 5 THEN '2-5 Orders'
            WHEN Total_Orders BETWEEN 6 AND 10 THEN '6-10 Orders'
            ELSE '10+ Orders'
        END AS Customer_Segment
    FROM CustomerMetrics
)
SELECT 
    Customer_Segment,
    COUNT(Customer_ID) AS Number_of_Customers,
    SUM(Total_Orders) AS Total_Orders,
    SUM(Total_Sales) AS Total_Sales,
    SUM(Total_Sales) / SUM(Total_Orders) AS Average_Order_Value
FROM CustomerSegments
GROUP BY 
    Customer_Segment
ORDER BY 
    CASE Customer_Segment
        WHEN '1 Order' THEN 1
        WHEN '2-5 Orders' THEN 2
        WHEN '6-10 Orders' THEN 3
        WHEN '10+ Orders' THEN 4
    END;



-- Identify customers with high sales but low purchase frequency
-- to find potentially valuable customers who may not be retained yet
WITH CustomerMetrics AS (
    SELECT 
        Customer_ID AS Customer_ID,
        COUNT(DISTINCT Invoice) AS Total_Orders,
        SUM(Quantity * Price) AS Total_Sales,
        SUM(Quantity * Price) / COUNT(DISTINCT Invoice) AS Average_Order_Value
    FROM online_retail_cleaned
    WHERE Transaction_Type = 'Sales'
      AND Customer_ID IS NOT NULL
    GROUP BY 
        Customer_ID
)
SELECT 
    Customer_ID,
    Total_Orders,
    Total_Sales,
    Average_Order_Value
FROM CustomerMetrics
WHERE Total_Orders <= 5
  AND Total_Sales > (SELECT AVG(Total_Sales) FROM CustomerMetrics)
ORDER BY 
    Total_Sales DESC;


-- Identify customers who have both high purchase frequency and high total sales
-- to find the most valuable and engaged customer segment
WITH CustomerMetrics AS (
    SELECT 
        Customer_ID AS Customer_ID,
        COUNT(DISTINCT Invoice) AS Total_Orders,
        SUM(Quantity * Price) AS Total_Sales,
        SUM(Quantity * Price) / COUNT(DISTINCT Invoice) AS Average_Order_Value,
        NTILE(5) OVER (ORDER BY SUM(Quantity * Price) ASC) AS Sales_Quintile
    FROM online_retail_cleaned
    WHERE Transaction_Type = 'Sales'
      AND Customer_ID IS NOT NULL
    GROUP BY 
        Customer_ID
)
SELECT 
    Customer_ID,
    Total_Orders,
    Total_Sales,
    Average_Order_Value
FROM CustomerMetrics
WHERE Total_Orders > 5          
  AND Sales_Quintile = 5       
ORDER BY 
    Total_Sales DESC;