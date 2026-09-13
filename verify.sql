-- ==========================================================
-- STEP 2: VERIFICATION RESULTS
-- ==========================================================
-- Table Counts:
-- products: 31
-- customers: 50
-- orders: 500
-- category_targets: 6
--
-- Orders by Status:
-- Delivered: 434
-- Cancelled: 42
-- Pending: 24
-- ==========================================================

-- 1. Table row counts
SELECT 'products' AS table_name, COUNT(*) AS total_count FROM products;
SELECT 'customers' AS table_name, COUNT(*) AS total_count FROM customers;
SELECT 'orders' AS table_name, COUNT(*) AS total_count FROM orders;
SELECT 'category_targets' AS table_name, COUNT(*) AS total_count FROM category_targets;

-- 2. Orders status breakdown
SELECT status, COUNT(*) AS count
FROM orders
GROUP BY status;