CREATE DATABASE IF NOT EXISTS ecommerce_analytics;
USE ecommerce_analytics;

CREATE TABLE IF NOT EXISTS ecommerce_sales (
 order_id VARCHAR(20) PRIMARY KEY,
 order_date DATE,
 customer_id VARCHAR(20),
 product VARCHAR(50),
 category VARCHAR(50),
 city VARCHAR(50),
 customer_segment VARCHAR(50),
 sales_channel VARCHAR(30),
 payment_method VARCHAR(40),
 quantity INT,
 unit_price DECIMAL(12,2),
 unit_cost DECIMAL(12,2),
 discount_pct DECIMAL(5,2),
 revenue DECIMAL(14,2),
 total_cost DECIMAL(14,2),
 shipping_fee DECIMAL(10,2),
 profit DECIMAL(14,2)
);

-- Import data/ecommerce_sales.csv into the table using MySQL Workbench's
-- Table Data Import Wizard after creating the table.

-- 1. Overall KPIs
SELECT ROUND(SUM(revenue),2) AS total_revenue,
       ROUND(SUM(profit),2) AS total_profit,
       COUNT(DISTINCT order_id) AS total_orders,
       COUNT(DISTINCT customer_id) AS unique_customers,
       SUM(quantity) AS units_sold,
       ROUND(SUM(revenue)/NULLIF(COUNT(DISTINCT order_id),0),2) AS average_order_value
FROM ecommerce_sales;

-- 2. Monthly performance
SELECT DATE_FORMAT(order_date,'%Y-%m') AS month,
       ROUND(SUM(revenue),2) AS revenue,
       ROUND(SUM(profit),2) AS profit,
       COUNT(*) AS orders
FROM ecommerce_sales
GROUP BY DATE_FORMAT(order_date,'%Y-%m')
ORDER BY month;

-- 3. Category performance
SELECT category, ROUND(SUM(revenue),2) AS revenue,
       ROUND(SUM(profit),2) AS profit, SUM(quantity) AS units_sold
FROM ecommerce_sales
GROUP BY category ORDER BY revenue DESC;

-- 4. Top products
SELECT product, ROUND(SUM(revenue),2) AS revenue,
       ROUND(SUM(profit),2) AS profit
FROM ecommerce_sales
GROUP BY product ORDER BY revenue DESC LIMIT 10;

-- 5. City performance
SELECT city, ROUND(SUM(revenue),2) AS revenue,
       ROUND(SUM(profit),2) AS profit, COUNT(*) AS orders
FROM ecommerce_sales
GROUP BY city ORDER BY revenue DESC;

-- 6. Customer segment
SELECT customer_segment, COUNT(DISTINCT customer_id) AS customers,
       ROUND(SUM(revenue),2) AS revenue, ROUND(SUM(profit),2) AS profit
FROM ecommerce_sales
GROUP BY customer_segment ORDER BY revenue DESC;

-- 7. Sales channel mix
SELECT sales_channel, COUNT(*) AS orders, ROUND(SUM(revenue),2) AS revenue,
       ROUND(100*SUM(revenue)/(SELECT SUM(revenue) FROM ecommerce_sales),2) AS revenue_share_pct
FROM ecommerce_sales
GROUP BY sales_channel ORDER BY revenue DESC;

-- 8. Payment method
SELECT payment_method, COUNT(*) AS orders, ROUND(SUM(revenue),2) AS revenue
FROM ecommerce_sales
GROUP BY payment_method ORDER BY orders DESC;

-- 9. Discount analysis
SELECT CASE WHEN discount_pct=0 THEN 'No discount'
            WHEN discount_pct<=0.05 THEN '1-5%'
            WHEN discount_pct<=0.10 THEN '6-10%'
            ELSE 'Above 10%' END AS discount_band,
       COUNT(*) AS orders, ROUND(AVG(revenue),2) AS avg_revenue,
       ROUND(SUM(profit),2) AS total_profit
FROM ecommerce_sales
GROUP BY discount_band ORDER BY total_profit DESC;

-- 10. Repeat customers
SELECT customer_id, COUNT(*) AS orders, ROUND(SUM(revenue),2) AS revenue,
       ROUND(SUM(profit),2) AS profit
FROM ecommerce_sales
GROUP BY customer_id HAVING COUNT(*)>1
ORDER BY revenue DESC LIMIT 20;

-- 11. Data quality checks
SELECT COUNT(*) AS total_rows FROM ecommerce_sales;
SELECT COUNT(*) AS missing_city FROM ecommerce_sales WHERE city IS NULL;
