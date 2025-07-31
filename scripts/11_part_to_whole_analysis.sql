/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - Analyze how individual segments contribute to the overall total.
    - Compare performance across categories, regions, or time periods.
    - Ideal for A/B testing, share analysis, and contribution breakdowns.

SQL Techniques Used:
    - Aggregate Functions: SUM(), AVG() for segment-level metrics.
    - Window Functions: SUM() OVER() for calculating grand totals.
===============================================================================
*/

-- Which categories contribute the most to overall sales?
WITH category_sales AS (
    SELECT
        p.category,
        SUM(f.sales_amount) AS total_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON p.product_key = f.product_key
    GROUP BY p.category
)
SELECT
    category,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2) AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;
