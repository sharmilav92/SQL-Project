
--Customer with multiple transaction on same day

SELECT Customer_ID,
Transaction_DateTime ::date as T_date,
Count(*) as Trans_Count
FROM sales
GROUP BY Customer_ID, T_date
HAVING Count(*) > 1;