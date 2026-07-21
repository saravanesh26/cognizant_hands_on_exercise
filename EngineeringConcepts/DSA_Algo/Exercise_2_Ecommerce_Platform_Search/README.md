# Exercise 2: E-commerce Platform Search Function

## 1. Understanding Asymptotic Notation
### Big O Notation
* **Definition**: Big O notation is a mathematical notation used to describe the limiting behavior of a function when the argument tends towards a particular value or infinity. In computer science, it characterizes the execution time or space complexity of an algorithm in the worst-case scenario.
* **Purpose**: It helps analyze how runtime or memory consumption scales relative to input size \(N\). It allows developers to compare the efficiency of different algorithms independently of hardware configurations.

### Best, Average, and Worst-Case Scenarios
* **Best-Case**: The minimum time required for program execution. For a search, it is finding the element at the very first index (Time complexity: \(O(1)\)).
* **Average-Case**: The expected time if elements are randomly distributed. It represents typical usage (Linear: \(O(N)\), Binary: \(O(\log N)\)).
* **Worst-Case**: The maximum time required, e.g., when the element is at the end or not in the array (Linear: \(O(N)\), Binary: \(O(\log N)\)).

---

## 2. Implementation Overview
We created:
* `Product`: Model containing `productId`, `productName`, `category`. Implements `Comparable` for sorting by name.
* `SearchAlgorithms`: Contains `linearSearch` and `binarySearch`.

---

## 3. Search Algorithm Comparison

### Time Complexity

| Algorithm | Best Case | Average Case | Worst Case | Space Complexity | Array Condition |
|-----------|-----------|--------------|------------|------------------|-----------------|
| **Linear Search** | \(O(1)\) | \(O(N)\) | \(O(N)\) | \(O(1)\) | Unsorted or Sorted |
| **Binary Search** | \(O(1)\) | \(O(\log N)\) | \(O(\log N)\) | \(O(1)\) | Must be Sorted |

### Discussion: Which is more suitable?
* **Binary Search** is far more suitable for e-commerce platforms where search queries are performed on thousands or millions of products.
* **Why**: An e-commerce platform's catalog doesn't change every microsecond compared to search volume, so sorting the catalog once or maintaining a sorted list is trivial. Searching sorted data using Binary Search takes \(O(\log N)\) steps. For \(1,000,000\) products, Binary Search takes at most \(\approx 20\) comparisons, whereas Linear Search takes up to \(1,000,000\) comparisons.
