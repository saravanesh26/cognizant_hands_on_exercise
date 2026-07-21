package Exercise_6_Library_Management_System;

import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        System.out.println("=== Library Management System Test ===");

        // Setup unsorted books
        Book[] books = {
            new Book("B004", "The Hobbit", "J.R.R. Tolkien"),
            new Book("B001", "To Kill a Mockingbird", "Harper Lee"),
            new Book("B005", "1984", "George Orwell"),
            new Book("B003", "The Great Gatsby", "F. Scott Fitzgerald"),
            new Book("B002", "Moby Dick", "Herman Melville")
        };

        // 1. Linear Search (unsorted array)
        System.out.println("\n--- Testing Linear Search (Unsorted Array) ---");
        String target = "The Great Gatsby";
        System.out.println("Searching for \"" + target + "\"...");
        Book foundLinear = Library.linearSearchByTitle(books, target);
        System.out.println("Found: " + foundLinear);

        // 2. Sort the array for Binary Search
        System.out.println("\nSorting books by title for Binary Search...");
        Arrays.sort(books);
        for (Book b : books) {
            System.out.println("  " + b.getTitle() + " (ID: " + b.getBookId() + ")");
        }

        // 3. Binary Search (sorted array)
        System.out.println("\n--- Testing Binary Search (Sorted Array) ---");
        System.out.println("Searching for \"" + target + "\"...");
        Book foundBinary = Library.binarySearchByTitle(books, target);
        System.out.println("Found: " + foundBinary);

        String missingTarget = "War and Peace";
        System.out.println("\nSearching for non-existent book \"" + missingTarget + "\"...");
        Book missingLinear = Library.linearSearchByTitle(books, missingTarget);
        Book missingBinary = Library.binarySearchByTitle(books, missingTarget);
        System.out.println("Linear Search Result: " + missingLinear);
        System.out.println("Binary Search Result: " + missingBinary);
    }
}
