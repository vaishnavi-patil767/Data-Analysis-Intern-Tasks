select * from ecommerce_dataset;
select * from ecommerce_dataset where product_name="glass";
select category,avg(unit_price) as avg_price from ecommerce_dataset group by category;
select category,sum(quantity) as total_quantity from ecommerce_dataset group by category;
select product_name,sum(quantity * unit_price)as total_renue from ecommerce_dataset group by product_name order by total_renue desc;
select product_id from ecommerce_dataset  group by product_id  order by product_id asc limit 1; 
select product_name ,sum(quantity) as total_quantity from ecommerce_dataset group by product_name having total_quantity >10;
SELECT category,COUNT(DISTINCT product_id) AS product_count FROM ecommerce_dataset GROUP BY category HAVING COUNT(DISTINCT product_id) > 5;
select category ,avg(unit_price) as avg_price from ecommerce_dataset  group by category  order by avg_price  desc; 
select product_id ,sum(quantity *unit_price) as total_renue from ecommerce_dataset group by product_id having total_renue>1000;
select product_id ,sum(quantity *unit_price) as total_renue from ecommerce_dataset group by product_id having total_renue>1000;

SELECT a.order_id, b.order_id FROM ecommerce_dataset a INNER JOIN ecommerce_dataset ON a.customer_email = b.customer_email;
SELECT a.order_id, b.product_name FROM ecommerce_dataset a LEFT JOIN ecommerce_dataset b ON a.product_id = b.product_id;
SELECT a.customer_name, b.order_id FROM ecommerce_dataset a RIGHT JOIN ecommerce_dataset b ON a.customer_email = b.customer_email;

SELECT order_id, customer_name, order_date FROM ecommerce_dataset WHERE customer_email IN (SELECT customer_email FROM ecommerce_dataset GROUP BY customer_email
    HAVING COUNT(order_id) > 5);

SELECT customer_name, AVG(total_amount) AS avg_order_value
FROM (SELECT order_id,customer_name,(quantity * unit_price) - discount AS total_amount FROM ecommerce_dataset) AS order_summary
GROUP BY customer_name;

SELECT order_id,customer_name,(quantity * unit_price) - discount AS order_value,(SELECT SUM((quantity * unit_price) - discount)
     FROM ecommerce_dataset e2 WHERE e2.customer_email = e1.customer_email) AS total_spent
FROM ecommerce_dataset e1;

SELECT order_id, product_id, quantity FROM ecommerce_dataset e1 WHERE quantity > (SELECT AVG(quantity)FROM ecommerce_dataset e2
    WHERE e1.product_id = e2.product_id);
#Total spend and total orders per customer.
CREATE VIEW customer_order_summary AS
SELECT customer_name,customer_email,COUNT(order_id) AS total_orders,SUM((quantity * unit_price) - discount) AS total_spent
FROM ecommerce_dataset GROUP BY customer_name, customer_email;

#Product Sales Summary View
CREATE VIEW product_sales_summary AS SELECT product_id,product_name,category,SUM(quantity) AS total_quantity_sold,
    SUM((quantity * unit_price) - discount) AS total_revenue FROM ecommerce_dataset GROUP BY product_id, product_name, category;

#Daily Sales Trend View
CREATE VIEW daily_sales_trend AS SELECT order_date,COUNT(order_id) AS total_orders,
    SUM((quantity * unit_price) - discount) AS total_revenue FROM ecommerce_dataset GROUP BY order_date ORDER BY order_date;

#Payment Method Analysis View
CREATE VIEW payment_method_analysis AS SELECT payment_method,COUNT(order_id) AS total_orders,SUM((quantity * unit_price) - discount) AS total_revenue
FROM ecommerce_dataset GROUP BY payment_method;

#1. Index on Primary Key (Order ID)
CREATE INDEX idx_order_id ON ecommerce_dataset(order_id);

#2. Index on Customer Columns
CREATE INDEX idx_customer_email ON ecommerce_dataset(customer_email);
CREATE INDEX idx_customer_name ON ecommerce_dataset(customer_name);

#3. Index on Product Columns
CREATE INDEX idx_product_id ON ecommerce_dataset(product_id);
CREATE INDEX idx_product_category ON ecommerce_dataset(category);

#4. Index on Date Column
CREATE INDEX idx_order_date ON ecommerce_dataset(order_date);