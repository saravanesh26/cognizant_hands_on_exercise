-- Scenario 1: automatically stamp every customer update.
CREATE OR REPLACE TRIGGER UpdateCustomerLastModified
BEFORE UPDATE ON Customers
FOR EACH ROW
BEGIN
    :NEW.LastModified := SYSDATE;
END;
/

-- Scenario 2: write an audit row after every successfully inserted transaction.
CREATE OR REPLACE TRIGGER LogTransaction
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (AuditID, TransactionID, AccountID, Action, Details, LoggedAt)
    VALUES (
        AuditLog_Seq.NEXTVAL,
        :NEW.TransactionID,
        :NEW.AccountID,
        'INSERT',
        :NEW.TransactionType || ' of ' || TO_CHAR(:NEW.Amount),
        SYSDATE
    );
END;
/

-- Scenario 3: enforce positive deposits and prevent withdrawals above the current account balance.
CREATE OR REPLACE TRIGGER CheckTransactionRules
BEFORE INSERT ON Transactions
FOR EACH ROW
DECLARE
    v_account_balance Accounts.Balance%TYPE;
BEGIN
    IF UPPER(:NEW.TransactionType) NOT IN ('DEPOSIT', 'WITHDRAWAL') THEN
        RAISE_APPLICATION_ERROR(-20030, 'Transaction type must be Deposit or Withdrawal.');
    END IF;
    IF :NEW.Amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20031, 'Transaction amount must be positive.');
    END IF;
    IF UPPER(:NEW.TransactionType) = 'WITHDRAWAL' THEN
        SELECT Balance INTO v_account_balance FROM Accounts
        WHERE AccountID = :NEW.AccountID;
        IF :NEW.Amount > v_account_balance THEN
            RAISE_APPLICATION_ERROR(-20032, 'Withdrawal exceeds the account balance.');
        END IF;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20033, 'Account does not exist.');
END;
/

-- Example input/output:
-- UPDATE Customers SET Name = 'John A. Doe' WHERE CustomerID = 1; -- LastModified changes.
-- INSERT INTO Transactions VALUES (3, 1, SYSDATE, 50, 'Deposit'); -- an AuditLog row is created.
-- INSERT INTO Transactions VALUES (4, 1, SYSDATE, -1, 'Deposit'); -- rejected with ORA-20031.
