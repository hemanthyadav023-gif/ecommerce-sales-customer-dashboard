# Power BI DAX Measures

Table name: `ecommerce_sales`. Create each via **Modeling → New measure**.

```DAX
Total Revenue = SUM(ecommerce_sales[revenue])

Total Profit = SUM(ecommerce_sales[profit])

Total Orders = DISTINCTCOUNT(ecommerce_sales[order_id])

Unique Customers = DISTINCTCOUNT(ecommerce_sales[customer_id])

Units Sold = SUM(ecommerce_sales[quantity])

Average Order Value = DIVIDE([Total Revenue], [Total Orders], 0)

Profit Margin % = DIVIDE([Total Profit], [Total Revenue], 0)

Average Discount % = AVERAGE(ecommerce_sales[discount_pct])

Revenue per Customer = DIVIDE([Total Revenue], [Unique Customers], 0)

Total Shipping Fees = SUM(ecommerce_sales[shipping_fee])
```

Format currency measures as INR (₹) and percentage measures as percentages.
`discount_pct` is stored as a fraction (0.05 means 5%).

## Page 1 — Executive Overview
- Cards: Total Revenue, Total Profit, Total Orders, Unique Customers, Average Order Value
- Line chart: order_date vs Total Revenue
- Bar chart: category vs Total Revenue
- Donut chart: sales_channel vs Total Revenue
- Slicers: order_date, city, category, customer_segment

## Page 2 — Product & Customer Insights
- Bar chart: product vs Total Revenue (Top N = 10)
- Bar chart: customer_segment vs Total Profit
- Column chart: city vs Total Revenue
- Donut chart: payment_method vs Total Orders
- Slicers: category, sales_channel, customer_segment
