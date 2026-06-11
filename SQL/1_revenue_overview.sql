SELECT 
    o.order_id,
    o.customer_id,
    DATE(o.order_purchase_timestamp) AS order_date,
    STRFTIME('%Y-%m', o.order_purchase_timestamp) AS order_month,
    ROUND(SUM(p.payment_value), 2) AS order_revenue,
    COUNT(DISTINCT oi.product_id) AS items_count,
    r.review_score
FROM orders o
JOIN payments p ON o.order_id = p.order_id
JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
GROUP BY o.order_id, o.customer_id, order_date, order_month, r.review_score
ORDER BY order_date;