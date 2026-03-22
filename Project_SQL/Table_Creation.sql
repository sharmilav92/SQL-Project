DROP TABLE sales;

CREATE TABLE public.sales (
    Customer_ID INT,
    Product_ID TEXT,
    Quantity INT,
    Price NUMERIC,
    Transaction_DateTime TIMESTAMP,
    Payment_Method TEXT,
    Store_Location TEXT,
    Product_Category TEXT,
    Discount_Percent NUMERIC,
    PRIMARY KEY (Customer_ID, Product_ID)
);

ALTER TABLE public.sales OWNER to postgres;



