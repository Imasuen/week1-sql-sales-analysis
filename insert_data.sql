-- Week 1 SQL Sales Analysis Project
-- Sample data insertion script

INSERT INTO customers VALUES
(1, 'John Smith', 'London'),
(2, 'Sarah Jones', 'Manchester'),
(3, 'Michael Brown', 'Birmingham'),
(4, 'Emma Wilson', 'Leeds'),
(5, 'David Taylor', 'Liverpool');

INSERT INTO products VALUES
(101, 'Laptop', 850.00),
(102, 'Keyboard', 45.00),
(103, 'Mouse', 25.00),
(104, 'Monitor', 220.00),
(105, 'Headset', 75.00);

INSERT INTO orders VALUES
(1001, 1, 101, 1, '2026-06-01'),
(1002, 1, 103, 2, '2026-06-02'),
(1003, 2, 102, 1, '2026-06-02'),
(1004, 3, 104, 1, '2026-06-03'),
(1005, 4, 105, 2, '2026-06-03'),
(1006, 5, 101, 1, '2026-06-04'),
(1007, 2, 104, 1, '2026-06-04'),
(1008, 3, 103, 3, '2026-06-05'),
(1009, 4, 102, 2, '2026-06-05'),
(1010, 5, 105, 1, '2026-06-06');
