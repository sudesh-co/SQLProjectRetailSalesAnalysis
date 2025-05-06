-- ========================================
-- SQL Project: Retail Sales Analysis
-- Author: [Your Name]
-- Description: Sales data analysis using SQL queries to extract business insights.
-- ========================================

-- 1. Create the database
CREATE DATABASE sql_project_1;
GO

-- 2. Use the created database
USE sql_project_1;
GO

-- 3. Create the sales table
CREATE TABLE reatail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time DATETIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(25),
    quantiy INT,
    price_per_unit DECIMAL(18, 2),
    cogs DECIMAL(18, 2),
    total_sale INT
);

-- 4. View data from the table
SELECT * FROM reatail_sales;
GO

-- 5. Identify records with NULL values
SELECT * FROM reatail_sales
WHERE 
    transactions_id IS NULL OR
    sale_date IS NULL OR
    sale_time IS NULL OR
    gender IS NULL OR
    category IS NULL OR
    quantiy IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;

-- 6. Delete records with NULL values
DELETE FROM reatail_sales
WHERE transactions_id IN (
    SELECT transactions_id FROM reatail_sales
    WHERE 
        transactions_id IS NULL OR
        sale_date IS NULL OR
        sale_time IS NULL OR
        gender IS NULL OR
        category IS NULL OR
        quantiy IS NULL OR
        cogs IS NULL OR
        total_sale IS NULL
);

-- 7. Get total number of records
SELECT COUNT(*) FROM reatail_sales;

-- 8. Get list of distinct customers
SELECT DISTINCT customer_id FROM reatail_sales;

-- ========================================
-- Business Questions and SQL Solutions
-- ========================================

-- Q1. Retrieve all columns for sales made on '2022-11-05'
SELECT * 
FROM reatail_sales
WHERE sale_date = '2022-11-05';

-- Q2. Retrieve all transactions for 'Clothing' category with quantity > 10 in Nov 2022
SELECT * 
FROM reatail_sales
WHERE category = 'Clothing' 
  AND quantiy > 10 
  AND MONTH(sale_date) = 11 
  AND YEAR(sale_date) = 2022;

-- Q3. Calculate total sales per category
SELECT category, SUM(total_sale) AS total_sales
FROM reatail_sales
GROUP BY category;

-- Q4. Find average age of customers who purchased 'Beauty' category
SELECT category, AVG(age) AS average_age
FROM reatail_sales
WHERE category = 'Beauty'
GROUP BY category;

-- Q5. Retrieve transactions where total_sale > 1000
SELECT * 
FROM reatail_sales
WHERE total_sale > 1000;

-- Q6. Count of transactions by gender
SELECT gender, COUNT(transactions_id) AS total_transactions
FROM reatail_sales
GROUP BY gender;

-- Q7. Average sale per month and best-selling month in each year
WITH MonthYearSales AS (
    SELECT 
        MONTH(sale_date) AS month,
        YEAR(sale_date) AS year,
        AVG(total_sale) AS average_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rnk
    FROM reatail_sales
    GROUP BY MONTH(sale_date), YEAR(sale_date)
)
SELECT * FROM MonthYearSales
WHERE rnk = 1;

-- Q8. Top 5 customers by highest total sales
SELECT TOP 5 customer_id, SUM(total_sale) AS total_sales
FROM reatail_sales
GROUP BY customer_id
ORDER BY total_sales DESC;

-- Q9. Unique customers per category
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM reatail_sales
GROUP BY category;

-- Q10. Shift-wise number of orders
-- Shifts: Morning (<=12), Afternoon (12-17), Evening (>17)
SELECT  
    CASE 
        WHEN DATEPART(HOUR, sale_time) <= 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 13 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS Shift,
    COUNT(*) AS Number_of_Orders
FROM reatail_sales 
GROUP BY  
    CASE 
        WHEN DATEPART(HOUR, sale_time) <= 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 13 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END;
