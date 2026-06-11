WITH category_revenue AS (
    SELECT 
        COALESCE(cat.product_category_name_english, 'Unknown') AS category,
        STRFTIME('%Y-%m', o.order_purchase_timestamp) AS month,
        ROUND(SUM(p.payment_value), 2) AS revenue,
        COUNT(DISTINCT o.order_id) AS orders
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products pr ON oi.product_id = pr.product_id
    LEFT JOIN categories cat ON pr.product_category_name = cat.product_category_name
    JOIN payments p ON o.order_id = p.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY category, month
)
SELECT 
    category,
    month,
    revenue,
    orders,
    SUM(revenue) OVER (
        PARTITION BY category 
        ORDER BY month 
        ROWS UNBOUNDED PRECEDING
    ) AS running_total,
    RANK() OVER (
        PARTITION BY month 
        ORDER BY revenue DESC
    ) AS monthly_rank
FROM category_revenue
ORDER BY category, month;