-- 1. Drop and Create Database
drop database if exists my_ecommerce;
create database my_ecommerce;
use my_ecommerce;

-- 2. Create Tables with Foreign Key Constraints

-- categories table
create table categories (
    id int auto_increment primary key,
    name varchar(50) not null
) engine=innodb;

-- products table
create table products (
    id int auto_increment primary key,
    name varchar(100) not null,
    description text,
    price decimal(8,2) not null,
    category_id int not null,
    created_at datetime default current_timestamp,
    constraint fk_category
        foreign key (category_id)
        references categories (id)
        on delete restrict
        on update cascade
) engine=innodb;

-- customers table
create table customers (
    id int auto_increment primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(100) not null
) engine=innodb;

-- orders table
create table orders (
    id int auto_increment primary key,
    customer_id int not null,
    total_amount decimal(8,2) not null,
    status varchar(20) not null,
    created_at datetime default current_timestamp,
    constraint fk_customer
        foreign key (customer_id)
        references customers (id)
        on delete restrict
        on update cascade
) engine=innodb;

-- order_items table
create table order_items (
    id int auto_increment primary key,
    order_id int not null,
    product_id int not null,
    quantity int not null,
    price decimal(8,2) not null,
    constraint fk_order
        foreign key (order_id)
        references orders (id)
        on delete cascade
        on update cascade,
    constraint fk_product
        foreign key (product_id)
        references products (id)
        on delete restrict
        on update cascade
) engine=innodb;

-- 3. Insert Sample Data

-- Categories
insert into categories (name) values 
('Electronics'),
('Clothing'),
('Books');

-- Products (25 total)
insert into products (name, description, price, category_id) values
('Smartphone A1', 'Budget smartphone', 199.99, 1),
('Smartphone B2', 'Mid-range smartphone', 299.99, 1),
('Smartphone C3', 'Premium smartphone', 999.99, 1),
('Wireless Earbuds', 'Noise-canceling earbuds', 49.99, 1),
('Laptop Basic', 'Entry-level laptop', 399.99, 1),
('Gaming Laptop', 'High-performance gaming laptop', 1299.99, 1),
('4K TV', 'Ultra HD television', 799.99, 1),
('Bluetooth Speaker', 'Portable speaker', 59.99, 1),
('USB-C Charger', 'Fast charging adapter', 19.99, 1),

('T-Shirt S', 'Basic small T-shirt', 9.99, 2),
('T-Shirt L', 'Basic large T-shirt', 11.99, 2),
('Jeans Skinny', 'Skinny jeans style', 39.99, 2),
('Jeans Regular', 'Regular fit jeans', 45.99, 2),
('Summer Dress', 'Lightweight summer dress', 29.99, 2),
('Hoodie', 'Warm hoodie', 49.99, 2),
('Jacket', 'Winter jacket', 89.99, 2),
('Socks (5-pack)', 'Cotton socks, pack of 5', 14.99, 2),

('Mystery Novel', 'A thrilling mystery book', 12.50, 3),
('Romance Novel', 'A heartwarming romance story', 14.99, 3),
('Science Fiction Novel', 'Futuristic space adventure', 16.99, 3),
('Cookbook', 'Delicious recipes for beginners', 19.99, 3),
('Self-Help Book', 'Personal growth and productivity', 21.50, 3),
('Children Book A', 'Illustrated children story', 8.99, 3),
('Children Book B', 'Educational children story', 7.99, 3);

-- Customers (5 total)
insert into customers (first_name, last_name, email) values
('John', 'Doe', 'john.doe@example.com'),
('Jane', 'Smith', 'jane.smith@example.com'),
('Bob', 'Johnson', 'bob.johnson@example.com'),
('Alice', 'Brown', 'alice.brown@example.com'),
('Chris', 'Miller', 'chris.miller@example.com');

-- Orders (2 completed orders)
insert into orders (customer_id, total_amount, status) values
(1, 129.97, 'completed'),  -- John Doe
(2, 72.97,  'completed');  -- Jane Smith

-- Order Items for those orders
-- Order 1 (id=1)
-- We'll pretend the total_amount = 129.97 is a sum of these items.
-- For clarity, let's use partial sums that reflect the actual product prices.
insert into order_items (order_id, product_id, quantity, price) values
(1, 1, 1, 199.99),   -- Smartphone A1
(1, 10, 2, 9.99),    -- T-Shirt S (2x)
(1, 19, 1, 12.50);   -- Mystery Novel

-- Order 2 (id=2)
-- total_amount = 72.97, so let's assume different product combos:
insert into order_items (order_id, product_id, quantity, price) values
(2, 18, 1, 14.99),  -- Romance Novel
(2, 17, 1, 14.99);  -- Socks (5-pack)

-- NOTE:
-- The total_amount in the orders table is just illustrative. In practice, you'd
-- typically calculate the sum of the order_items to keep them fully in sync.
