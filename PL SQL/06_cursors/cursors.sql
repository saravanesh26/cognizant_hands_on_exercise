-- Scenario 1: explicit cursor prints every current-month transaction and its customer.
DECLARE
    CURSOR GenerateMonthlyStatements IS
        SELECT c.Name, a.AccountID, t.TransactionDate, t.TransactionType, t.Amount
        FROM Transactions t
        JOIN Accounts a ON a.AccountID = t.AccountID
        JOIN Customers c ON c.CustomerID = a.CustomerID
        WHERE t.TransactionDate >= TRUNC(SYSDATE, 'MM')
          AND t.TransactionDate < ADD_MONTHS(TRUNC(SYSDATE, 'MM'), 1)
        ORDER BY c.Name, t.TransactionDate;
    statement_rec GenerateMonthlyStatements%ROWTYPE;
BEGIN
    OPEN GenerateMonthlyStatements;
    LOOP
        FETCH GenerateMonthlyStatements INTO statement_rec;
        EXIT WHEN GenerateMonthlyStatements%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(statement_rec.Name || ' | Account ' || statement_rec.AccountID ||
            ' | ' || TO_CHAR(statement_rec.TransactionDate, 'YYYY-MM-DD') || ' | ' ||
            statement_rec.TransactionType || ' | ' || statement_rec.Amount);
    END LOOP;
    CLOSE GenerateMonthlyStatements;
END;
/

-- Scenario 2: input is the editable annual maintenance fee constant. Output: lower account balances.
DECLARE
    v_annual_fee CONSTANT NUMBER := 100;
    CURSOR ApplyAnnualFee IS SELECT AccountID, Balance FROM Accounts FOR UPDATE;
    account_rec ApplyAnnualFee%ROWTYPE;
BEGIN
    OPEN ApplyAnnualFee;
    LOOP
        FETCH ApplyAnnualFee INTO account_rec;
        EXIT WHEN ApplyAnnualFee%NOTFOUND;
        IF account_rec.Balance >= v_annual_fee THEN
            UPDATE Accounts SET Balance = Balance - v_annual_fee, LastModified = SYSDATE
            WHERE CURRENT OF ApplyAnnualFee;
            DBMS_OUTPUT.PUT_LINE('Annual fee applied to account ' || account_rec.AccountID);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Fee skipped for account ' || account_rec.AccountID || ': insufficient balance');
        END IF;
    END LOOP;
    CLOSE ApplyAnnualFee;
    COMMIT;
END;
/

-- Scenario 3: policy: loans >= 10,000 receive 4.5%; others receive 5%.
DECLARE
    CURSOR UpdateLoanInterestRates IS SELECT LoanID, LoanAmount, InterestRate FROM Loans FOR UPDATE;
    loan_rec UpdateLoanInterestRates%ROWTYPE;
    v_new_rate NUMBER;
BEGIN
    OPEN UpdateLoanInterestRates;
    LOOP
        FETCH UpdateLoanInterestRates INTO loan_rec;
        EXIT WHEN UpdateLoanInterestRates%NOTFOUND;
        v_new_rate := CASE WHEN loan_rec.LoanAmount >= 10000 THEN 4.5 ELSE 5 END;
        UPDATE Loans SET InterestRate = v_new_rate WHERE CURRENT OF UpdateLoanInterestRates;
        DBMS_OUTPUT.PUT_LINE('Loan ' || loan_rec.LoanID || ' rate changed from ' ||
                             loan_rec.InterestRate || '% to ' || v_new_rate || '%');
    END LOOP;
    CLOSE UpdateLoanInterestRates;
    COMMIT;
END;
/
