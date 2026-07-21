package Exercise_5_Task_Management_System;

public class Main {
    public static void main(String[] args) {
        System.out.println("=== Task Management System Test ===");

        SinglyLinkedList list = new SinglyLinkedList();

        // 1. Add Tasks
        Task t1 = new Task("T001", "Design Database Schema", "Pending");
        Task t2 = new Task("T002", "Implement Authentication", "In Progress");
        Task t3 = new Task("T003", "Write Unit Tests", "Pending");
        Task t4 = new Task("T004", "Setup CI/CD Pipeline", "Completed");

        list.addTask(t1);
        list.addTask(t2);
        list.addTask(t3);
        list.addTask(t4);

        // 2. Traverse Tasks
        list.traverseTasks();

        // 3. Search Task
        System.out.println("Searching for task T002...");
        Task found = list.searchTask("T002");
        System.out.println("Found: " + found);

        System.out.println("Searching for non-existent task T999...");
        Task notFound = list.searchTask("T999");
        System.out.println("Found: " + notFound);

        // 4. Delete Task (from middle)
        System.out.println("\nDeleting task T002 (Implement Authentication)...");
        list.deleteTask("T002");
        list.traverseTasks();

        // 5. Delete Task (from head)
        System.out.println("Deleting task T001 (Design Database Schema - head node)...");
        list.deleteTask("T001");
        list.traverseTasks();

        // 6. Delete Task (not found)
        System.out.println("Attempting to delete non-existent task T999...");
        list.deleteTask("T999");
    }
}
