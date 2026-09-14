-- ==========================================================
-- 03_reporting.sql: CASE WHEN Tiering, Date Report, & Variance
-- ==========================================================

-- (a) Tier every product by its total Delivered revenue
SELECT 
    p.product_id,
    p.product_name,
    COALESCE(SUM(o.amount_inr), 0) AS total_revenue,
    CASE 
        WHEN COALESCE(SUM(o.amount_inr), 0) >= 3000 THEN 'High'
        WHEN COALESCE(SUM(o.amount_inr), 0) >= 1000 THEN 'Medium'
        ELSE 'Low'
    END AS revenue_tier
FROM products p
LEFT JOIN orders o 
    ON p.product_id = o.product_id 
    AND o.status = 'Delivered'
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC;

-- (b) Monthly-by-category business report (Delivered orders only)
SELECT 
    p.category,
    strftime('%Y-%m', o.order_date) AS month,
    COUNT(o.order_id) AS order_count,
    SUM(o.amount_inr) AS total_revenue,
    AVG(o.amount_inr) AS avg_revenue
FROM orders o
INNER JOIN products p 
    ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY p.category, month
ORDER BY p.category ASC, month ASC;

-- (c) Derived-fields query joining category revenue to targets
WITH category_rev AS (
    SELECT 
        p.category,
        SUM(o.amount_inr) AS total_revenue
    FROM orders o
    INNER JOIN products p 
        ON o.product_id = p.product_id
    WHERE o.status = 'Delivered'
    GROUP BY p.category
)
SELECT 
    cr.category,
    cr.total_revenue,
    ct.target_revenue_inr,
    (ct.target_revenue_inr - cr.total_revenue) AS variance,
    ((cr.total_revenue - ct.target_revenue_inr) * 100.0) / ct.target_revenue_inr AS percentage_variance,
    CASE 
        WHEN cr.total_revenue >= ct.target_revenue_inr THEN 'Above Target'
        WHEN ((cr.total_revenue - ct.target_revenue_inr) * 100.0) / ct.target_revenue_inr >= -15.0 THEN 'Below Target - Watch'
        ELSE 'Below Target - Critical'
    END AS target_status
FROM category_rev cr
INNER JOIN category_targets ct 
    ON cr.category = ct.category;