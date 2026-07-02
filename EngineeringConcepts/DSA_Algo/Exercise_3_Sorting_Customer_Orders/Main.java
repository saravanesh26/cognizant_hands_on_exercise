package Exercise_3_Sorting_Customer_Orders;

import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        System.out.println("=== Sorting Customer Orders Test ===");

        // Setup test data
        Order[] ordersBubble = {
            new Order("O001", "Alice", 250.50),
            new Order("O002", "Bob", 120.00),
            new Order("O003", "Charlie", 450.75),
            new Order("O004", "David", 90.20),
            new Order("O005", "Emma", 310.00)
        };

        // Create a clone for Quick Sort
        Order[] ordersQuick = ordersBubble.clone();

        System.out.println("\nInitial Orders:");
        printOrders(ordersBubble);

        // 1. Test Bubble Sort
        System.out.println("\n--- Sorting using Bubble Sort ---");
        SortingAlgorithms.bubbleSort(ordersBubble);
        printOrders(ordersBubble);

        // 2. Test Quick Sort
        System.out.println("\n--- Sorting using Quick Sort ---");
        SortingAlgorithms.quickSort(ordersQuick, 0, ordersQuick.length - 1);
        printOrders(ordersQuick);
    }

    private static void printOrders(Order[] orders) {
        for (Order o : orders) {
            System.out.println("  " + o);
        }
    }
}
