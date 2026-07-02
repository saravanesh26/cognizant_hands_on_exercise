package Exercise_4_Employee_Management_System;

public class Main {
    public static void main(String[] args) {
        System.out.println("=== Employee Management System Test ===");

        // Create manager with capacity of 5
        EmployeeManager manager = new EmployeeManager(5);

        // 1. Add Employees
        Employee e1 = new Employee("E001", "John Doe", "Software Engineer", 75000);
        Employee e2 = new Employee("E002", "Jane Smith", "Project Manager", 85000);
        Employee e3 = new Employee("E003", "Bob Johnson", "QA Analyst", 60000);
        Employee e4 = new Employee("E004", "Alice Brown", "UX Designer", 70000);
        Employee e5 = new Employee("E005", "Charlie Green", "DevOps Engineer", 80000);

        manager.addEmployee(e1);
        manager.addEmployee(e2);
        manager.addEmployee(e3);
        manager.addEmployee(e4);
        manager.addEmployee(e5);

        // Try adding another employee (should fail due to capacity)
        Employee e6 = new Employee("E006", "David White", "HR Manager", 65000);
        System.out.println("\nTesting capacity overflow:");
        manager.addEmployee(e6);

        // 2. Traverse Employees
        manager.traverseEmployees();

        // 3. Search Employee
        System.out.println("Searching for employee E003...");
        Employee found = manager.searchEmployee("E003");
        System.out.println("Found: " + found);

        System.out.println("Searching for non-existent employee E999...");
        Employee notFound = manager.searchEmployee("E999");
        System.out.println("Found: " + notFound);

        // 4. Delete Employee
        System.out.println("\nDeleting employee E003 (Bob Johnson)...");
        manager.deleteEmployee("E003");

        // Traverse again to see if array elements shifted and space was freed
        manager.traverseEmployees();

        // 5. Add new employee now that space is available
        System.out.println("Attempting to add E006 again after deletion...");
        manager.addEmployee(e6);

        manager.traverseEmployees();
    }
}
