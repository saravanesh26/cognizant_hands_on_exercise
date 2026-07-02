package Exercise_1_Inventory_Management;

public class Main {
    public static void main(String[] args) {
        System.out.println("=== Inventory Management System Test ===");
        Inventory inventory = new Inventory();

        // 1. Add Products
        Product p1 = new Product("P001", "Laptop", 10, 999.99);
        Product p2 = new Product("P002", "Smartphone", 25, 499.99);
        Product p3 = new Product("P003", "Headphones", 50, 79.99);

        inventory.addProduct(p1);
        inventory.addProduct(p2);
        inventory.addProduct(p3);

        inventory.displayInventory();

        // 2. Update Product
        System.out.println("Updating Laptop quantity to 15 and price to 949.99...");
        inventory.updateProduct("P001", 15, 949.99);
        
        inventory.displayInventory();

        // 3. Delete Product
        System.out.println("Deleting Headphones...");
        inventory.deleteProduct("P003");

        inventory.displayInventory();

        // Try to delete non-existing product
        System.out.println("Attempting to delete non-existing product P999...");
        inventory.deleteProduct("P999");
    }
}
