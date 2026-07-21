# Exercise 3: Sorting Customer Orders

## 1. Understanding Sorting Algorithms

### 1. Bubble Sort
* **Concept**: Repeatedly steps through the list, compares adjacent elements, and swaps them if they are in the wrong order. This process is repeated until no swaps are needed.
* **Complexity**: \(O(N^2)\) worst/average, \(O(N)\) best case (when already sorted).
* **Space**: \(O(1)\) (in-place).

### 2. Insertion Sort
* **Concept**: Builds the final sorted array one item at a time by consuming one input element per repetition and placing it in its correct position relative to the sorted prefix.
* **Complexity**: \(O(N^2)\) worst/average, \(O(N)\) best case.
* **Space**: \(O(1)\) (in-place).

### 3. Quick Sort
* **Concept**: A divide-and-conquer algorithm. It selects a 'pivot' element and partitions the other elements into two sub-arrays according to whether they are less than or greater than the pivot. It then recursively sorts the sub-arrays.
* **Complexity**: \(O(N \log N)\) average, \(O(N^2)\) worst case (e.g., when pivot choices are poor).
* **Space**: \(O(\log N)\) auxiliary space (recursion stack).

### 4. Merge Sort
* **Concept**: A divide-and-conquer algorithm. It divides the array in half, recursively sorts both halves, and then merges the sorted halves.
* **Complexity**: \(O(N \log N)\) in all cases (best, average, worst).
* **Space**: \(O(N)\) auxiliary space (requires a temporary array to merge).

---

## 2. Complexity & Performance Comparison

| Sorting Algorithm | Best Case | Average Case | Worst Case | Space Complexity | Stable? |
|-------------------|-----------|--------------|------------|------------------|---------|
| **Bubble Sort**   | \(O(N)\)  | \(O(N^2)\)   | \(O(N^2)\) | \(O(1)\)         | Yes     |
| **Quick Sort**    | \(O(N \log N)\) | \(O(N \log N)\) | \(O(N^2)\) | \(O(\log N)\)    | No      |

### Why is Quick Sort preferred over Bubble Sort?
1. **Efficiency**: For larger arrays, \(O(N \log N)\) grows much more slowly than \(O(N^2)\). For \(N = 10,000\), Quick Sort does \(\approx 130,000\) operations, while Bubble Sort does \(\approx 100,000,000\) operations.
2. **Low Overhead**: Quick Sort has very small constant factors in its performance compared to other \(O(N \log N)\) algorithms like Merge Sort.
3. **In-place Sorting**: Quick Sort does not require auxiliary arrays (unlike Merge Sort, which requires \(O(N)\) extra space), making it highly memory-efficient.
4. **Cache Locality**: Quick Sort's design is very friendly to cpu caching because it scans contiguous blocks of memory sequentially.
