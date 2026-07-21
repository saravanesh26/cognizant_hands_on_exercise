package Exercise_5_Task_Management_System;

public class SinglyLinkedList {
    
    // Internal Node class
    private static class Node {
        Task task;
        Node next;

        Node(Task task) {
            this.task = task;
            this.next = null;
        }
    }

    private Node head;

    public SinglyLinkedList() {
        this.head = null;
    }

    // Add Task: O(N) if traversing to the end, or O(1) if keeping a tail pointer.
    // Here we'll traverse to the end to illustrate standard Singly Linked List traversal.
    public void addTask(Task task) {
        if (task == null) {
            System.out.println("Cannot add a null task.");
            return;
        }
        Node newNode = new Node(task);
        if (head == null) {
            head = newNode;
            System.out.println("Task added (Head): " + task);
            return;
        }

        Node current = head;
        // Traverse to the last node
        while (current.next != null) {
            current = current.next;
        }
        current.next = newNode;
        System.out.println("Task added: " + task);
    }

    // Search Task: O(N) time complexity
    public Task searchTask(String taskId) {
        Node current = head;
        while (current != null) {
            if (current.task.getTaskId().equalsIgnoreCase(taskId)) {
                return current.task;
            }
            current = current.next;
        }
        return null; // Not found
    }

    // Traverse Tasks: O(N) time complexity
    public void traverseTasks() {
        if (head == null) {
            System.out.println("Task list is empty.");
            return;
        }
        System.out.println("\n--- Task list ---");
        Node current = head;
        while (current != null) {
            System.out.println(current.task);
            current = current.next;
        }
        System.out.println("-----------------\n");
    }

    // Delete Task: O(N) time complexity
    public void deleteTask(String taskId) {
        if (head == null) {
            System.out.println("Error: Task list is empty. Cannot delete ID " + taskId);
            return;
        }

        // Case 1: Task to delete is at the head
        if (head.task.getTaskId().equalsIgnoreCase(taskId)) {
            Task removed = head.task;
            head = head.next;
            System.out.println("Task deleted: " + removed);
            return;
        }

        // Case 2: Task is further down the list
        Node current = head;
        Node prev = null;
        while (current != null && !current.task.getTaskId().equalsIgnoreCase(taskId)) {
            prev = current;
            current = current.next;
        }

        // If task not found
        if (current == null) {
            System.out.println("Error: Task with ID " + taskId + " not found.");
            return;
        }

        // Unlink the node from the list
        Task removed = current.task;
        prev.next = current.next;
        System.out.println("Task deleted: " + removed);
    }
}
