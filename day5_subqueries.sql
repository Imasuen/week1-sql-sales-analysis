-- Day 5: Subqueries

-- Products above average price.
SELECT 
    product_name, 
    price
FROM products
WHERE price > (
    SELECT AVG(price) 
    FROM products
);

-- Customers spending above average customer spending.
SELECT 
    c.customer_name,
    SUM(o.quantity * p.price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN products p
    ON p.product_id = o.product_id
GROUP BY c.customer_name
HAVING SUM(o.quantity * p.price) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT 
            SUM(o.quantity * p.price) AS customer_total
        FROM customers c
        JOIN orders o
            ON c.customer_id = o.customer_id
        JOIN products p
            ON p.product_id = o.product_id
        GROUP BY c.customer_name
    ) AS customer_spending
);

-- Most expensive product.
SELECT 
    product_name,
    price
FROM products
WHERE price = (
    SELECT MAX(price) 
    FROM products
);

-- Orders larger than average order value.
SELECT 
    o.order_id, 
    o.quantity * p.price AS order_value 
FROM orders o
JOIN products p 
    ON p.product_id = o.product_id
WHERE o.quantity * p.price > (
    SELECT AVG(o.quantity * p.price)
    FROM orders o 
    JOIN products p 
        ON o.product_id = p.product_id
);

-- Cities generating above-average revenue.
SELECT 
    c.city,
    SUM(o.quantity * p.price) AS city_revenue
FROM orders o
JOIN customers c
    ON c.customer_id = o.customer_id
JOIN products p
    ON p.product_id = o.product_id
GROUP BY c.city
HAVING SUM(o.quantity * p.price) > (
    SELECT AVG(city_total)
    FROM (
        SELECT 
            SUM(o.quantity * p.price) AS city_total
        FROM orders o
        JOIN customers c
            ON c.customer_id = o.customer_id
        JOIN products p
            ON p.product_id = o.product_id
        GROUP BY c.city
    ) AS city_revenue_table
);

-- Top spending customer without using LIMIT.
SELECT 
    c.customer_name,
    SUM(o.quantity * p.price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN products p
    ON p.product_id = o.product_id
GROUP BY c.customer_name
HAVING SUM(o.quantity * p.price) = (
    SELECT MAX(customer_total)
    FROM (
        SELECT 
            SUM(o.quantity * p.price) AS customer_total
        FROM customers c
        JOIN orders o
            ON c.customer_id = o.customer_id
        JOIN products p
            ON p.product_id = o.product_id
        GROUP BY c.customer_name
    ) AS customer_spending
);
