# Exercise 4: Employee Management System

## 1. Understanding Array Representation
### Memory Representation
* Arrays are represented as a **contiguous block of memory**.
* When an array is initialized, the system allocates a block of memory equal to `size * element_size` bytes.
* Because elements are stored sequentially without gaps, the address of any element at index `i` can be computed using the base address:
  \[
  Address(i) = BaseAddress + i \times ElementSize
  \]
* This address computation takes \(O(1)\) time.

### Advantages of Arrays
* **Fast Random Access**: Direct lookup by index is incredibly fast (\(O(1)\)).
* **Cache Locality**: Contiguous storage utilizes CPU prefetching and caches optimally, resulting in faster sequential access.
* **Low Memory Overhead**: Arrays store only the data itself (or references), without overhead for node linkages or keys.

---

## 2. Implementation Overview
We created:
* `Employee`: Model representing employee details.
* `EmployeeManager`: Implements database operations using a fixed-size `Employee[]` array.
* Shifting logic is implemented in the `deleteEmployee` method to fill the gap left by a deleted record and maintain a contiguous block.

---

## 3. Complexity Analysis

| Operation | Time Complexity | Details / Rationale |
|-----------|-----------------|---------------------|
| **Add**   | \(O(1)\) (Average) | Writing to the next available index `size`. Takes \(O(N)\) if we first search to check for duplicates. |
| **Search**| \(O(N)\) | Must search sequentially since the array is not sorted. |
| **Traverse**| \(O(N)\) | Must visit each element from index `0` to `size-1`. |
| **Delete**| \(O(N)\) | Requires searching for the element and then shifting subsequent elements to the left. |

---

## 4. Limitations of Arrays & When to Use

### Limitations
1. **Fixed Size**: Once initialized, the capacity cannot change. Resizing requires allocating a new array and copying all elements, which is \(O(N)\).
2. **Costly Insertions & Deletions**: Inserting or deleting from the middle of the array requires shifting elements, taking \(O(N)\) time.

### When to Use
* When the size of the dataset is **fixed** or has a known upper bound.
* When **frequent lookup by index** is required.
* When sequential traversal performance is critical and cache locality matters.
