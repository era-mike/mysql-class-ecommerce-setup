

### **Project: Normalize the Orders Database**

---

#### **Task 1: Create a Table for Orders That Violates 2NF**

**Description**:  
Create a table named `orders_violate_2nf` that captures details about orders, products, and customers. Include the following columns:
- `order_id`: Primary key.
- `product_id`: Part of the primary key, uniquely identifies a product.
- `product_name`: Name of the product (redundant).
- `customer_id`: Part of the primary key, uniquely identifies a customer.
- `customer_name`: Name of the customer (redundant).
- `customer_address`: Address of the customer.

**Acceptance Criteria**:
- Ensure the table is created with the correct data types.
- Insert the following data:

1. **Order 1**:
   - **Product**: Laptop (Product ID: 101)
   - **Customer**: Alice (Customer ID: 1)
   - **Address**: 123 Elm St.

2. **Order 2**:
   - **Product**: Mouse (Product ID: 102)
   - **Customer**: Bob (Customer ID: 2)
   - **Address**: 456 Oak St.

3. **Order 3**:
   - **Product**: Laptop (Product ID: 101)
   - **Customer**: Charlie (Customer ID: 3)
   - **Address**: 789 Pine St.

4. **Order 4**:
   - **Product**: Keyboard (Product ID: 103)
   - **Customer**: Alice (Customer ID: 1)
   - **Address**: 123 Elm St.

<details>
<summary>Click to View Solution</summary>

```sql
-- Create a table that violates 2NF
create table orders_violate_2nf (
    order_id int not null,
    product_id int not null,
    product_name varchar(100),
    customer_id int not null,
    customer_name varchar(100),
    customer_address varchar(255),
    primary key (order_id, product_id)
);

-- Insert data into the table
insert into orders_violate_2nf (order_id, product_id, product_name, customer_id, customer_name, customer_address)
values
(1, 101, 'Laptop', 1, 'Alice', '123 Elm St.'),
(2, 102, 'Mouse', 2, 'Bob', '456 Oak St.'),
(3, 101, 'Laptop', 3, 'Charlie', '789 Pine St.'),
(4, 103, 'Keyboard', 1, 'Alice', '123 Elm St.');
```

</details>

---

#### **Task 2: Identify Issues in the Current Table**

**Description**:  
Write SQL queries to demonstrate the issues in the `orders_violate_2nf` table:
1. Retrieve all orders and inspect redundancy.
2. Find products purchased by customer `'Alice'`.
3. Identify duplicate `product_name` entries for the same `product_id`.

**Acceptance Criteria**:
- Queries should highlight data redundancy and anomalies.

<details>
<summary>Click to View Solution</summary>

```sql
-- Retrieve all orders
select * from orders_violate_2nf;

-- Find products purchased by Alice
select product_name
from orders_violate_2nf
where customer_name = 'Alice';

-- Identify duplicate product names for the same product_id
select product_id, product_name, count(*)
from orders_violate_2nf
group by product_id, product_name
having count(*) > 1;
```

</details>

---

#### **Task 3: Design a Normalized Database**

**Description**:  
Normalize the `orders_violate_2nf` table to 2NF by creating three new tables:
1. `products`:
   - `product_id`: Primary key.
   - `product_name`: Name of the product.
2. `customers`:
   - `customer_id`: Primary key.
   - `customer_name`: Name of the customer.
   - `customer_address`: Address of the customer.
3. `orders`:
   - `order_id`: Primary key.
   - `product_id`: Foreign key referencing `products`.
   - `customer_id`: Foreign key referencing `customers`.

**Acceptance Criteria**:
- Create the three tables with appropriate foreign key constraints.

<details>
<summary>Click to View Solution</summary>

```sql
-- Create a table for products
create table products (
    product_id int not null,
    product_name varchar(100),
    primary key (product_id)
);

-- Create a table for customers
create table customers (
    customer_id int not null,
    customer_name varchar(100),
    customer_address varchar(255),
    primary key (customer_id)
);

-- Create a table for orders
create table orders (
    order_id int not null,
    product_id int not null,
    customer_id int not null,
    primary key (order_id),
    foreign key (product_id) references products(product_id),
    foreign key (customer_id) references customers(customer_id)
);
```

</details>

---

#### **Task 4: Insert Data into Normalized Tables**

**Description**:  
Write SQL statements to populate the `products`, `customers`, and `orders` tables with data. Use the following guidelines:
- Each product and customer should have unique details.
- Ensure foreign key relationships are maintained.

<details>
<summary>Click to View Solution</summary>

```sql
-- Insert data into the products table
insert into products (product_id, product_name)
values
(101, 'Laptop'),
(102, 'Mouse'),
(103, 'Keyboard');

-- Insert data into the customers table
insert into customers (customer_id, customer_name, customer_address)
values
(1, 'Alice', '123 Elm St.'),
(2, 'Bob', '456 Oak St.'),
(3, 'Charlie', '789 Pine St.');

-- Insert data into the orders table
insert into orders (order_id, product_id, customer_id)
values
(1, 101, 1),
(2, 102, 2),
(3, 101, 3),
(4, 103, 1);
```

</details>

---

#### **Task 5: Query the Normalized Database**

**Description**:  
Write SQL queries to retrieve data from the normalized tables:
1. Show all orders with product and customer details (use `JOIN`).
2. Find all products purchased by customer `'Alice'`.
3. List all customers who purchased the product `'Laptop'`.
4. Count how many times each product was ordered.

<details>
<summary>Click to View Solution</summary>

```sql
-- Show all orders with product and customer details
select o.order_id, p.product_name, c.customer_name, c.customer_address
from orders o
join products p on o.product_id = p.product_id
join customers c on o.customer_id = c.customer_id;

-- Find all products purchased by Alice
select p.product_name
from orders o
join products p on o.product_id = p.product_id
join customers c on o.customer_id = c.customer_id
where c.customer_name = 'Alice';

-- List all customers who purchased the product 'Laptop'
select c.customer_name, c.customer_address
from orders o
join products p on o.product_id = p.product_id
join customers c on o.customer_id = c.customer_id
where p.product_name = 'Laptop';

-- Count how many times each product was ordered
select p.product_name, count(o.order_id) as order_count
from orders o
join products p on o.product_id = p.product_id
group by p.product_name;
```

</details>

---
