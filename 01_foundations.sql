-- ==========================================================
-- STEP 3: FOUNDATIONAL QUERIES (01_foundations.sql)
-- ==========================================================

-- 1. SELECT / WHERE: Orders in a specific city
SELECT * 
FROM orders 
WHERE city = 'Bangalore';

-- 2. DISTINCT: List every distinct category
SELECT DISTINCT category 
FROM products;

-- 3. ORDER BY + LIMIT: The 5 highest-value orders by amount_inr
SELECT * 
FROM orders 
ORDER BY amount_inr DESC 
LIMIT 5;

-- 4. Alias (AS): Rename an aggregate/column in your output
SELECT COUNT(*) AS total_orders 
FROM orders;

-- 5. IN: Orders whose payment_mode is in a 2-mode list
SELECT * 
FROM orders 
WHERE payment_mode IN ('UPI', 'Credit Card');

-- 6. BETWEEN / NOT BETWEEN: Orders with amount_inr in a stated range, and outside it
-- Orders within range:
SELECT * 
FROM orders 
WHERE amount_inr BETWEEN 500 AND 2000;

-- Orders outside range:
SELECT * 
FROM orders 
WHERE amount_inr NOT BETWEEN 500 AND 2000;

-- 7. IS NULL: Orders with no rating recorded (Cancelled / Pending)
SELECT * 
FROM orders 
WHERE rating IS NULL;