# Banking Transaction Analysis (SQL Server)

## Project overview

A beginner-to-intermediate, portfolio-ready SQL project that analyses a
fictional bank's customers and transactions using Microsoft SQL Server
(SSMS). The project demonstrates how SQL can answer practical business
questions about transaction values, customer activity, transaction
types, and success rates.

> **Dataset note:** This is a small synthetic learning dataset (10
> customers and 20 transactions). It is not real banking data and should
> not be used to make operational or fraud decisions.

## Business objectives

-   Summarize transaction value and volume.
-   Compare transaction types and transaction statuses.
-   Identify high-value transactions and customers.
-   Analyse customer activity and city-level transaction patterns.
-   Calculate transaction success rates.
-   Practise SQL from filtering and aggregation through joins,
    subqueries, CTEs, and window functions.

## Tools and SQL concepts

-   Microsoft SQL Server / SQL Server Management Studio (SSMS)
-   `SELECT`, `WHERE`, `ORDER BY`, `TOP`
-   Aggregate functions: `SUM`, `COUNT`, `AVG`, `MAX`
-   `GROUP BY` and `HAVING`
-   `INNER JOIN`
-   Subqueries and `IN`
-   `CASE`, `NULLIF`, CTEs
-   Window function: `DENSE_RANK()`

## Repository files

-   `banking_transaction_analysis.sql` --- database setup, synthetic
    data, validation checks, and 16 business analysis queries.
-   `linkedin_post.md` --- a ready-to-edit LinkedIn project post.
-   `insights_and_validation.md` --- expected key metrics and
    interpretation notes.

## Database schema

### Customers

  Column            Description
  ----------------- ------------------------------------------
  `customer_id`     Unique customer identifier (primary key)
  `customer_name`   Synthetic customer name
  `city`            Customer city
  `account_type`    Savings or Current
  `join_date`       Date the customer joined

### Transactions

  Column                 Description
  ---------------------- ---------------------------------------------
  `transaction_id`       Unique transaction identifier (primary key)
  `customer_id`          Customer reference (foreign key)
  `transaction_date`     Transaction date
  `transaction_type`     Deposit, Withdrawal, or Transfer
  `amount`               Transaction amount in INR
  `transaction_status`   Success or Failed

## How to run

1.  Open SQL Server Management Studio and connect to your SQL Server
    instance.
2.  Open `banking_transaction_analysis.sql`.
3.  Run the script from top to bottom. **Warning:** the script drops and
    recreates the two project tables in `BankingAnalysis`, so do not run
    it against tables containing data you need to preserve.
4.  Run the validation queries. Expected counts are 10 customers and 20
    transactions.
5.  Run the analysis queries individually and review their outputs.

If you already created these tables during guided practice, save your
work if needed and understand that rerunning the complete script will
drop and recreate the two tables.

## Key findings from the synthetic dataset

-   20 transactions with a total transaction amount of ₹357,000.
-   18 successful transactions totalling ₹332,000; 2 failed transactions
    totalling ₹25,000.
-   Deposits total ₹222,000 across 7 transactions.
-   Transfers total ₹93,000 across 6 transactions.
-   Withdrawals total ₹42,000 across 7 transactions.
-   The three largest customer totals when **all statuses are included**
    are Vikram Yadav (₹59,000), Ananya Das (₹57,000), and Neha Gupta
    (₹56,000).
-   When **only successful transactions** are included, the top three
    are Vikram Yadav (₹59,000), Ananya Das (₹57,000), and Neha Gupta
    (₹56,000). In this dataset, the failed transactions belong to
    customers whose totals do not change that top-three ranking.

## Important interpretation note

Transaction amount is not the same as bank revenue, profit, customer
balance, or fraud. This project analyses transaction records only. A
production analysis would need clear business definitions, larger
validated data, privacy controls, and appropriate risk-review
procedures.

## Suggested next improvements

-   Expand the dataset to thousands of rows.
-   Add a date/calendar table and analyse weekly/monthly trends.
-   Add constraints and data-quality checks for transaction statuses and
    types.
-   Add more business questions and document each query's result.
-   After the SQL phase in your learning schedule, reuse the validated
    SQL findings in a separate Power BI project.
