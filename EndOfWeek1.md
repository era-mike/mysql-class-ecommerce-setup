Here are a few practical tasks based on your course material that you can use to review your knowledge and practice real-world SQL usage in the **my-ecommerce** database:

**First make sure to run the ecommerce-update1.sql script**

### **Task 1: Displaying Product Details**
**Scenario:** 
You are building an e-commerce application. One of the features is to display product details to customers.

**Task:**
Write an SQL query to retrieve the following information for all products:
- Product name
- Price
- Category
- Availability (In Stock or Out of Stock)

Include logic to mark products with a stock quantity of 0 as "Out of Stock" and all others as "In Stock."

---

### **Task 2: Customer Orders Summary**
**Scenario:** 
You need to generate a summary of customer orders for an admin dashboard.

**Task:**
Write an SQL query that retrieves:
- Customer's full name
- Total number of orders placed by each customer
- Total amount spent by each customer (sum of order values)

Ensure the query is grouped by customer and ordered by the total amount spent in descending order.

---

### **Task 3: Featured Product View**
**Scenario:** 
For the homepage, you want to display a featured product.

**Task:**
Write an SQL query to fetch the most expensive product in each category, showing:
- Product name
- Price
- Category

---

### **Task 4: Order Fulfillment Insights**
**Scenario:** 
To monitor order fulfillment, you need data on delayed orders.

**Task:**
Write an SQL query to list all orders where the delivery date exceeds the expected delivery date. Include:
- Order ID
- Product name
- Customer name
- Expected delivery date
- Actual delivery date

---

### **Task 5: Adding a New Product**
**Scenario:** 
A new product is being added to the database.

**Task:**
Write an SQL script to:
1. Add a new product with the following details:
   - Name: "Wireless Headphones"
   - Price: $120
   - Stock: 50 units
   - Category: "Electronics"
2. Verify that the product has been added correctly using a SELECT query.

