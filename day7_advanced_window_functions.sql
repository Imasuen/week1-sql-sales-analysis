-- Day 7: Advanced Window Functions

-- Rank customers by spending within each city.
WITH customer_spending AS (
    SELECT 
        c.customer_name, 
        c.city, 
        SUM(o.quantity * p.price) AS total_spend
    FROM customers c
    JOIN orders o 
        ON c.customer_id = o.customer_id 
    JOIN products p
        ON p.product_id = o.product_id
    GROUP BY c.customer_name, c.city
),
spending_rank AS (
    SELECT 
        customer_name,
        city, 
        total_spend,
        RANK() OVER(PARTITION BY city ORDER BY total_spend DESC) AS spending_rank
    FROM customer_spending
)
SELECT * 
FROM spending_rank
ORDER BY city, total_spend DESC;

-- Show each product's total revenue and overall revenue rank.
WITH product_revenue AS (
    SELECT 
        p.product_name, 
        SUM(o.quantity * p.price) AS total_revenue
    FROM orders o 
    JOIN products p
        ON p.product_id = o.product_id
    GROUP BY p.product_name
),
product_rank AS (
    SELECT 
        product_name, 
        total_revenue,
        RANK() OVER(ORDER BY total_revenue DESC) AS revenue_rank
    FROM product_revenue
)
SELECT 
    product_name,
    total_revenue,
    revenue_rank 
FROM product_rank
ORDER BY total_revenue DESC;

-- Show each customer's total spending and percentage of total company revenue.
WITH customer_spending AS (
    SELECT 
        c.customer_id, 
        c.customer_name, 
        SUM(o.quantity * p.price) AS total_spend
    FROM customers c
    JOIN orders o 
        ON c.customer_id = o.customer_id 
    JOIN products p
        ON p.product_id = o.product_id
    GROUP BY c.customer_id, c.customer_name
),
company_total AS (
    SELECT 
        customer_name,
        total_spend,
        SUM(total_spend) OVER() AS company_revenue
    FROM customer_spending
)
SELECT 
    customer_name, 
    total_spend, 
    company_revenue,
    TRUNC((total_spend / company_revenue) * 100, 1) AS percentage_of_revenue
FROM company_total
ORDER BY percentage_of_revenue DESC;

-- Create a running total of revenue by order date.
WITH daily_revenue AS (
    SELECT 
        o.order_date, 
        SUM(o.quantity * p.price) AS revenue 
    FROM orders o 
    JOIN products p
        ON p.product_id = o.product_id
    GROUP BY o.order_date
),
running_total AS (
    SELECT 
        order_date, 
        revenue,
        SUM(revenue) OVER(ORDER BY order_date) AS running_total
    FROM daily_revenue
)
SELECT * 
FROM running_total
ORDER BY order_date;

-- Find the top product by revenue.
WITH product_amount AS (
    SELECT 
        p.product_name,
        SUM(o.quantity * p.price) AS revenue
    FROM products p
    JOIN orders o 
        ON p.product_id = o.product_id
    GROUP BY p.product_name
),
top_product AS (
    SELECT 
        product_name,
        revenue,
        RANK() OVER(ORDER BY revenue DESC) AS product_rank
    FROM product_amount
)
SELECT * 
FROM top_product
WHERE product_rank = 1;
