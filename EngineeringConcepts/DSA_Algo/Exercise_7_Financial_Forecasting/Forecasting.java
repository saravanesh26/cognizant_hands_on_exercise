package Exercise_7_Financial_Forecasting;

public class Forecasting {

    // 1. Recursive Future Value Calculation with Constant Growth Rate
    // Formula: FV = FV(t-1) * (1 + rate)
    // Time Complexity: O(N) where N = periods
    // Space Complexity: O(N) due to call stack depth
    public static double calculateFutureValueConstant(double presentValue, double growthRate, int periods) {
        // Base Case: If periods is 0, future value is the present value
        if (periods <= 0) {
            return presentValue;
        }
        // Recursive Step
        return calculateFutureValueConstant(presentValue, growthRate, periods - 1) * (1 + growthRate);
    }

    // 2. Recursive Future Value Calculation with Varying Annual Growth Rates
    // Time Complexity: O(N) where N = length of growthRates array
    // Space Complexity: O(N) due to call stack depth
    public static double calculateFutureValueVarying(double presentValue, double[] growthRates, int index) {
        // Base Case: If index is out of bounds or less than 0, return presentValue
        if (growthRates == null || index <= 0) {
            return presentValue;
        }
        // Recursive Step: Multiply the future value of the previous year by (1 + growthRate of this year)
        double previousValue = calculateFutureValueVarying(presentValue, growthRates, index - 1);
        double currentRate = growthRates[index - 1];
        return previousValue * (1 + currentRate);
    }

    // 3. Optimized Iterative Future Value Calculation (O(1) Space, O(N) Time)
    // Avoids recursion call stack overflow for large number of periods
    public static double calculateFutureValueIterative(double presentValue, double[] growthRates) {
        if (growthRates == null) {
            return presentValue;
        }
        double futureValue = presentValue;
        for (double rate : growthRates) {
            futureValue *= (1 + rate);
        }
        return futureValue;
    }
}
