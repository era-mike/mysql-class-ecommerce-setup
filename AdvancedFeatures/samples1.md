Below are several SQL examples that use your schema to illustrate each of the requested topics. Note that some operators (like INTERSECT and EXCEPT) are part of standard SQL but are not supported natively by MySQL. In those cases, I’ve provided both the standard syntax and a note (or alternative query) for MySQL.

---

### 1. Upsert  
*Using MySQL’s `ON DUPLICATE KEY UPDATE` to insert or update a product record:*  
```sql
INSERT INTO products (product_id, name, description, price, category_id, stock_available)
VALUES (1, 'Wireless Mouse', 'A sleek wireless mouse', 29.99, 2, 150)
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    description = VALUES(description),
    price = VALUES(price),
    stock_available = VALUES(stock_available);
```
*This query inserts a new product. If a product with the same `product_id` exists, it updates the record with the new values.*

---

### 2. Common Table Expression (CTE)  
*Calculating customer spending and then selecting top spenders using a CTE:*  
```sql
WITH customer_spending AS (
    SELECT customer_id, SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT c.first_name, c.last_name, cs.total_spent
FROM customer_spending cs
JOIN customers c ON cs.customer_id = c.customer_id
WHERE cs.total_spent > 1000;
```
*This CTE computes the total spending per customer, and then the outer query retrieves customer names with spending over 1000.*

---

### 3. SELECT WHERE NOT IN  
*Finding products that have never been ordered:*  
```sql
SELECT *
FROM products
WHERE product_id NOT IN (
    SELECT product_id FROM order_items
);
```
*This query returns all products whose IDs are not found in the `order_items` table.*

---

### 4. UPDATE with JOIN  
*Updating product stock by joining with the `categories` table (e.g., add extra stock for products in a specific category):*  
```sql
UPDATE products p
JOIN categories c ON p.category_id = c.category_id
SET p.stock_available = p.stock_available + 20
WHERE c.name = 'Electronics';
```
*Alternatively, updating order status based on customer email could be written as:*  
```sql
UPDATE orders o
JOIN customers c ON o.customer_id = c.customer_id
SET o.status = 'Priority'
WHERE c.email LIKE '%@vip.com';
```
*These examples update records in one table based on matching rows in a related table.*

---

### 5. UNION ALL  
*Combining rows from `orders` and `order_items` with a source indicator (note that UNION ALL retains duplicate rows):*  
```sql
SELECT order_id AS id, total_amount AS amount, 'Order' AS source
FROM orders
UNION ALL
SELECT order_item_id AS id, price AS amount, 'OrderItem' AS source
FROM order_items;
```
*This returns a combined result set with rows labeled by their origin.*

---

### 6. INTERSECT  
*Standard SQL example to find customer IDs present in both `orders` and `customers`:*  
```sql
SELECT customer_id FROM orders
INTERSECT
SELECT customer_id FROM customers;
```
**Note:** MySQL does not support the `INTERSECT` operator natively. In MySQL you can simulate this using an inner join:
```sql
SELECT DISTINCT o.customer_id
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;
```

---

### 7. EXCEPT  
*Standard SQL example to find products that have never been ordered (products not present in order_items):*  
```sql
SELECT product_id FROM products
EXCEPT
SELECT product_id FROM order_items;
```
**Note:** Since MySQL does not support the `EXCEPT` operator, you can achieve the same result using a `NOT IN` clause (as shown in the SELECT WHERE NOT IN example) or a LEFT JOIN:
```sql
SELECT p.product_id
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;
```

---

### 8. UNION  
*Using `UNION` to combine distinct results, for example merging names from `products` and `categories`:*  
```sql
SELECT name FROM products
UNION
SELECT name FROM categories;
```
*This query returns a distinct list of names appearing in either table.*