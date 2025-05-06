# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_report_p1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_report_p1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sql_report_p1;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

---

### 📊 Business Questions & SQL Solutions

#### ✅ Q1: Sales on a specific date (`2022-11-05`)

```sql
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
```

#### ✅ Q2: Clothing sales with quantity ≥ 4 in November 2022

```sql
SELECT * FROM retail_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantiy >= 4;
```

#### ✅ Q3: Total sales and orders per category

```sql
SELECT category, SUM(total_sale) AS net_sales, COUNT(*) AS total_order
FROM retail_sales
GROUP BY category;
```

#### ✅ Q4: Average age of customers in the Beauty category

```sql
SELECT ROUND(AVG(age), 2) AS average_age_of_the_customer
FROM retail_sales
WHERE category = 'Beauty';
```

#### ✅ Q5: Transactions with total sale > 1000

```sql
SELECT * FROM retail_sales WHERE total_sale > 1000;
```

#### ✅ Q6: Number of transactions per gender and category

```sql
SELECT category, gender, COUNT(*) AS total_transaction
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
```

#### ✅ Q7: Best selling month (based on average sale) per year

```sql
SELECT * FROM (
    SELECT year, month, avg_sale,
           RANK() OVER (PARTITION BY year ORDER BY avg_sale DESC) AS rank
    FROM (
        SELECT EXTRACT(YEAR FROM sale_date) AS year,
               EXTRACT(MONTH FROM sale_date) AS month,
               ROUND(AVG(total_sale)::numeric, 2) AS avg_sale
        FROM retail_sales
        GROUP BY year, month
    ) sub
) ranked
WHERE rank = 1;
```

#### ✅ Q8: Top 5 customers based on total sales

```sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

#### ✅ Q9: Unique customers per category

```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```

#### ✅ Q10: Order count by shift (Morning, Afternoon, Evening)

```sql
WITH hourly_sale AS (
    SELECT *, 
           CASE
               WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
               WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
               ELSE 'Evening'
           END AS shift
    FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
```

---

### 📌 Key Insights

* Identified **top-performing months** and **highest-spending customers**.
* Segmented sales by **gender**, **category**, and **time of day**.
* Revealed **customer demographics** and **sales trends**.

---

### 📎 Next Steps (Optional Ideas)

* Build visual dashboards using Power BI or Tableau.
* Automate reporting with views or materialized queries.
* Integrate predictive models for future sales.

---

### 🤝 Contributing

Feel free to fork, raise issues, or contribute improvements to this SQL analysis.

---

### 📄 License

This project is open-source and free to use under the [MIT License](LICENSE).

---

Would you like a matching sample `.SQL` script and `.LICENSE` file to go along with this README?
