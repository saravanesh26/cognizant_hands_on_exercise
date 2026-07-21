-- Run once in an empty Oracle schema. Enable output with: SET SERVEROUTPUT ON

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    DOB DATE,
    Balance NUMBER DEFAULT 0 NOT NULL,
    LastModified DATE,
    IsVIP VARCHAR2(5) DEFAULT 'FALSE' CHECK (IsVIP IN ('TRUE', 'FALSE'))
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER NOT NULL,
    AccountType VARCHAR2(20) NOT NULL,
    Balance NUMBER DEFAULT 0 NOT NULL,
    LastModified DATE,
    CONSTRAINT fk_accounts_customer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    AccountID NUMBER NOT NULL,
    TransactionDate DATE DEFAULT SYSDATE NOT NULL,
    Amount NUMBER NOT NULL,
    TransactionType VARCHAR2(10) NOT NULL,
    CONSTRAINT fk_transactions_account FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER NOT NULL,
    LoanAmount NUMBER NOT NULL,
    InterestRate NUMBER NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    CONSTRAINT fk_loans_customer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Position VARCHAR2(50),
    Salary NUMBER NOT NULL,
    Department VARCHAR2(50),
    HireDate DATE
);

CREATE TABLE AuditLog (
    AuditID NUMBER PRIMARY KEY,
    TransactionID NUMBER NOT NULL,
    AccountID NUMBER NOT NULL,
    Action VARCHAR2(30) NOT NULL,
    Details VARCHAR2(4000),
    LoggedAt DATE DEFAULT SYSDATE NOT NULL
);

CREATE TABLE ErrorLog (
    ErrorID NUMBER PRIMARY KEY,
    ProcedureName VARCHAR2(100) NOT NULL,
    ErrorMessage VARCHAR2(4000) NOT NULL,
    LoggedAt DATE DEFAULT SYSDATE NOT NULL
);

CREATE SEQUENCE AuditLog_Seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE ErrorLog_Seq START WITH 1 INCREMENT BY 1;

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified) VALUES
    (1, 'John Doe', DATE '1955-05-15', 1000, SYSDATE);
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified) VALUES
    (2, 'Jane Smith', DATE '1990-07-20', 1500, SYSDATE);
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified) VALUES
    (3, 'Robert Brown', DATE '1948-01-10', 15000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified) VALUES
    (1, 1, 'Savings', 1000, SYSDATE);
INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified) VALUES
    (2, 2, 'Checking', 1500, SYSDATE);
INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified) VALUES
    (3, 3, 'Savings', 15000, SYSDATE);

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType) VALUES
    (1, 1, SYSDATE, 200, 'Deposit');
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType) VALUES
    (2, 2, SYSDATE, 300, 'Withdrawal');

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate) VALUES
    (1, 1, 5000, 5, SYSDATE, ADD_MONTHS(SYSDATE, 1));
INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate) VALUES
    (2, 3, 20000, 6, SYSDATE, ADD_MONTHS(SYSDATE, 60));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate) VALUES
    (1, 'Alice Johnson', 'Manager', 70000, 'HR', DATE '2015-06-15');
INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate) VALUES
    (2, 'Bob Brown', 'Developer', 60000, 'IT', DATE '2017-03-20');

COMMIT;
