# Exercise 6: Library Management System

## 1. Understanding Search Algorithms
Searching is the process of finding a target element within a collection of data.

### 1. Linear Search
* **Concept**: Starts at the beginning of the list and checks each element sequentially until a match is found or the end of the list is reached.
* **Requirements**: None. Works on both sorted and unsorted collections.
* **Complexity**: \(O(N)\) time complexity.

### 2. Binary Search
* **Concept**: A divide-and-conquer algorithm. It finds the middle element, compares it with the target, and halves the remaining search space recursively.
* **Requirements**: The data structure must be sorted.
* **Complexity**: \(O(\log N)\) time complexity.

---

## 2. Comparison Matrix

| Aspect | Linear Search | Binary Search |
|--------|---------------|---------------|
| **Time Complexity (Worst)** | \(O(N)\) | \(O(\log N)\) |
| **Time Complexity (Best)**  | \(O(1)\) | \(O(1)\) |
| **Space Complexity** | \(O(1)\) | \(O(1)\) |
| **Prerequisites** | None | Data must be sorted |
| **Implementation Complexity**| Very Simple | Moderate |
| **Best Suited For** | Small, frequently changing datasets | Large, static or rarely changing datasets |

---

## 3. When to Use Which?
* **Use Linear Search**:
  1. When the dataset is **small** (e.g., less than 50 elements) where the constant factors of sorting would outweigh search savings.
  2. When the data is **frequently changing** (adding and deleting books) and the cost of keeping the dataset sorted for binary search is too high.
* **Use Binary Search**:
  1. When the dataset is **large** (e.g., a library catalog with 100,000 books).
  2. When the dataset is **static** or changes infrequently, allowing us to sort it once and perform countless rapid queries.
