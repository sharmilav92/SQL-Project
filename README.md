# SQL DATA ANALYSIS PROJECT

## Introduction
    This Project analyzes on retail transactions dataset (with 100,000 rows) to have a view on month wise total revenve with ranking, Consective purchase dates of a customer and identifying the repetitive customer on same day

## Tools Used
- SQL
- Database : PostgreSQL
- VS Code
- Git & GitHub

## Dataset
- Source : Kaggle
- Subject : Retail Transaction Dataset
- No. of Rows : 100,000
- Column Details: 
    - Sale_ID
    - Customer_ID
    - Product_ID
    - Quantity
    - Price
    - Transaction_DateTime
    - Payment_Method
    - Store_Location
    - Product_Category
    - Discount_Percent

## Data Loading:

- Step 1 : CONNECTING TO DATABASE THROUGH COMMAND PROMPT
    "File Path" -U postgres -d database_name
- Step 2 : INSERTING THE DATA 
   [Project_SQL folder](/Project_SQL/Load_Data.sql)

## Data Analysis:
    This helps to identify the sales perspective of the business and is breakdown into three parts.

    1. RANK BASED ON MONTHLY REVENUE:
        This Query helps in identifying the Montly revenue based on the transactions performed and grouped based on product category. Ranking is also done to identify the top and bottom product category based on Montly revenue.
```sql
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
```
    2. NEXT PURCHASE DATES OF CUSTOMER:
        This helps in identifying whether customers are repetitive for transactions.

```sql

SELECT a.Customer_ID, 
a.Transaction_DateTime ::date AS First_Purchase,
MIN(b.Transaction_DateTime ::date) AS Next_Purchase
FROM sales a
LEFT JOIN sales b ON a.Customer_ID = b.Customer_ID 
AND b.transaction_datetime > a.transaction_datetime
GROUP BY a.transaction_datetime, a.customer_id
HAVING MIN(b.Transaction_DateTime ::date) IS NOT NULL
ORDER BY a.transaction_datetime, a.customer_id;
```
    3. REPETITIVE CUSTOMER ON SAME DAY:
        This helps in identifying the customer details who performed multiple transactions on the same day.

```sql
SELECT Customer_ID,
Transaction_DateTime ::date as T_date,
Count(*) as Trans_Count
FROM sales
GROUP BY Customer_ID, T_date
HAVING Count(*) > 1;
```
## Lessons Learned:
- Based on Montly Ranking, to be improved product category will be identified 
- Only very few customers are repetitive 
- Customers performing multiple transaction on same day are very less

        


