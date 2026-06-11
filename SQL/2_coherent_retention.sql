WITH first_orders AS (
    SELECT 
        c.customer_unique_id,
        MIN(STRFTIME('%Y-%m', o.order_purchase_timestamp)) AS cohort_month
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
order_months AS (
    SELECT DISTINCT
        c.customer_unique_id,
        STRFTIME('%Y-%m', o.order_purchase_timestamp) AS order_month
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
),
cohort_data AS (
    SELECT 
        f.cohort_month,
        om.order_month,
        (CAST(SUBSTR(om.order_month, 1, 4) AS INT) - 
         CAST(SUBSTR(f.cohort_month, 1, 4) AS INT)) * 12 +
        (CAST(SUBSTR(om.order_month, 6, 2) AS INT) - 
         CAST(SUBSTR(f.cohort_month, 6, 2) AS INT)) AS months_since_first,
        COUNT(DISTINCT f.customer_unique_id) AS customers
    FROM first_orders f
    JOIN order_months om ON f.customer_unique_id = om.customer_unique_id
    GROUP BY f.cohort_month, om.order_month
),
cohort_sizes AS (
    SELECT cohort_month, COUNT(*) AS cohort_size
    FROM first_orders
    GROUP BY cohort_month
)
SELECT 
    cd.cohort_month,
    cs.cohort_size,
    cd.months_since_first,
    cd.customers,
    ROUND(100.0 * cd.customers / cs.cohort_size, 1) AS retention_rate
FROM cohort_data cd
JOIN cohort_sizes cs ON cd.cohort_month = cs.cohort_month
WHERE cd.months_since_first BETWEEN 0 AND 6
ORDER BY cd.cohort_month, cd.months_since_first;