Here are a few practical tasks based on your course material that you can use to review your knowledge and practice real-world SQL usage in the **my-ecommerce** database:

**First make sure to run the ecommerce-update1.sql script**

### **Task 1: Displaying Product Details**
**Scenario:** 
You are building an e-commerce application. One of the features is to display product details to customers.

**Task:**
Write an SQL query to retrieve the following information for all products (make sure to use these exact names in the output):
- Product name
- Price
- Category
- Availability (In Stock or Out of Stock)

Include logic to mark products with a stock quantity of 0 as "Out of Stock" and all others as "In Stock."


### **Task 1-2: Order Fulfillment Insights**
**Scenario:** 
To monitor order fulfillment, you need data on delayed orders.

**Task:**
Write an SQL query to list all orders where the delivery date exceeds the expected delivery date. Include:
- Order ID
- Customer name
- Expected delivery date
- Actual delivery date

---

### **Task 1-3: Adding a New Product**
**Scenario:** 
A new product is being added to the database.

**Task:**
Write an SQL script to:
1. Add a new product with the following details:
   - Name: "Wireless Headphones"
   - Description: "These phones are for your head!"
   - Price: $120
   - Stock: 50 units
   - Category: "Electronics"
2. Verify that the product has been added correctly using a SELECT query.


---

**Task 1-4: Add a New Category**
   Add a new category named "Home Appliances" to the `categories` table.
---

**Task 1-5: Add a New Product**
   Insert a product into the `products` table with the following details:
   - Name: "Smart Microwave"
   - Description: "A microwave with smart features."
   - Price: $199.99
   - Category: Assume category ID for "Home Appliances" is 4.
---

**Task 1-6: Add a New Customer**
   Add a customer with the following details:
   - First Name: "Alex"
   - Last Name: "Johnson"
   - Email: "alex.johnson@example.com"
---

**Task 1-7: Add a New Order**
   Insert an order for customer ID 3 with a total amount of $350.50 and status `pending`. Set the creation date to today's date and the expected delivery date to 3 days later.

   **Hint**:
   ```sql
   INSERT INTO orders (customer_id, total_amount, status, created_at, expected_delivery_date) 
   VALUES (3, 350.50, 'pending', CURRENT_DATE, DATE_ADD(CURRENT_DATE, INTERVAL 3 DAY));
   ```

---

### **Update Tasks**
5. **Task 1-8: Update Product Price**
   Increase the price of all products in the "Electronics" category by 10%.
---

**Task 1-9: Update Stock Availability**
   Set the `stock_available` of the product "Smart Microwave" to 30 units.
---

**Task 1-10: Mark Orders as Shipped**
   For all orders in `processing` status, update the status to `shipped`.
---

**Task 1-11: Correct Customer Email**
   Update the email of customer "Alex Johnson" to "alex.j@example.com".
---

**Task 1-12: Delete Outdated Products**
   Remove all products that were created more than 1 year ago.

   **Hint**:
   ```sql
   DELETE FROM products 
   WHERE created_at < DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR);
   ```

**Task 1-13: Cancel Pending Orders**
   Delete all orders that are in `pending` status and were created more than 7 days ago.

   **Hint**:
   ```sql
   DELETE FROM orders 
   WHERE status = 'pending' AND created_at < DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY);
   ```

---

