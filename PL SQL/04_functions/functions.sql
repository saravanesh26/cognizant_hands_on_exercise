-- Scenario 1 input: a DOB. Output: completed years as of today.
CREATE OR REPLACE FUNCTION CalculateAge(p_dob IN DATE)
RETURN NUMBER IS
BEGIN
    IF p_dob IS NULL OR p_dob > TRUNC(SYSDATE) THEN
        RETURN NULL;
    END IF;
    RETURN TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), p_dob) / 12);
END;
/

-- Scenario 2 inputs: principal amount, annual percentage rate, and term in years. Output: monthly EMI.
CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment(
    p_loan_amount IN NUMBER,
    p_annual_interest_rate IN NUMBER,
    p_duration_years IN NUMBER
) RETURN NUMBER IS
    v_monthly_rate NUMBER;
    v_number_of_months NUMBER;
BEGIN
    IF p_loan_amount < 0 OR p_annual_interest_rate < 0 OR p_duration_years <= 0 THEN
        RAISE_APPLICATION_ERROR(-20020, 'Loan amount/rate must be non-negative and duration must be positive.');
    END IF;
    v_number_of_months := p_duration_years * 12;
    v_monthly_rate := p_annual_interest_rate / 1200;
    IF v_monthly_rate = 0 THEN
        RETURN ROUND(p_loan_amount / v_number_of_months, 2);
    END IF;
    RETURN ROUND(p_loan_amount * v_monthly_rate * POWER(1 + v_monthly_rate, v_number_of_months) /
                 (POWER(1 + v_monthly_rate, v_number_of_months) - 1), 2);
END;
/

-- Scenario 3 inputs: account ID and required amount. Output: TRUE when balance is sufficient, otherwise FALSE.
CREATE OR REPLACE FUNCTION HasSufficientBalance(
    p_account_id IN NUMBER,
    p_amount IN NUMBER
) RETURN BOOLEAN IS
    v_balance Accounts.Balance%TYPE;
BEGIN
    IF p_amount < 0 THEN
        RETURN FALSE;
    END IF;
    SELECT Balance INTO v_balance FROM Accounts WHERE AccountID = p_account_id;
    RETURN v_balance >= p_amount;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END;
/

DECLARE
    v_age NUMBER;
    v_installment NUMBER;
BEGIN
    v_age := CalculateAge(DATE '1985-05-15');
    v_installment := CalculateMonthlyInstallment(5000, 5, 5);
    DBMS_OUTPUT.PUT_LINE('Age: ' || v_age);
    DBMS_OUTPUT.PUT_LINE('Monthly installment: ' || v_installment);
    IF HasSufficientBalance(1, 500) THEN
        DBMS_OUTPUT.PUT_LINE('Account 1 has sufficient balance.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Account 1 does not have sufficient balance.');
    END IF;
END;
/
