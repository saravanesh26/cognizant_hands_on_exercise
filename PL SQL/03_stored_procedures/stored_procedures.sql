-- Scenario 1: no input. Adds 1% monthly interest to all savings accounts.
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
    UPDATE Accounts
    SET Balance = ROUND(Balance * 1.01, 2), LastModified = SYSDATE
    WHERE UPPER(AccountType) = 'SAVINGS';
    COMMIT;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' savings account(s) updated.');
END;
/

-- Scenario 2 input: department and bonus percentage. Output: updated salaries.
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    p_department IN VARCHAR2,
    p_bonus_percentage IN NUMBER
) IS
BEGIN
    IF p_bonus_percentage < 0 THEN
        RAISE_APPLICATION_ERROR(-20010, 'Bonus percentage cannot be negative.');
    END IF;
    UPDATE Employees
    SET Salary = ROUND(Salary * (1 + p_bonus_percentage / 100), 2)
    WHERE UPPER(Department) = UPPER(p_department);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' employee bonus record(s) updated.');
END;
/

-- Scenario 3 input: source account, destination account, and amount. Output: transferred balance or error.
CREATE OR REPLACE PROCEDURE TransferFunds(
    p_from_account_id IN NUMBER,
    p_to_account_id IN NUMBER,
    p_amount IN NUMBER
) IS
    v_source_balance Accounts.Balance%TYPE;
BEGIN
    IF p_amount <= 0 OR p_from_account_id = p_to_account_id THEN
        RAISE_APPLICATION_ERROR(-20011, 'Use different accounts and a positive amount.');
    END IF;
    SELECT Balance INTO v_source_balance FROM Accounts
    WHERE AccountID = p_from_account_id FOR UPDATE;
    IF v_source_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20012, 'Insufficient balance for transfer.');
    END IF;
    UPDATE Accounts SET Balance = Balance - p_amount, LastModified = SYSDATE
    WHERE AccountID = p_from_account_id;
    UPDATE Accounts SET Balance = Balance + p_amount, LastModified = SYSDATE
    WHERE AccountID = p_to_account_id;
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20013, 'Destination account does not exist.');
    END IF;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Funds transferred successfully.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Transfer failed: source account does not exist.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Transfer failed: ' || SQLERRM);
END;
/

-- Example calls: BEGIN ProcessMonthlyInterest; UpdateEmployeeBonus('IT', 10); TransferFunds(1, 2, 50); END;
-- /
