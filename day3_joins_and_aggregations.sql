-- Day 3: Joins and Aggregations

-- Show customer names and their orders.
SELECT 
    c.customer_name, 
    o.order_id
FROM orders o
JOIN customers c
    ON c.customer_id = o.customer_id;

-- Show product names purchased by each customer.
SELECT 
    p.product_name, 
    c.customer_name
FROM orders o
JOIN products p 
    ON o.product_id = p.product_id
JOIN customers c
    ON c.customer_id = o.customer_id;

-- Calculate total amount spent per order.
SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    o.quantity,
    p.price,
    o.quantity * p.price AS total_amount
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON o.product_id = p.product_id;

-- Find the highest-value order.
SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    o.quantity,
    p.price,
    o.quantity * p.price AS total_amount
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON o.product_id = p.product_id
ORDER BY total_amount DESC
LIMIT 1;

-- Calculate total revenue by customer.
SELECT 
    c.customer_name, 
    SUM(p.price * o.quantity) AS total_revenue
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p 
    ON p.product_id = o.product_id
GROUP BY c.customer_name
ORDER BY total_revenue DESC;

-- Which city generated the most revenue?
SELECT 
    c.city, 
    SUM(p.price * o.quantity) AS total_revenue 
FROM orders o
JOIN customers c 
    ON c.customer_id = o.customer_id 
JOIN products p 
    ON p.product_id = o.product_id
GROUP BY c.city
ORDER BY total_revenue DESC;

-- Which product sold the highest quantity?
SELECT 
    p.product_name, 
    SUM(o.quantity) AS total_quantity 
FROM orders o
JOIN products p 
    ON o.product_id = p.product_id 
GROUP BY p.product_name 
ORDER BY total_quantity DESC
LIMIT 1;

-- What is the average order value?
SELECT 
    AVG(o.quantity * p.price) AS average_order_value
FROM orders o 
JOIN products p 
    ON p.product_id = o.product_id;

-- Which products have never been ordered?
SELECT 
    p.product_id, 
    p.product_name 
FROM products p
LEFT JOIN orders o
    ON p.product_id = o.product_id 
WHERE o.product_id IS NULL;
