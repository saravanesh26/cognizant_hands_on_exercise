-- Common autonomous logger. Its COMMIT preserves an error record after a caller rolls back.
CREATE OR REPLACE PROCEDURE LogError(
    p_procedure_name IN VARCHAR2,
    p_error_message IN VARCHAR2
) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    INSERT INTO ErrorLog (ErrorID, ProcedureName, ErrorMessage, LoggedAt)
    VALUES (ErrorLog_Seq.NEXTVAL, p_procedure_name, SUBSTR(p_error_message, 1, 4000), SYSDATE);
    COMMIT;
END;
/

-- Scenario 1 input: source account, destination account, amount. Output: transfer or logged error.
CREATE OR REPLACE PROCEDURE SafeTransferFunds(
    p_from_account_id IN NUMBER,
    p_to_account_id IN NUMBER,
    p_amount IN NUMBER
) IS
    v_balance Accounts.Balance%TYPE;
BEGIN
    IF p_amount <= 0 OR p_from_account_id = p_to_account_id THEN
        RAISE_APPLICATION_ERROR(-20001, 'Use different accounts and a positive amount.');
    END IF;

    SELECT Balance INTO v_balance FROM Accounts
    WHERE AccountID = p_from_account_id FOR UPDATE;

    IF v_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20002, 'Insufficient funds in source account.');
    END IF;

    UPDATE Accounts SET Balance = Balance - p_amount, LastModified = SYSDATE
    WHERE AccountID = p_from_account_id;
    UPDATE Accounts SET Balance = Balance + p_amount, LastModified = SYSDATE
    WHERE AccountID = p_to_account_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Destination account does not exist.');
    END IF;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transfer completed successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        LogError('SafeTransferFunds', SQLERRM);
        DBMS_OUTPUT.PUT_LINE('Transfer failed: ' || SQLERRM);
END;
/

-- Scenario 2 input: employee ID and increase percentage. Output: revised salary or logged error.
CREATE OR REPLACE PROCEDURE UpdateSalary(
    p_employee_id IN NUMBER,
    p_percentage IN NUMBER
) IS
BEGIN
    IF p_percentage < 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Percentage cannot be negative.');
    END IF;
    UPDATE Employees
    SET Salary = Salary * (1 + p_percentage / 100)
    WHERE EmployeeID = p_employee_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE NO_DATA_FOUND;
    END IF;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Salary updated successfully.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        LogError('UpdateSalary', 'Employee ID ' || p_employee_id || ' does not exist.');
        DBMS_OUTPUT.PUT_LINE('Salary update failed: employee does not exist.');
    WHEN OTHERS THEN
        ROLLBACK;
        LogError('UpdateSalary', SQLERRM);
        DBMS_OUTPUT.PUT_LINE('Salary update failed: ' || SQLERRM);
END;
/

-- Scenario 3 input: customer attributes. Output: new customer or duplicate/error message.
CREATE OR REPLACE PROCEDURE AddNewCustomer(
    p_customer_id IN NUMBER,
    p_name IN VARCHAR2,
    p_dob IN DATE,
    p_balance IN NUMBER DEFAULT 0
) IS
BEGIN
    INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
    VALUES (p_customer_id, p_name, p_dob, p_balance, SYSDATE,
            CASE WHEN p_balance > 10000 THEN 'TRUE' ELSE 'FALSE' END);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Customer added successfully.');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        LogError('AddNewCustomer', 'Customer ID ' || p_customer_id || ' already exists.');
        DBMS_OUTPUT.PUT_LINE('Customer was not added: duplicate customer ID.');
    WHEN OTHERS THEN
        ROLLBACK;
        LogError('AddNewCustomer', SQLERRM);
        DBMS_OUTPUT.PUT_LINE('Customer insert failed: ' || SQLERRM);
END;
/

-- Example calls:
-- BEGIN SafeTransferFunds(1, 2, 100); UpdateSalary(2, 5); AddNewCustomer(4, 'Sam Lee', DATE '1988-02-01', 500); END;
-- /
