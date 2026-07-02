package Exercise_2_Ecommerce_Platform_Search;

import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        System.out.println("=== E-commerce Platform Search Test ===");

        // 1. Setup Products
        Product[] products = {
            new Product("P104", "Wireless Mouse", "Electronics"),
            new Product("P101", "Gaming Laptop", "Electronics"),
            new Product("P105", "Mechanical Keyboard", "Electronics"),
            new Product("P103", "Bluetooth Headset", "Electronics"),
            new Product("P102", "Smartphone Pro", "Electronics")
        };

        // 2. Perform Linear Search (unsorted array is fine)
        System.out.println("\n--- Testing Linear Search ---");
        String targetName = "Mechanical Keyboard";
        System.out.println("Searching for '" + targetName + "'...");
        Product resultLinear = SearchAlgorithms.linearSearch(products, targetName);
        System.out.println("Linear Search Result: " + resultLinear);

        String missingTarget = "Smart Watch";
        System.out.println("Searching for non-existent '" + missingTarget + "'...");
        Product resultLinearMissing = SearchAlgorithms.linearSearch(products, missingTarget);
        System.out.println("Linear Search Result: " + resultLinearMissing);

        // 3. Sort the array for Binary Search
        System.out.println("\nSorting product array for Binary Search...");
        System.out.println("Before Sorting:");
        for (Product p : products) {
            System.out.println("  " + p.getProductName());
        }

        Arrays.sort(products);

        System.out.println("After Sorting:");
        for (Product p : products) {
            System.out.println("  " + p.getProductName());
        }

        // 4. Perform Binary Search
        System.out.println("\n--- Testing Binary Search ---");
        System.out.println("Searching for '" + targetName + "'...");
        Product resultBinary = SearchAlgorithms.binarySearch(products, targetName);
        System.out.println("Binary Search Result: " + resultBinary);

        System.out.println("Searching for non-existent '" + missingTarget + "'...");
        Product resultBinaryMissing = SearchAlgorithms.binarySearch(products, missingTarget);
        System.out.println("Binary Search Result: " + resultBinaryMissing);
    }
}
