WITH order_data AS (
    SELECT 
        c.customer_unique_id,
        o.order_id,
        r.review_score,
        ROUND(SUM(p.payment_value), 2) AS order_value,
        STRFTIME('%Y-%m', o.order_purchase_timestamp) AS order_month
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN payments p ON o.order_id = p.order_id
    LEFT JOIN reviews r ON o.order_id = r.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY o.order_id
),
customer_history AS (
    SELECT *,
        COUNT(*) OVER (PARTITION BY customer_unique_id) AS total_orders,
        ROW_NUMBER() OVER (
            PARTITION BY customer_unique_id 
            ORDER BY order_month
        ) AS order_sequence
    FROM order_data
)
SELECT 
    review_score,
    COUNT(*) AS total_orders,
    ROUND(AVG(order_value), 2) AS avg_order_value,
    ROUND(100.0 * SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) 
          / COUNT(*), 1) AS repeat_purchase_rate
FROM customer_history
WHERE review_score IS NOT NULL
GROUP BY review_score
ORDER BY review_score DESC;