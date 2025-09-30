

--  Analyze monthly revenue and order volume
SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM online_sales.orders
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

--  Limit results for a specific year, e.g., 2024
SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM online_sales.orders
WHERE EXTRACT(YEAR FROM order_date) = 2024
GROUP BY order_year, order_month
ORDER BY order_year, order_month;
```

###  Results Table

| order_year | order_month | total_revenue | total_orders |
| ---------- | ----------- | ------------- | ------------ |
| 2024       | 1           | 150,000       | 420          |
| 2024       | 2           | 180,500       | 460          |
| 2024       | 3           | 210,300       | 500          |
| 2024       | 4           | 195,750       | 480          |
| 2024       | 5           | 220,600       | 520          |
| 2024       | 6           | 205,000       | 490          |

---


