/*
PROJECT: Banking Transaction Analysis
TOOL: Microsoft SQL Server (SSMS)
LEVEL: Beginner to Intermediate
DESCRIPTION: Analyze customer transactions, transaction types, successful activity,
high-value transactions, and customer-level behavior.

Run this script in SQL Server Management Studio.
It creates a new database named BankingAnalysis. If you already created the database
and inserted the sample records during practice, skip the setup/INSERT sections to
avoid duplicate primary-key errors.
*/

-- =========================================================
-- 1. DATABASE AND TABLE SETUP
-- =========================================================
IF DB_ID('BankingAnalysis') IS NULL
    CREATE DATABASE BankingAnalysis;
GO

USE BankingAnalysis;
GO

IF OBJECT_ID('dbo.Transactions', 'U') IS NOT NULL DROP TABLE dbo.Transactions;
IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL DROP TABLE dbo.Customers;
GO

CREATE TABLE dbo.Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    account_type VARCHAR(30) NOT NULL,
    join_date DATE NOT NULL
);

CREATE TABLE dbo.Transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    transaction_date DATE NOT NULL,
    transaction_type VARCHAR(30) NOT NULL,
    amount DECIMAL(12,2) NOT NULL CHECK (amount >= 0),
    transaction_status VARCHAR(20) NOT NULL,
    CONSTRAINT FK_Transactions_Customers
        FOREIGN KEY (customer_id) REFERENCES dbo.Customers(customer_id)
);
GO

-- =========================================================
-- 2. SAMPLE DATA
-- =========================================================
INSERT INTO dbo.Customers
(customer_id, customer_name, city, account_type, join_date)
VALUES
(1, 'Aarav Sharma', 'Delhi', 'Savings', '2025-01-15'),
(2, 'Priya Verma', 'Mumbai', 'Current', '2025-02-10'),
(3, 'Rahul Singh', 'Delhi', 'Savings', '2025-03-05'),
(4, 'Neha Gupta', 'Jaipur', 'Savings', '2025-03-20'),
(5, 'Amit Kumar', 'Mumbai', 'Current', '2025-04-12'),
(6, 'Sneha Patel', 'Ahmedabad', 'Savings', '2025-05-01'),
(7, 'Rohan Mehta', 'Delhi', 'Current', '2025-05-18'),
(8, 'Ananya Das', 'Kolkata', 'Savings', '2025-06-22'),
(9, 'Vikram Yadav', 'Jaipur', 'Current', '2025-07-09'),
(10, 'Isha Roy', 'Kolkata', 'Savings', '2025-08-14');

INSERT INTO dbo.Transactions
(transaction_id, customer_id, transaction_date, transaction_type, amount, transaction_status)
VALUES
(101, 1, '2025-09-01', 'Deposit', 25000, 'Success'),
(102, 2, '2025-09-01', 'Withdrawal', 5000, 'Success'),
(103, 3, '2025-09-02', 'Transfer', 12000, 'Success'),
(104, 1, '2025-09-03', 'Withdrawal', 3000, 'Success'),
(105, 4, '2025-09-03', 'Deposit', 40000, 'Success'),
(106, 5, '2025-09-04', 'Transfer', 18000, 'Failed'),
(107, 6, '2025-09-04', 'Deposit', 15000, 'Success'),
(108, 7, '2025-09-05', 'Withdrawal', 8000, 'Success'),
(109, 8, '2025-09-05', 'Transfer', 22000, 'Success'),
(110, 9, '2025-09-06', 'Deposit', 50000, 'Success'),
(111, 10, '2025-09-06', 'Withdrawal', 7000, 'Failed'),
(112, 2, '2025-09-07', 'Deposit', 30000, 'Success'),
(113, 3, '2025-09-07', 'Withdrawal', 4000, 'Success'),
(114, 4, '2025-09-08', 'Transfer', 16000, 'Success'),
(115, 5, '2025-09-08', 'Deposit', 27000, 'Success'),
(116, 6, '2025-09-09', 'Withdrawal', 6000, 'Success'),
(117, 7, '2025-09-09', 'Transfer', 14000, 'Success'),
(118, 8, '2025-09-10', 'Deposit', 35000, 'Success'),
(119, 9, '2025-09-10', 'Withdrawal', 9000, 'Success'),
(120, 10, '2025-09-11', 'Transfer', 11000, 'Success');
GO

-- =========================================================
-- 3. DATA VALIDATION
-- =========================================================
SELECT COUNT(*) AS total_customers FROM dbo.Customers;       -- Expected: 10
SELECT COUNT(*) AS total_transactions FROM dbo.Transactions; -- Expected: 20

-- =========================================================
-- 4. BUSINESS ANALYSIS QUERIES
-- =========================================================

-- Q1. View all transactions
SELECT *
FROM dbo.Transactions
ORDER BY transaction_date, transaction_id;

-- Q2. Successful transactions above INR 15,000
SELECT transaction_id, customer_id, transaction_type, amount, transaction_status
FROM dbo.Transactions
WHERE transaction_status = 'Success'
  AND amount > 15000
ORDER BY amount DESC;

-- Q3. Total transaction amount and count by transaction type
SELECT
    transaction_type,
    SUM(amount) AS total_transaction_amount,
    COUNT(*) AS transaction_count
FROM dbo.Transactions
GROUP BY transaction_type
ORDER BY total_transaction_amount DESC;

-- Q4. Transaction status summary
SELECT
    transaction_status,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM dbo.Transactions
GROUP BY transaction_status
ORDER BY transaction_count DESC;

-- Q5. Overall successful transaction KPIs
SELECT
    SUM(amount) AS total_successful_transaction_amount,
    COUNT(*) AS successful_transaction_count
FROM dbo.Transactions
WHERE transaction_status = 'Success';

-- Q6. Top 3 customers by total transaction amount (includes failed transactions)
SELECT TOP (3)
    c.customer_id,
    c.customer_name,
    SUM(t.amount) AS total_transaction_amount
FROM dbo.Customers AS c
INNER JOIN dbo.Transactions AS t
    ON c.customer_id = t.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_transaction_amount DESC;

-- Q7. Top 3 customers by successful transaction amount only
SELECT TOP (3)
    c.customer_id,
    c.customer_name,
    SUM(t.amount) AS successful_transaction_amount
FROM dbo.Customers AS c
INNER JOIN dbo.Transactions AS t
    ON c.customer_id = t.customer_id
WHERE t.transaction_status = 'Success'
GROUP BY c.customer_id, c.customer_name
ORDER BY successful_transaction_amount DESC;

-- Q8. Customers with more than 2 successful transactions
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(*) AS successful_transaction_count
FROM dbo.Customers AS c
INNER JOIN dbo.Transactions AS t
    ON c.customer_id = t.customer_id
WHERE t.transaction_status = 'Success'
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(*) > 2
ORDER BY successful_transaction_count DESC, c.customer_name;

-- Q9. Highest individual transaction for each customer
SELECT
    c.customer_id,
    c.customer_name,
    MAX(t.amount) AS highest_transaction_amount
FROM dbo.Customers AS c
INNER JOIN dbo.Transactions AS t
    ON c.customer_id = t.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY highest_transaction_amount DESC;

-- Q10. Transactions above the overall average transaction amount
SELECT transaction_id, customer_id, transaction_type, amount, transaction_status
FROM dbo.Transactions
WHERE amount > (SELECT AVG(amount) FROM dbo.Transactions)
ORDER BY amount DESC;

-- Q11. Customers who made at least one transaction above INR 30,000 (IN subquery)
SELECT customer_id, customer_name, city
FROM dbo.Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM dbo.Transactions
    WHERE amount > 30000
)
ORDER BY customer_name;

-- Q12. Total transaction amount by customer city
SELECT
    c.city,
    SUM(t.amount) AS total_transaction_amount,
    COUNT(t.transaction_id) AS transaction_count
FROM dbo.Customers AS c
INNER JOIN dbo.Transactions AS t
    ON c.customer_id = t.customer_id
GROUP BY c.city
ORDER BY total_transaction_amount DESC;

-- Q13. Success rate by transaction type
SELECT
    transaction_type,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN transaction_status = 'Success' THEN 1 ELSE 0 END) AS successful_transactions,
    CAST(
        100.0 * SUM(CASE WHEN transaction_status = 'Success' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(5,2)
    ) AS success_rate_percent
FROM dbo.Transactions
GROUP BY transaction_type
ORDER BY success_rate_percent DESC;

-- Q14. Daily transaction trend
SELECT
    transaction_date,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_transaction_amount
FROM dbo.Transactions
GROUP BY transaction_date
ORDER BY transaction_date;

-- Q15. Rank customers by successful transaction amount (window function)
WITH CustomerTotals AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(t.amount) AS successful_transaction_amount
    FROM dbo.Customers AS c
    INNER JOIN dbo.Transactions AS t
        ON c.customer_id = t.customer_id
    WHERE t.transaction_status = 'Success'
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_id,
    customer_name,
    successful_transaction_amount,
    DENSE_RANK() OVER (ORDER BY successful_transaction_amount DESC) AS customer_rank
FROM CustomerTotals
ORDER BY customer_rank, customer_name;

-- Q16. Compare successful and failed transaction amounts
SELECT
    transaction_status,
    COUNT(*) AS transaction_count,
    SUM(amount) AS transaction_amount,
    AVG(amount) AS average_transaction_amount
FROM dbo.Transactions
GROUP BY transaction_status
ORDER BY transaction_amount DESC;
