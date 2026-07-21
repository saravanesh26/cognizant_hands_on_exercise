# PL/SQL Banking Exercises

This folder contains completed Oracle PL/SQL solutions for all seven exercises in the brief. Each exercise has its own folder and one script containing its three scenarios.

## Run order

1. Enable output in SQL Developer or SQL*Plus: `SET SERVEROUTPUT ON`.
2. Run `00_schema_setup.sql` to create the banking tables, supporting audit/error objects, and sample data.
3. Run the exercise scripts in numerical order. Exercises 2, 3, 4, and 7 create reusable procedures, functions, or packages; execute their script before calling those objects.

## What is included

| Folder | Work completed | Inputs | Expected output |
| --- | --- | --- | --- |
| `01_control_structures` | Discounts senior customers' loan rates, flags VIP customers, and prints loan reminders. | Data in `Customers` and `Loans`. | Updated interest rates/VIP flags; reminder text in `DBMS_OUTPUT`. |
| `02_error_handling` | Safe fund transfer, salary update, and customer insert with error logging and rollback. | Account/customer/employee IDs, amounts, and percentages. | Successful changes or readable `DBMS_OUTPUT` errors recorded in `ErrorLog`. |
| `03_stored_procedures` | Applies savings interest, department bonuses, and account-to-account transfers. | Bonus percentage/department; source, destination, and transfer amount. | Updated balances or salaries; transfer success/error message. |
| `04_functions` | Calculates an age, a loan monthly instalment, and whether an account has sufficient funds. | DOB; loan amount/rate/term; account ID/amount. | A number for age/instalment and `TRUE`/`FALSE` for balance checking. |
| `05_triggers` | Maintains customer timestamps, audits transactions, and validates deposits/withdrawals. | `UPDATE Customers` and `INSERT Transactions` statements. | Automatic timestamp/audit rows; invalid transactions are rejected. |
| `06_cursors` | Prints current-month statements, deducts annual fees, and applies a loan-rate policy. | Existing transaction/account/loan data; editable fee and policy constants. | Statement text in `DBMS_OUTPUT`; changed account balances and loan rates. |
| `07_packages` | Customer, employee, and account-management package specifications and bodies. | Parameters defined by each public package procedure/function. | Inserted/updated records and returned balances or salaries. |

## Notes

- Monetary values use `NUMBER`; currency formatting in messages is illustrative.
- `Transactions.Amount` is always positive. Its `TransactionType` determines whether it is a deposit or withdrawal.
- `ErrorLog` uses an autonomous logging procedure so a failure can be logged even when the main transaction is rolled back.
