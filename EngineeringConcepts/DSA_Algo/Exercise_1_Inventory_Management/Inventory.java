package Exercise_1_Inventory_Management;

import java.util.HashMap;
import java.util.Map;

public class Inventory {
    private Map<String, Product> products;

    public Inventory() {
        this.products = new HashMap<>();
    }

    // Add Product - O(1) time complexity
    public void addProduct(Product product) {
        if (product == null) {
            System.out.println("Cannot add null product.");
            return;
        }
        if (products.containsKey(product.getProductId())) {
            System.out.println("Product with ID " + product.getProductId() + " already exists. Use update instead.");
            return;
        }
        products.put(product.getProductId(), product);
        System.out.println("Product added successfully: " + product);
    }

    // Update Product - O(1) time complexity
    public void updateProduct(String productId, int newQuantity, double newPrice) {
        Product product = products.get(productId);
        if (product != null) {
            product.setQuantity(newQuantity);
            product.setPrice(newPrice);
            System.out.println("Product updated successfully: " + product);
        } else {
            System.out.println("Product with ID " + productId + " not found in inventory.");
        }
    }

    // Delete Product - O(1) time complexity
    public void deleteProduct(String productId) {
        if (products.containsKey(productId)) {
            Product removed = products.remove(productId);
            System.out.println("Product deleted successfully: " + removed);
        } else {
            System.out.println("Product with ID " + productId + " not found in inventory.");
        }
    }

    // Get Product - O(1) time complexity
    public Product getProduct(String productId) {
        return products.get(productId);
    }

    // Display Inventory - O(N) time complexity
    public void displayInventory() {
        if (products.isEmpty()) {
            System.out.println("Inventory is empty.");
            return;
        }
        System.out.println("\n--- Current Inventory Status ---");
        for (Product product : products.values()) {
            System.out.println(product);
        }
        System.out.println("--------------------------------\n");
    }
}
