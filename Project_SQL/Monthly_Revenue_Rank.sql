WITH revenue AS (
SELECT Sale_ID,
Quantity,
Price,
Discount_Percent,
Product_Category,
Transaction_DateTime ::date AS Transaction_Date,
Transaction_DateTime ::time AS Transaction_Time,
EXTRACT(YEAR FROM Transaction_DateTime) AS Year,
EXTRACT(MONTH FROM Transaction_DateTime) AS Month,
ROUND((Price * Quantity)*(1-Discount_Percent/100),2) AS Total_Revenue
FROM sales
),monthly_revenue AS
(SELECT Month, Product_Category,
SUM(Total_Revenue) AS Mon_Revenue
FROM revenue
GROUP BY Month, Product_Category
ORDER BY Month DESC
)

SELECT Month,Product_Category, Mon_Revenue,
RANK() OVER (PARTITION BY Month ORDER BY Mon_Revenue DESC) AS Revenue_Rank
FROM monthly_revenue
ORDER BY Month;
    
