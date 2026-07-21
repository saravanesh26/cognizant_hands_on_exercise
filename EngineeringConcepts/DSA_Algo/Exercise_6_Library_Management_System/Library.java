package Exercise_6_Library_Management_System;

public class Library {

    // Linear Search: O(N) time complexity
    public static Book linearSearchByTitle(Book[] books, String targetTitle) {
        if (books == null || targetTitle == null) {
            return null;
        }
        for (Book book : books) {
            if (book != null && book.getTitle().equalsIgnoreCase(targetTitle)) {
                return book;
            }
        }
        return null; // Not found
    }

    // Binary Search: O(log N) time complexity
    // Assumes array of books is sorted alphabetically by title
    public static Book binarySearchByTitle(Book[] books, String targetTitle) {
        if (books == null || targetTitle == null) {
            return null;
        }
        int low = 0;
        int high = books.length - 1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            Book midBook = books[mid];

            if (midBook == null) {
                return null;
            }

            int comparison = midBook.getTitle().compareToIgnoreCase(targetTitle);

            if (comparison == 0) {
                return midBook; // Found
            } else if (comparison < 0) {
                low = mid + 1; // Search right half
            } else {
                high = mid - 1; // Search left half
            }
        }
        return null; // Not found
    }
}
