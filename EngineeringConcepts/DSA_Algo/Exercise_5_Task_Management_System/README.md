# Exercise 5: Task Management System

## 1. Understanding Linked Lists
A linked list is a linear data structure where elements are not stored in contiguous memory locations. Instead, each element (called a **Node**) contains the data and a reference (or link) to the next node in the sequence.

### Types of Linked Lists
1. **Singly Linked List**:
   * Each node contains data and a single pointer/reference to the **next** node.
   * Traversal is uni-directional (from head to tail).
   * Memory overhead is smaller (only one pointer per node).
2. **Doubly Linked List**:
   * Each node contains data, a pointer to the **next** node, and a pointer to the **previous** node.
   * Traversal is bi-directional.
   * Easier to delete a node given its reference because the predecessor is directly accessible in \(O(1)\) time.
   * Requires more memory (two pointers per node).

---

## 2. Implementation Overview
We implemented a custom **Singly Linked List** (`SinglyLinkedList`) containing nodes of type `Node` that wrap the `Task` object.
* **Attributes**: `taskId`, `taskName`, `status`.
* **Head Node**: Holds the pointer to the first task.

---

## 3. Time Complexity Analysis

| Operation | Time Complexity | Details / Rationale |
|-----------|-----------------|---------------------|
| **Add**   | \(O(1)\) or \(O(N)\) | \(O(1)\) if we insert at the head or keep a tail pointer. \(O(N)\) if we must traverse to the end. |
| **Search**| \(O(N)\) | Must traverse the list node-by-node to compare IDs. |
| **Traverse**| \(O(N)\) | Must visit every node starting from head to print/process them. |
| **Delete**| \(O(N)\) | Takes \(O(N)\) to find the node. Once located, unlinking is \(O(1)\). |

---

## 4. Advantages of Linked Lists over Arrays for Dynamic Data
1. **Dynamic Size**: Unlike arrays, linked lists can grow or shrink at runtime without costly reallocation and copying.
2. **Efficient Insertions/Deletions**: Inserting or deleting a node at a known position takes \(O(1)\) time (just re-linking pointers), whereas arrays require shifting elements which takes \(O(N)\) time.
3. **No Memory Wastage**: Memory is allocated as nodes are added, avoiding the unused memory overhead of pre-allocated arrays.
