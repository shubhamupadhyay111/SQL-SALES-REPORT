## 🛒 Retail Sales SQL Analysis Project

This project involves analyzing a retail sales dataset using **PostgreSQL** to derive business insights, clean data, and solve real-world retail-related questions. The dataset includes transaction-level data with customer details, sales amounts, product categories, and timestamps.

---

### 🧰 Tools & Technologies

* **Database**: PostgreSQL
* **Query Language**: SQL
* **Data Source**: `retail_sales` table
* **Environment**: SQL client (pgAdmin, DBeaver, or any PostgreSQL-compatible tool)

---

### 📁 Project Structure

1. **Database Creation**

   ```sql
   CREATE DATABASE sql_report_p1;
   ```

2. **Table Creation & Schema Design**

   * Table: `retail_sales`
   * Includes fields such as `transactions_id`, `sale_date`, `sale_time`, `customer_id`, `gender`, `category`, `total_sale`, and more.

3. **Data Cleaning**

   * Checked for and removed rows with `NULL` values.

4. **Data Exploration**

   * Counted total sales.
   * Identified unique customers.
   * Retrieved available product categories.

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
