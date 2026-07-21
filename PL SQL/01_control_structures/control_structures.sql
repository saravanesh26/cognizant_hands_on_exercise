-- Exercise 1, Scenario 1: customers older than 60 receive a 1 percentage-point loan-rate discount.
DECLARE
    v_age NUMBER;
BEGIN
    FOR customer_rec IN (SELECT CustomerID, DOB FROM Customers) LOOP
        v_age := TRUNC(MONTHS_BETWEEN(SYSDATE, customer_rec.DOB) / 12);
        IF v_age > 60 THEN
            UPDATE Loans
            SET InterestRate = GREATEST(InterestRate - 1, 0)
            WHERE CustomerID = customer_rec.CustomerID;
            DBMS_OUTPUT.PUT_LINE('Discount applied for customer ' || customer_rec.CustomerID);
        END IF;
    END LOOP;
    COMMIT;
END;
/

-- Exercise 1, Scenario 2: balances over 10,000 are flagged as VIP.
BEGIN
    FOR customer_rec IN (SELECT CustomerID, Balance FROM Customers) LOOP
        IF customer_rec.Balance > 10000 THEN
            UPDATE Customers SET IsVIP = 'TRUE' WHERE CustomerID = customer_rec.CustomerID;
            DBMS_OUTPUT.PUT_LINE('Customer ' || customer_rec.CustomerID || ' is now VIP');
        ELSE
            UPDATE Customers SET IsVIP = 'FALSE' WHERE CustomerID = customer_rec.CustomerID;
        END IF;
    END LOOP;
    COMMIT;
END;
/

-- Exercise 1, Scenario 3: print reminders for loans ending within the next 30 days.
BEGIN
    FOR loan_rec IN (
        SELECT c.Name, l.LoanID, l.EndDate
        FROM Loans l JOIN Customers c ON c.CustomerID = l.CustomerID
        WHERE l.EndDate BETWEEN TRUNC(SYSDATE) AND TRUNC(SYSDATE) + 30
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: ' || loan_rec.Name || ', loan ' || loan_rec.LoanID ||
                             ' is due on ' || TO_CHAR(loan_rec.EndDate, 'YYYY-MM-DD'));
    END LOOP;
END;
/
