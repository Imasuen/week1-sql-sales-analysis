# Week 1 SQL Sales Analysis Project

## Project Overview

This project contains my Week 1 SQL practice as part of my Data Engineering self-study roadmap.

The project uses a simple sales database with three main tables:

- `customers`
- `products`
- `orders`

The goal was to practise SQL fundamentals, joins, aggregations, subqueries, CTEs, and window functions using PostgreSQL.

## Skills Practised

- Creating tables with primary keys and foreign keys
- Inserting sample data
- SELECT statements
- WHERE filtering
- INNER JOIN and LEFT JOIN
- Aggregations with SUM, AVG, COUNT, MAX
- GROUP BY and HAVING
- Subqueries
- Common Table Expressions (CTEs)
- Window functions:
  - ROW_NUMBER()
  - RANK()
  - LAG()
  - LEAD()
- Running totals
- Revenue analysis
- Duplicate detection

## Database Tables

### customers

Stores customer information.

| Column | Description |
|---|---|
| customer_id | Unique customer identifier |
| customer_name | Customer full name |
| city | Customer city |

### products

Stores product details.

| Column | Description |
|---|---|
| product_id | Unique product identifier |
| product_name | Product name |
| price | Product price |

### orders

Stores customer orders.

| Column | Description |
|---|---|
| order_id | Unique order identifier |
| customer_id | Foreign key linked to customers |
| product_id | Foreign key linked to products |
| quantity | Number of products ordered |
| order_date | Date of the order |

## Key Business Questions Answered

1. Which city generated the most revenue?
2. Which product sold the highest quantity?
3. What is the average order value?
4. Which products have never been ordered?
5. Which customers spent above average?
6. Which cities generated above-average revenue?
7. Who is the top spending customer?
8. What is the running total revenue by order date?
9. What was the previous and next day revenue?
10. Who are the top customers by city?
11. How can duplicate records be detected?

## File Structure

```text
week1-sql-sales-analysis/
│
├── README.md
├── schema.sql
├── insert_data.sql
├── day3_joins_and_aggregations.sql
├── day4_interview_questions.sql
├── day5_subqueries.sql
├── day6_ctes_and_window_functions.sql
├── day7_advanced_window_functions.sql
├── day8_lag_lead_duplicates.sql
└── screenshots/
```

## How to Run This Project

1. Open PostgreSQL or pgAdmin.
2. Run `schema.sql` first.
3. Run `insert_data.sql` second.
4. Run the exercise files in order:
   - `day3_joins_and_aggregations.sql`
   - `day4_interview_questions.sql`
   - `day5_subqueries.sql`
   - `day6_ctes_and_window_functions.sql`
   - `day7_advanced_window_functions.sql`
   - `day8_lag_lead_duplicates.sql`
  
## Query Results

### Revenue by City

![Revenue by City](screenshots/revenue%20by%20city.png)

### Top Spending Customer

![Top Spending Customer](screenshots/top%20spending%20customer.png)

### Product Revenue Ranking

![Product Revenue Ranking](screenshots/product%20revenue%20ranking.png)

### Running Total Revenue

![Running Total Revenue](screenshots/running%20total%20revenue.png)

### Previous Day Revenue (LAG)

![Previous Day Revenue](screenshots/previous%20day%20revenue%20\(lead\).png)

### Next Day Revenue (LEAD)

![Next Day Revenue](screenshots/Next%20day%20revenue%20\(lag\).png)

## Tools Used

- PostgreSQL
- pgAdmin
- SQL
- GitHub

## Author

Ovbokhan Imasuen
