# Build Guide — SQL + Power BI

## 1. Import into MySQL Workbench
1. Open MySQL Workbench and connect to your local server.
2. Open `sql/analysis_queries.sql`; run the CREATE DATABASE, USE and CREATE TABLE statements first.
3. In Schemas, right-click `ecommerce_analytics` → Table Data Import Wizard.
4. Select `data/ecommerce_sales.csv`, choose existing table `ecommerce_sales`, map columns and finish.
5. Run `SELECT COUNT(*) FROM ecommerce_sales;` — expected result: 3200 rows.

## 2. Load into Power BI
1. Open Power BI Desktop → Home → Get Data → Text/CSV.
2. Select `data/ecommerce_sales.csv` → Transform Data.
3. Set `order_date` to Date and numeric columns to numeric data types.
4. Replace missing `city`, `payment_method`, and `customer_segment` values with `Unknown` in Power Query.
5. Choose Close & Apply.

## 3. Add DAX measures
Select `ecommerce_sales` → Modeling → New measure. Add measures from `powerbi/DAX_Measures.md` one at a time.

## 4. Build report pages
Page 1: five KPI cards; monthly revenue line chart; category revenue bar chart; channel revenue donut; date/city/category/segment slicers.
Page 2: product revenue bar chart (Top 10 by revenue); customer-segment profit bar chart; city revenue column chart; payment-method orders donut; category/channel/segment slicers.

Save the report as `powerbi/ecommerce_dashboard.pbix`; export a screenshot to `screenshots/dashboard.png`.

## Interview explanation
“I used SQL to query sales KPIs and compare product, customer, city, and channel performance. I built a Power BI report with DAX measures and interactive slicers. The dataset is synthetic and demonstrates an end-to-end analytics workflow rather than representing a real company.”
