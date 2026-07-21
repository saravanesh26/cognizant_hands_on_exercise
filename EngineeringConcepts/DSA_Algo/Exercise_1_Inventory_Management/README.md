# Exercise 1: Inventory Management System

## 1. Understanding the Problem
### Why are Data Structures & Algorithms (DSA) essential in handling large inventories?
* **Scalability**: For an e-commerce platform or a global warehouse, inventories can scale to millions of products. Using naive search/update operations would cause extreme latency and server load.
* **Performance**: Proper data structures allow for efficient lookup, addition, updates, and removal. If it takes \(O(N)\) time to search for an item in a list of 10 million products, it could take seconds. In contrast, an \(O(1)\) lookup takes a fraction of a millisecond.
* **Memory Management**: Well-chosen data structures minimize memory overhead and keep data organized for cache-friendly access.

### Suitable Data Structures
1. **ArrayList / Array**: Suitable for sequential access, but searching, updating, or deleting a product by its ID takes \(O(N)\) time because it requires traversing the list.
2. **HashMap**: Ideal for this problem because we can key products by their unique `productId`. It provides \(O(1)\) average time complexity for addition, search, update, and deletion.
3. **TreeMap**: Useful if we need products sorted by their ID. It provides \(O(\log N)\) operations.

---

## 2. Implementation Overview
We selected a `HashMap<String, Product>` in Java to store the products.
* `productId` is the unique key.
* The `Product` object is the value.

### Product Class
Includes: `productId`, `productName`, `quantity`, `price`.

### Operations
* **Add**: Inserts a new product into the map.
* **Update**: Fetches the product by key and updates its attributes.
* **Delete**: Removes the product from the map by its key.

---

## 3. Time Complexity Analysis

| Operation | Chosen Structure (`HashMap`) | Alternative Structure (`ArrayList`) |
|-----------|-----------------------------|------------------------------------|
| **Add**   | \(O(1)\) (Average)          | \(O(1)\) (Amortized at end of list)|
| **Update**| \(O(1)\) (Average)          | \(O(N)\) (Must search sequentially)|
| **Delete**| \(O(1)\) (Average)          | \(O(N)\) (Must search and shift)  |

### How to optimize:
* **Initial Capacity**: When using `HashMap`, setting an appropriate initial capacity prevents frequent resizing (re-hashing) as the inventory grows.
* **Collision Resolution**: Ensuring a good hash function to minimize bucket collisions, keeping operations close to true \(O(1)\).
* **Caching**: Implementing a cache (e.g., LRU cache) for highly searched products.
