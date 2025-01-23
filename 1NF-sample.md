### Step 1: Create a Database
1. Open MySQL Workbench or your preferred MySQL client.
2. Create a database to work in:
   ```sql
   create database ecommerce_demo;
   use ecommerce_demo;
   ```

---

### Step 2: Create a Non-1NF Table
1. Create a table with columns that allow multiple values in one cell. Here's the SQL:
   ```sql
   create table orders_non_1nf (
       order_id int,
       customer_name varchar(255),
       products varchar(255),
       quantities varchar(255)
   );
   ```

   - **`order_id`**: Unique ID for each order.
   - **`customer_name`**: Name of the customer who placed the order.
   - **`products`**: A comma-separated list of products purchased.
   - **`quantities`**: A comma-separated list of quantities corresponding to each product.

---

### Step 3: Insert Data into the Non-1NF Table
1. Provide students with the following `INSERT` statements to populate the table:
   ```sql
   insert into orders_non_1nf values
   (101, 'Alice', 'Laptop, Mouse', '1, 2'),
   (102, 'Bob', 'Keyboard, Monitor', '1, 1'),
   (103, 'Alice', 'Desk Chair, Office Lamp', '1, 1'),
   (104, 'Charlie', 'Monitor, Speakers, Keyboard', '1, 2, 1');
   ```

   This data includes:
   - **Order 101**: Alice purchased a Laptop (1) and a Mouse (2).
   - **Order 102**: Bob purchased a Keyboard (1) and a Monitor (1).
   - **Order 103**: Alice purchased a Desk Chair (1) and an Office Lamp (1).
   - **Order 104**: Charlie purchased a Monitor (1), Speakers (2), and a Keyboard (1).

---

### Step 4: Query the Data
1. Query the data to see the non-1NF table:
   ```sql
   select * from orders_non_1nf;
   ```

2. Discuss how the `products` and `quantities` columns violate 1NF by storing multiple values in a single cell.

---

### Step 5: Analyze the Problems with Violating 1NF
Try the following tasks, highlighting why 1NF violations are problematic:
1. Retrieve all orders where "Mouse" was purchased:
   ```sql
   select * from orders_non_1nf where products like '%Mouse%';
   ```
   Discuss the inefficiency of this approach.

2. Calculate the total quantity of "Monitor" sold:
   - Highlight that this requires parsing the `quantities` column, which SQL is not designed to handle natively.

3. Update "Mouse" to "Wireless Mouse" in the `products` column for all orders:
   ```sql
   update orders_non_1nf
   set products = replace(products, 'Mouse', 'Wireless Mouse');
   ```
   This is error-prone and can lead to inconsistencies.


### Additional Notes
- While this table works for small datasets, scaling this design would lead to significant challenges in querying, maintaining, and updating data.
- Think about the benefits of normalization and how converting this table into a 1NF-compliant structure can resolve these issues.

