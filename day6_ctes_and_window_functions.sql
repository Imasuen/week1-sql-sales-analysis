-- Day 6: CTEs and Window Functions

-- Customer total spending using a CTE.
WITH customer_spending AS (
    SELECT 
        c.customer_name, 
        SUM(o.quantity * p.price) AS total_spent
    FROM customers c
    JOIN orders o 
        ON c.customer_id = o.customer_id
    JOIN products p 
        ON p.product_id = o.product_id
    GROUP BY c.customer_name
)
SELECT * 
FROM customer_spending;

-- Customers spending more than 500.
WITH customer_spending AS (
    SELECT 
        c.customer_name, 
        SUM(o.quantity * p.price) AS total_spent
    FROM customers c
    JOIN orders o 
        ON c.customer_id = o.customer_id
    JOIN products p 
        ON p.product_id = o.product_id
    GROUP BY c.customer_name
)
SELECT * 
FROM customer_spending 
WHERE total_spent > 500;

-- Calculate revenue by city using a CTE.
WITH city_revenue AS (
    SELECT 
        c.city, 
        SUM(o.quantity * p.price) AS revenue
    FROM customers c
    JOIN orders o 
        ON c.customer_id = o.customer_id 
    JOIN products p
        ON p.product_id = o.product_id
    GROUP BY c.city
)
SELECT *
FROM city_revenue
ORDER BY revenue DESC;

-- Ranking products by price using ROW_NUMBER.
WITH product_rank AS (
    SELECT 
        product_name,
        price,
        ROW_NUMBER() OVER(ORDER BY price DESC) AS price_rank
    FROM products
)
SELECT * 
FROM product_rank;

-- Ranking products by price using RANK.
WITH product_rank AS (
    SELECT 
        product_name,
        price,
        RANK() OVER(ORDER BY price DESC) AS price_rank
    FROM products
)
SELECT * 
FROM product_rank;

-- Highest spending customer ranking.
WITH customer_spending AS (
    SELECT 
        c.customer_name, 
        SUM(o.quantity * p.price) AS total_spending
    FROM customers c
    JOIN orders o 
        ON c.customer_id = o.customer_id 
    JOIN products p
        ON p.product_id = o.product_id
    GROUP BY c.customer_name
)
SELECT 
    customer_name,
    total_spending,
    RANK() OVER(ORDER BY total_spending DESC) AS spending_rank
FROM customer_spending;

-- Top 3 customers by spending.
WITH customer_spending AS (
    SELECT 
        c.customer_name, 
        SUM(o.quantity * p.price) AS total_spending
    FROM customers c
    JOIN orders o 
        ON c.customer_id = o.customer_id 
    JOIN products p
        ON p.product_id = o.product_id
    GROUP BY c.customer_name
),
ranked_customers AS (
    SELECT 
        customer_name,
        total_spending,
        RANK() OVER(ORDER BY total_spending DESC) AS spending_rank
    FROM customer_spending
)
SELECT *
FROM ranked_customers
WHERE spending_rank <= 3
ORDER BY spending_rank;
