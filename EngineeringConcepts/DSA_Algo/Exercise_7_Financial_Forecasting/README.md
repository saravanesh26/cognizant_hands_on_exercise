# Exercise 7: Financial Forecasting

## 1. Understanding Recursive Algorithms
Recursion is a programming technique where a method calls itself to solve a smaller instance of the same problem. 

### Key Components of Recursion
1. **Base Case**: The condition under which the recursion terminates. Without a base case, recursion runs infinitely, resulting in a `StackOverflowError`.
2. **Recursive Step**: The part where the method calls itself with a reduced version of the original input, moving closer to the base case.
3. **Call Stack**: The stack memory structure used by JVM to store active stack frames (including local variables, arguments, and return addresses of active methods).

---

## 2. Implementation Overview
We implemented two recursive forecasting methods:
1. **`calculateFutureValueConstant`**: Forecasts value over \(T\) periods assuming a constant annual growth rate.
2. **`calculateFutureValueVarying`**: Forecasts value using an array of varying annual growth rates.
We also provided an **iterative** method (`calculateFutureValueIterative`) for comparison.

---

## 3. Complexity Analysis

| Approach | Time Complexity | Space Complexity | Risk / Trade-offs |
|-----------|-----------------|------------------|-------------------|
| **Recursive** | \(O(N)\) | \(O(N)\) | High risk of `StackOverflowError` for large \(N\) (e.g., \(N > 10,000\)). |
| **Iterative** | \(O(N)\) | \(O(1)\) | Highly memory-efficient, no call stack overhead. |

---

## 4. How to Optimize Recursive Solutions

### 1. Iteration
Instead of using the call stack, we can use a simple `for` or `while` loop. This achieves \(O(1)\) space complexity because it does not allocate any new stack frames.

### 2. Memoization (Caching)
If the recursive function had overlapping subproblems (e.g., calculating Fibonacci numbers or complex branching forecasts), we would cache the results of previous calculations in a Map or array to avoid re-computing them, reducing the time complexity from exponential \(O(2^N)\) to linear \(O(N)\).

### 3. Tail Recursion (where supported)
Tail call optimization (TCO) allows some compilers to execute tail-recursive methods in \(O(1)\) space. *Note: Java standard JVMs do not support Tail Call Optimization, making iterative loops the preferred choice in Java.*
