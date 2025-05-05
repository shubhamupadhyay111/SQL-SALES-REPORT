-- SQL RETAIL SALES ANALYSIS 
CREATE DATABASE sql_report_p1;


-- CREATE TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
transactions_id	INT PRIMARY KEY,
sale_date	DATE,
sale_time	TIME,
customer_id	INT,
gender	VARCHAR(15),
age	INT,
category VARCHAR(15),	
quantiy	INT,
price_per_unit	FLOAT,
cogs	FLOAT,
total_sale FLOAT
);

SELECT * FROM retail_sales
limit 10;

SELECT COUNT(*) FROM retail_sales

SELECT * FROM retail_sales;

-- DATA CLEANING

-- checking null values

SELECT * FROM retail_sales
WHERE 
    transactions_id IS NULL
	OR
	sale_date IS NULL
	OR 
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR 
	quantiy IS NULL
	OR 
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-- Delete null values

DELETE FROM retail_sales
WHERE 
    transactions_id IS NULL
	OR
	sale_date IS NULL
	OR 
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR 
	quantiy IS NULL
	OR 
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-- DATA EXPLORATION STEPS

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

-- How many unique customer we have?
SELECT COUNT(DISTINCT customer_id) as total_customer FROM retail_sales;

-- How many category we have?
SELECT DISTINCT category FROM retail_sales;


-- DATA ANALYSIS & BUSINESS KEY PROBLEMS AND ANSWERS (MY ANALYSIS & FINDINGS)

-- Q1 Write SQL query to retrive all columns for sales made on '2022-11-05'

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

''' Q2 Write SQL query to retrive all transactions where the category is clothing and the quantity sold is more than 
4 in th month of nov-2022'''

SELECT *
FROM retail_sales
WHERE
    category = 'Clothing'
	AND
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND
	quantiy >= 4;

-- Q3 Write SQL query to calculate the total sales (total_sale) for each category

SELECT 
     category,
	 SUM(total_sale) as net_sales,
	 COUNT(*) as total_order
FROM retail_sales
GROUP BY category;

-- Q4 Write SQL query to find out the average age of customers who purchased items from the 'beauty' category

SELECT 
     ROUND(AVG(age),2) as average_age_of_the_customer
FROM retail_sales
WHERE 
    category = 'Beauty';

-- Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- Q6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

SELECT 
     category,
	 gender,
	 COUNT(*) as total_transaction
FROM retail_sales
GROUP BY
       category,
	   gender
ORDER BY 1;	   

-- Q7 Write a SQL query to calculate the average sale for each month. find out best selling month in each year.

SELECT *
FROM (
    SELECT 
        year,	
        month,
        avg_sale,
        RANK() OVER (PARTITION BY year ORDER BY avg_sale DESC) as rank
    FROM (
        SELECT 
            EXTRACT(YEAR FROM sale_date) AS year,
            EXTRACT(MONTH FROM sale_date) AS month,
            ROUND(AVG(total_sale)::numeric, 2) AS avg_sale
        FROM retail_sales
        GROUP BY year, month
    ) sub
) ranked
WHERE rank = 1;

-- Q8 Write a SQL query to find the top 5 customers based on the highest total sales.

SELECT 
     customer_id,
	 SUM(total_sale) as total_sales
FROM retail_sales 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
     category,
     COUNT(DISTINCT customer_id) as unique_customers
FROM retail_sales 
GROUP BY 1;

-- Q10 Write a SQL query to create each shift and number of orders (example morning <=12, afternoon between 12 & 17, evening >17)

WITH hourly_sale
AS
(
SELECT *,
     CASE
	     WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		 WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		 ELSE 'Evening'
	 END as shift
FROM retail_sales
)
SELECT 
     shift,
	 COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift;

-- END OF PROJECT -- 

	 
	 


	

	 

	 


