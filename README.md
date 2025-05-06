# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**:  `sql_project_1`
`

I have built this project to demonstrate my SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. It involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project showcases my learning and is ideal for those beginning their journey in data analysis and aiming to build a solid foundation in SQL.



## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup
```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales (
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

2. Data Exploration & Cleaning

-- Total record count
SELECT COUNT(*) FROM retail_sales;

-- Unique customer count
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- Unique categories
SELECT DISTINCT category FROM retail_sales;

-- Null value check
SELECT * FROM retail_sales
WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
      gender IS NULL OR age IS NULL OR category IS NULL OR 
      quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

-- Deleting null records
DELETE FROM retail_sales
WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
      gender IS NULL OR age IS NULL OR category IS NULL OR 
      quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
3. Data Analysis & Findings
1. Sales on '2022-11-05'

SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
2. Clothing category with quantity > 4 in Nov-2022
sql
Copy
Edit
SELECT * FROM retail_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantity >= 4;
3. Total sales for each category

SELECT 
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
4. Average age of customers who purchased 'Beauty' products

SELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
5. Transactions with total_sale > 1000

SELECT * FROM retail_sales
WHERE total_sale > 1000;
6. Transaction count by gender and category

SELECT 
    category,
    gender,
    COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
7. Best-selling month each year (by avg sale)

SELECT year, month, avg_sale
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY 1, 2
) AS ranked_sales
WHERE rank = 1;
8. Top 5 customers by total sales

SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
9. Unique customers per category

SELECT 
    category,
    COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM retail_sales
GROUP BY category;
10. Order count by shift

WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;

```

![result](./Screenshot%202025-05-06%20075327.png)
![result](./Screenshot%202025-05-06%20075344.png)
![result](./Screenshot%202025-05-06%20075353.png)

## Findings
### Customer Demographics
- The dataset includes customers from various age groups.
- Sales are distributed across different categories, including Clothing and Beauty.

### High-Value Transactions
- Several transactions had a total sale amount greater than 1000, indicating premium purchases.

### Sales Trends
- Monthly analysis shows variations in sales, helping identify peak seasons.

### Customer Insights
- The analysis identifies the top-spending customers.
- The most popular product categories are also highlighted.

## Reports

### Sales Summary
A detailed report summarizing:
- Total sales
- Customer demographics
- Category performance

### Trend Analysis
Insights into:
- Sales trends across different months
- Shifts in purchasing patterns

### Customer Insights
Reports on:
- Top customers
- Unique customer counts per category

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering:
- Database setup
- Data cleaning
- Exploratory data analysis
- Business-driven SQL queries

The findings can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

### 1. Clone the Repository
Clone this project repository from GitHub:

git clone [<repository_url>](https://github.com/sudesh-co/SQLProjectRetailSalesAnalysis/)
