
--Consecutive Purchase Dates of a Customer

SELECT a.Customer_ID, 
a.Transaction_DateTime ::date AS First_Purchase,
MIN(b.Transaction_DateTime ::date) AS Next_Purchase
FROM sales a
LEFT JOIN sales b ON a.Customer_ID = b.Customer_ID 
AND b.transaction_datetime > a.transaction_datetime
GROUP BY a.transaction_datetime, a.customer_id
HAVING MIN(b.Transaction_DateTime ::date) IS NOT NULL
ORDER BY a.transaction_datetime, a.customer_id;


