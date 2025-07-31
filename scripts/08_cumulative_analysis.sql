/*
===============================================================================
Cumulative Metrics Evaluation
===============================================================================
Objective:
    - Compute running totals and moving averages across a time sequence.
    - Observe cumulative progress and long-term performance trends.
    - Ideal for tracking growth patterns and momentum over time.

SQL Techniques Used:
    - Window Functions: SUM() OVER(...), AVG() OVER(...)
===============================================================================
*/

-- Calculate the total sales per month 
-- and the running total of sales over time 
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
	AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
FROM
(
    SELECT 
        DATETRUNC(year, order_date) AS order_date,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(year, order_date)
) t
