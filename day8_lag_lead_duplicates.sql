-- Day 8: LAG, LEAD, Top N Per Group, and Duplicate Detection

-- Previous day revenue using LAG.
WITH daily_revenue AS (
    SELECT 
        o.order_date, 
        SUM(o.quantity * p.price) AS revenue 
    FROM orders o
    JOIN products p
        ON p.product_id = o.product_id
    GROUP BY o.order_date
),
revenue_with_lag AS (
    SELECT 
        order_date, 
        revenue,
        LAG(revenue) OVER(ORDER BY order_date) AS previous_revenue
    FROM daily_revenue
)
SELECT * 
FROM revenue_with_lag
ORDER BY order_date;

-- Revenue change compared to previous day.
WITH daily_revenue AS (
    SELECT 
        o.order_date, 
        SUM(o.quantity * p.price) AS revenue 
    FROM orders o
    JOIN products p
        ON p.product_id = o.product_id
    GROUP BY o.order_date
),
revenue_change AS (
    SELECT 
        order_date, 
        revenue,
        LAG(revenue) OVER(ORDER BY order_date) AS previous_revenue,
        revenue - LAG(revenue) OVER(ORDER BY order_date) AS revenue_change
    FROM daily_revenue
)
SELECT * 
FROM revenue_change
ORDER BY order_date;

-- Next day revenue using LEAD.
WITH daily_revenue AS (
    SELECT 
        o.order_date, 
        SUM(o.quantity * p.price) AS revenue 
    FROM orders o
    JOIN products p
        ON p.product_id = o.product_id
    GROUP BY o.order_date
),
revenue_with_lead AS (
    SELECT 
        order_date, 
        revenue,
        LEAD(revenue) OVER(ORDER BY order_date) AS next_revenue
    FROM daily_revenue
)
SELECT * 
FROM revenue_with_lead
ORDER BY order_date;

-- Top 2 customers per city.
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
WHERE spending_rank <= 2
ORDER BY city, total_spend DESC;

-- Duplicate detection using a temporary table.
DROP TABLE IF EXISTS temp_employee;

CREATE TEMPORARY TABLE temp_employee (
    customer_id INT,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO temp_employee VALUES
(1, 'John Smith', 'London'),
(2, 'Sarah Jones', 'Manchester'),
(3, 'Michael Brown', 'Birmingham'),
(4, 'Emma Wilson', 'Leeds'),
(5, 'David Taylor', 'Liverpool'),
(3, 'Michael Brown', 'Birmingham'),
(4, 'Emma Wilson', 'Leeds');

SELECT 
    customer_id,
    customer_name,
    city,
    COUNT(*) AS duplicate_count
FROM temp_employee
GROUP BY customer_id, customer_name, city
HAVING COUNT(*) > 1;
