package Exercise_2_Ecommerce_Platform_Search;

public class Product implements Comparable<Product> {
    private String productId;
    private String productName;
    private String category;

    public Product(String productId, String productName, String category) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    @Override
    public int compareTo(Product other) {
        // Sort alphabetically by productName
        return this.productName.compareToIgnoreCase(other.productName);
    }

    @Override
    public String toString() {
        return "Product [ID=" + productId + ", Name=" + productName + ", Category=" + category + "]";
    }
}
