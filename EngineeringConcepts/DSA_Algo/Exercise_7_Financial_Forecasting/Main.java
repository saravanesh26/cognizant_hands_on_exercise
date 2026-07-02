package Exercise_7_Financial_Forecasting;

public class Main {
    public static void main(String[] args) {
        System.out.println("=== Financial Forecasting Test ===");

        double initialInvestment = 1000.00; // Present Value
        double constantRate = 0.05;         // 5% annual growth
        int periods = 10;                  // 10 years

        // 1. Calculate future value with constant growth rate
        System.out.println("\nCalculating future value with constant growth rate...");
        double fvConstant = Forecasting.calculateFutureValueConstant(initialInvestment, constantRate, periods);
        System.out.printf("Initial Investment: $%.2f%n", initialInvestment);
        System.out.printf("Growth Rate: %.1f%%%n", constantRate * 100);
        System.out.printf("Periods: %d years%n", periods);
        System.out.printf("Predicted Future Value: $%.2f%n", fvConstant);

        // 2. Calculate future value with varying growth rates (e.g. over 5 years)
        System.out.println("\nCalculating future value with varying growth rates...");
        double[] varyingRates = {0.04, 0.06, -0.02, 0.05, 0.07}; // 4%, 6%, -2%, 5%, 7%
        double fvVarying = Forecasting.calculateFutureValueVarying(initialInvestment, varyingRates, varyingRates.length);
        
        System.out.printf("Initial Investment: $%.2f%n", initialInvestment);
        System.out.print("Annual Growth Rates: ");
        for (double r : varyingRates) {
            System.out.printf("%.1f%% ", r * 100);
        }
        System.out.println();
        System.out.printf("Predicted Future Value (Recursive): $%.2f%n", fvVarying);

        // 3. Compare with Optimized Iterative Approach
        double fvIterative = Forecasting.calculateFutureValueIterative(initialInvestment, varyingRates);
        System.out.printf("Predicted Future Value (Iterative): $%.2f%n", fvIterative);
    }
}
