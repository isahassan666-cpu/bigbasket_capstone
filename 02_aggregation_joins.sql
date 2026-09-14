-- ==========================================================
-- STEP 4: AGGREGATION, JOIN, AND HAVING QUERIES (02_aggregation_joins.sql)
-- ==========================================================

-- (a) INNER JOIN: Category-level revenue & count for Delivered orders with HAVING total_revenue > 10000
SELECT 
    p.category,
    COUNT(o.order_id) AS order_count,
    SUM(o.amount_inr) AS total_revenue,
    AVG(o.amount_inr) AS avg_revenue
FROM orders o
INNER JOIN products p 
    ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY p.category
HAVING total_revenue > 10000;

-- (b) LEFT JOIN: Total orders per product (ascending to surface least-ordered)
-- Note: COUNT(o.order_id) ensures 'Premium Face Cream 50g' returns 0 instead of 1.
SELECT 
    p.product_id,
    p.product_name,
    COUNT(o.order_id) AS total_orders
FROM products p
LEFT JOIN orders o 
    ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_orders ASC;