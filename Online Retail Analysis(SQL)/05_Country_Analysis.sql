-- Identify the countries that generate the highest sales
-- to understand which markets contribute the most revenue
Select
	Country,
	SUM(Quantity * Price) As Total_Sales
From online_retail_cleaned
WHERE Transaction_Type = 'Sales'
Group By Country
Order BY Total_Sales DESC;



-- Compare the number of orders across countries
-- to determine whether the UK's sales dominance is also driven by higher order volume
Select 
	Country,
	COUNT(DISTINCT Invoice) AS Total_Orders
From online_retail_cleaned
WHERE Transaction_Type = 'Sales'
Group By Country
Order By Total_Orders DESC;