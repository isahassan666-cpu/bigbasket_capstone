
# AI Log - Capstone Project

## Prompt #1: Query 5(b) Monthly Category Revenue Aggregation

### RCTCF Framework Breakdown

- **Role:** SQL Data Analyst helping write production SQLite queries for retail analytics.
- **Context:** I am working on my BigBasket capstone database (`bigbasket_capstone.db`). The database has tables for `orders`, `products`, `customers`, and `category_targets`. Orders contain `amount_inr`, `status`, `order_date` (in YYYY-MM-DD format), and a foreign key `product_id`.
- **Task:** Write SQL query 5(b) that aggregates monthly revenue by product category. For each combination of category and month, I need to compute the total number of orders (`order_count`), total revenue sum (`total_revenue`), and the average revenue per order (`avg_revenue`).
- **Constraints:**
  - Only count completed transactions where `status = 'Delivered'`.
  - Extract and format the month as `YYYY-MM` using SQLite's `strftime('%Y-%m', order_date)`.
  - Join `orders` with `products` on `product_id`.
  - Group by `category` first, then `month`.
  - Sort the final output by `category ASC, month ASC`.
  - Avoid any integer division issues with averages.
- **Format:** Clean SQLite SQL query with exact column names: `category`, `month`, `order_count`, `total_revenue`, `avg_revenue`.

---

### Concrete Verification Performed

To make sure the generated query was accurate before exporting and committing the results, I performed the following checks directly against `bigbasket_capstone.db`:

1. **Export and Row Count Check:**
   - I ran the query using Python's `sqlite3` module and exported the full result set to `monthly_category_revenue.csv`.
   - I checked the file line count and verified it contains exactly 36 data rows plus 1 header row, representing all 6 categories across the 6-month period (July to December 2024).

2. **Grand Total Revenue Validation:**
   - I executed a verification query calculating the grand total revenue across all rows:
     `SELECT SUM(total_revenue) FROM (...)`
   - The returned grand total was `88282`, which matches the required acceptance criteria.

3. **Spot Check Against Raw Tables:**
   - I manually cross-checked a specific slice from the CSV against a direct query on the raw `orders` and `products` tables.
   - For `Beverages` in `2024-07`, I ran:
     `SELECT COUNT(*), SUM(amount_inr) FROM orders o JOIN products p ON o.product_id = p.product_id WHERE p.category = 'Beverages' AND strftime('%Y-%m', o.order_date) = '2024-07' AND o.status = 'Delivered';`
   - The raw table values matched the exported CSV row for that category and month.
  
  
## Prompt #2: Task 10 Data Cleaning - IQR Outlier Capping on Delivered Orders

### RCTCF Framework Breakdown

- **Role:** Senior Data Engineer and Pandas Specialist.
- **Context:** Working on `orders_raw.csv` in Jupyter Notebook. The dataset has 500 cleaned records, but right-skewed extreme amounts on delivered orders distort summary statistics.
- **Task:** Compute Q1, Q3, and the upper fence using the IQR method on non-null `Delivered` orders, then cap outlier values exceeding the upper fence using `.clip()` without dropping records.
- **Constraints:**
  - Restrict calculation strictly to `is_delivered == True` and non-null `amount_inr`.
  - Cap values in place using `.clip(upper=upper_fence)`.
  - Do not drop any rows; preserve the 500-record count intact.
- **Format:** Executable Python code snippet with verification logic.

### AI Code Applied

```python

# Filter delivered, non-null records
delivered_mask = orders['is_delivered'] & orders['amount_inr'].notna()

# Compute quartiles and IQR fence
q1 = orders.loc[delivered_mask, 'amount_inr'].quantile(0.25)
q3 = orders.loc[delivered_mask, 'amount_inr'].quantile(0.75)
iqr = q3 - q1
upper_fence = q3 + 1.5 * iqr

# Cap values at upper fence
orders.loc[delivered_mask, 'amount_inr'] = orders.loc[delivered_mask, 'amount_inr'].clip(upper=upper_fence)

### Actually-Performed Verification Step
- **Check:** Executed `orders.loc[delivered_mask, 'amount_inr'].max()` and inspected the top 3 outlier records.
- **Result:** Confirmed the maximum delivered order amount is strictly capped at ₹800.00, and the overall dataset retained all 500 rows.
