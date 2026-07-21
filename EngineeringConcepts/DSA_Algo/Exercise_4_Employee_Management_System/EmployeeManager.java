package Exercise_4_Employee_Management_System;

public class EmployeeManager {
    private Employee[] employees;
    private int size;
    private int capacity;

    public EmployeeManager(int capacity) {
        this.capacity = capacity;
        this.employees = new Employee[capacity];
        this.size = 0;
    }

    // Add Employee: O(1) time complexity (if space available)
    public void addEmployee(Employee employee) {
        if (size >= capacity) {
            System.out.println("Error: Employee list is full. Cannot add " + employee.getName());
            return;
        }
        for (int i = 0; i < size; i++) {
            if (employees[i].getEmployeeId().equals(employee.getEmployeeId())) {
                System.out.println("Error: Employee ID " + employee.getEmployeeId() + " already exists.");
                return;
            }
        }
        employees[size] = employee;
        size++;
        System.out.println("Employee added: " + employee);
    }

    // Search Employee: O(N) time complexity (linear search)
    public Employee searchEmployee(String employeeId) {
        for (int i = 0; i < size; i++) {
            if (employees[i].getEmployeeId().equalsIgnoreCase(employeeId)) {
                return employees[i];
            }
        }
        return null; // Not found
    }

    // Traverse Employees: O(N) time complexity
    public void traverseEmployees() {
        if (size == 0) {
            System.out.println("No employee records found.");
            return;
        }
        System.out.println("\n--- Employee Records (" + size + "/" + capacity + ") ---");
        for (int i = 0; i < size; i++) {
            System.out.println(employees[i]);
        }
        System.out.println("-------------------------------------\n");
    }

    // Delete Employee: O(N) time complexity (due to searching and shifting elements)
    public void deleteEmployee(String employeeId) {
        int indexToDelete = -1;
        for (int i = 0; i < size; i++) {
            if (employees[i].getEmployeeId().equalsIgnoreCase(employeeId)) {
                indexToDelete = i;
                break;
            }
        }

        if (indexToDelete == -1) {
            System.out.println("Error: Employee with ID " + employeeId + " not found.");
            return;
        }

        Employee removed = employees[indexToDelete];
        // Shift remaining elements to the left to maintain contiguous storage
        for (int i = indexToDelete; i < size - 1; i++) {
            employees[i] = employees[i + 1];
        }
        employees[size - 1] = null; // Clear last reference for garbage collection
        size--;

        System.out.println("Employee deleted: " + removed);
    }
}
