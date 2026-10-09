# Results and validation notes

All figures below are calculated from the 20 synthetic transactions included in the SQL script.

## Data checks
- Customers: 10
- Transactions: 20
- Total amount across all transactions: ₹357,000
- Successful transactions: 18
- Failed transactions: 2

## Status summary
| Status | Count | Amount |
|---|---:|---:|
| Success | 18 | ₹332,000 |
| Failed | 2 | ₹25,000 |
| Total | 20 | ₹357,000 |

## Totals by transaction type
| Type | Count | Total amount |
|---|---:|---:|
| Deposit | 7 | ₹222,000 |
| Transfer | 6 | ₹93,000 |
| Withdrawal | 7 | ₹42,000 |

## Highest customer totals (all statuses)
| Customer | Total amount |
|---|---:|
| Vikram Yadav | ₹59,000 |
| Ananya Das | ₹57,000 |
| Neha Gupta | ₹56,000 |

## Highest customer totals (successful transactions only)
| Customer | Successful total |
|---|---:|
| Vikram Yadav | ₹59,000 |
| Ananya Das | ₹57,000 |
| Neha Gupta | ₹56,000 |

## Average transaction
- Average transaction amount: ₹17,850 (₹357,000 / 20).
- Query Q10 returns transactions strictly greater than ₹17,850.

## Interpretation
These results describe only this small synthetic sample. Deposits have the highest total amount in the sample, but total transaction amount is not revenue or profit. Failed transactions are included in all-status totals unless a query explicitly filters for `Success`.
