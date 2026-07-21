-- Scenario 1: customer operations package.
CREATE OR REPLACE PACKAGE CustomerManagement AS
    PROCEDURE AddCustomer(p_customer_id NUMBER, p_name VARCHAR2, p_dob DATE, p_balance NUMBER DEFAULT 0);
    PROCEDURE UpdateCustomerDetails(p_customer_id NUMBER, p_name VARCHAR2, p_dob DATE, p_balance NUMBER);
    FUNCTION GetCustomerBalance(p_customer_id NUMBER) RETURN NUMBER;
END CustomerManagement;
/

CREATE OR REPLACE PACKAGE BODY CustomerManagement AS
    PROCEDURE AddCustomer(p_customer_id NUMBER, p_name VARCHAR2, p_dob DATE, p_balance NUMBER DEFAULT 0) IS
    BEGIN
        INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
        VALUES (p_customer_id, p_name, p_dob, p_balance, SYSDATE,
                CASE WHEN p_balance > 10000 THEN 'TRUE' ELSE 'FALSE' END);
    END;

    PROCEDURE UpdateCustomerDetails(p_customer_id NUMBER, p_name VARCHAR2, p_dob DATE, p_balance NUMBER) IS
    BEGIN
        UPDATE Customers SET Name = p_name, DOB = p_dob, Balance = p_balance,
            IsVIP = CASE WHEN p_balance > 10000 THEN 'TRUE' ELSE 'FALSE' END
        WHERE CustomerID = p_customer_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE NO_DATA_FOUND; END IF;
    END;

    FUNCTION GetCustomerBalance(p_customer_id NUMBER) RETURN NUMBER IS v_balance NUMBER;
    BEGIN
        SELECT Balance INTO v_balance FROM Customers WHERE CustomerID = p_customer_id;
        RETURN v_balance;
    EXCEPTION WHEN NO_DATA_FOUND THEN RETURN NULL;
    END;
END CustomerManagement;
/

-- Scenario 2: employee operations package.
CREATE OR REPLACE PACKAGE EmployeeManagement AS
    PROCEDURE HireEmployee(p_employee_id NUMBER, p_name VARCHAR2, p_position VARCHAR2,
                           p_salary NUMBER, p_department VARCHAR2, p_hire_date DATE DEFAULT SYSDATE);
    PROCEDURE UpdateEmployeeDetails(p_employee_id NUMBER, p_position VARCHAR2, p_salary NUMBER, p_department VARCHAR2);
    FUNCTION CalculateAnnualSalary(p_employee_id NUMBER) RETURN NUMBER;
END EmployeeManagement;
/

CREATE OR REPLACE PACKAGE BODY EmployeeManagement AS
    PROCEDURE HireEmployee(p_employee_id NUMBER, p_name VARCHAR2, p_position VARCHAR2,
                           p_salary NUMBER, p_department VARCHAR2, p_hire_date DATE DEFAULT SYSDATE) IS
    BEGIN
        INSERT INTO Employees VALUES (p_employee_id, p_name, p_position, p_salary, p_department, p_hire_date);
    END;

    PROCEDURE UpdateEmployeeDetails(p_employee_id NUMBER, p_position VARCHAR2, p_salary NUMBER, p_department VARCHAR2) IS
    BEGIN
        UPDATE Employees SET Position = p_position, Salary = p_salary, Department = p_department
        WHERE EmployeeID = p_employee_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE NO_DATA_FOUND; END IF;
    END;

    FUNCTION CalculateAnnualSalary(p_employee_id NUMBER) RETURN NUMBER IS v_salary NUMBER;
    BEGIN
        SELECT Salary INTO v_salary FROM Employees WHERE EmployeeID = p_employee_id;
        RETURN v_salary * 12;
    EXCEPTION WHEN NO_DATA_FOUND THEN RETURN NULL;
    END;
END EmployeeManagement;
/

-- Scenario 3: account operations package.
CREATE OR REPLACE PACKAGE AccountOperations AS
    PROCEDURE OpenAccount(p_account_id NUMBER, p_customer_id NUMBER, p_account_type VARCHAR2, p_opening_balance NUMBER DEFAULT 0);
    PROCEDURE CloseAccount(p_account_id NUMBER);
    FUNCTION GetTotalBalance(p_customer_id NUMBER) RETURN NUMBER;
END AccountOperations;
/

CREATE OR REPLACE PACKAGE BODY AccountOperations AS
    PROCEDURE OpenAccount(p_account_id NUMBER, p_customer_id NUMBER, p_account_type VARCHAR2, p_opening_balance NUMBER DEFAULT 0) IS
    BEGIN
        IF p_opening_balance < 0 THEN RAISE_APPLICATION_ERROR(-20040, 'Opening balance cannot be negative.'); END IF;
        INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
        VALUES (p_account_id, p_customer_id, p_account_type, p_opening_balance, SYSDATE);
    END;

    PROCEDURE CloseAccount(p_account_id NUMBER) IS
    BEGIN
        DELETE FROM Transactions WHERE AccountID = p_account_id;
        DELETE FROM Accounts WHERE AccountID = p_account_id;
        IF SQL%ROWCOUNT = 0 THEN RAISE NO_DATA_FOUND; END IF;
    END;

    FUNCTION GetTotalBalance(p_customer_id NUMBER) RETURN NUMBER IS v_total NUMBER;
    BEGIN
        SELECT NVL(SUM(Balance), 0) INTO v_total FROM Accounts WHERE CustomerID = p_customer_id;
        RETURN v_total;
    END;
END AccountOperations;
/

-- Example calls (commit is controlled by the caller):
-- BEGIN CustomerManagement.AddCustomer(4, 'Sam Lee', DATE '1988-02-01', 500); EmployeeManagement.HireEmployee(3, 'Priya Shah', 'Analyst', 55000, 'IT'); AccountOperations.OpenAccount(4, 4, 'Savings', 500); COMMIT; END;
-- /
