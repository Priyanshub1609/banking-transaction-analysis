# Banking Transaction Analysis (SQL Server)

## Project overview
A SQL Server project analysing synthetic banking customers and transactions to answer practical business questions about transaction value, customer activity, transaction types, and transaction success.

> **Dataset note:** This is a small synthetic learning dataset (10 customers and 20 transactions), not real bank data. Results are suitable for SQL practice only and should not be used for operational or fraud decisions.

## Business objectives
- Summarise transaction value and volume.
- Compare transaction types and transaction statuses.
- Identify high-value transactions and customers.
- Analyse customer activity and city-level transaction patterns.
- Calculate transaction success rates.
- Practise SQL filtering, aggregation, joins, subqueries, CTEs, and window functions.

## Tools and SQL concepts
Microsoft SQL Server / SSMS; `SELECT`, `WHERE`, `ORDER BY`, `TOP`, `SUM`, `COUNT`, `AVG`, `MAX`, `GROUP BY`, `HAVING`, `INNER JOIN`, subqueries, `IN`, `CASE`, `NULLIF`, CTEs, and `DENSE_RANK()`.

## Repository files
- `banking_transaction_analysis.sql` — database setup, sample data, validation checks, and 16 business analysis queries.
- `customers.csv` and `transactions.csv` — synthetic source datasets.
- `insights_and_validation.md` — key metrics and result checks.
- `linkedin_post.md` — editable LinkedIn project post.

## Schema
### Customers
| Column | Description |
|---|---|
| `customer_id` | Unique customer ID (primary key) |
| `customer_name` | Synthetic customer name |
| `city` | Customer city |
| `account_type` | Savings or Current |
| `join_date` | Customer join date |

### Transactions
| Column | Description |
|---|---|
| `transaction_id` | Unique transaction ID (primary key) |
| `customer_id` | Customer reference (foreign key) |
| `transaction_date` | Transaction date |
| `transaction_type` | Deposit, Withdrawal, or Transfer |
| `amount` | Transaction amount in INR |
| `transaction_status` | Success or Failed |

## How to run
1. Open SQL Server Management Studio and connect to your SQL Server instance.
2. Open `banking_transaction_analysis.sql`.
3. Read the setup section before running the script. **Warning:** it drops and recreates the two project tables in `BankingAnalysis`; do not run it against tables you need to preserve.
4. Run the script, then check that the validation queries return 10 customers and 20 transactions.
5. Execute business analysis queries individually and compare results with `insights_and_validation.md`.

If you have already created these tables in your practice database, save any work you need before running the full script because it recreates the tables.

## Key findings (synthetic dataset)
- 20 transactions with total transaction amount of ₹357,000.
- 18 successful transactions totalling ₹332,000; 2 failed transactions totalling ₹25,000.
- Deposits: ₹222,000 across 7 transactions.
- Transfers: ₹93,000 across 6 transactions.
- Withdrawals: ₹42,000 across 7 transactions.
- Average transaction amount: ₹17,850.
- Top customer totals are Vikram Yadav (₹59,000), Ananya Das (₹57,000), and Neha Gupta (₹56,000).

## Interpretation and limitations
Transaction amount is not the same as bank revenue, profit, customer balance, or fraud. The dataset is small and synthetic, so findings only demonstrate query logic. A real analysis would require validated production data, clear business definitions, privacy controls, and careful risk review.

## Potential next steps
- Expand the dataset with thousands of generated transactions.
- Add data-quality checks and status/type constraints.
- Extend the analysis to weekly and monthly trends.
- When the learning schedule moves to Power BI, use validated findings in a separate dashboard project.
