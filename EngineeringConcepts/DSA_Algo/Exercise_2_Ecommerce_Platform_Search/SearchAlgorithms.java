package Exercise_2_Ecommerce_Platform_Search;

public class SearchAlgorithms {

    // Linear Search: O(N) time complexity
    public static Product linearSearch(Product[] products, String targetName) {
        if (products == null || targetName == null) {
            return null;
        }
        for (Product product : products) {
            if (product != null && product.getProductName().equalsIgnoreCase(targetName)) {
                return product;
            }
        }
        return null; // Not found
    }

    // Binary Search: O(log N) time complexity
    // Assumes the array is sorted by productName alphabetically
    public static Product binarySearch(Product[] products, String targetName) {
        if (products == null || targetName == null) {
            return null;
        }
        int low = 0;
        int high = products.length - 1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            Product midProduct = products[mid];
            
            if (midProduct == null) {
                // Handle possible null values if array is not fully populated
                return null;
            }

            int comparison = midProduct.getProductName().compareToIgnoreCase(targetName);

            if (comparison == 0) {
                return midProduct; // Found
            } else if (comparison < 0) {
                low = mid + 1; // Search right half
            } else {
                high = mid - 1; // Search left half
            }
        }
        return null; // Not found
    }
}
