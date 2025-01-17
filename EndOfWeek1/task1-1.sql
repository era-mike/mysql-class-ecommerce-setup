/*
Task 1: Displaying Product Details
Scenario: You are building an e-commerce application. One of the features is to display product details to customers.

Task: Write an SQL query to retrieve the following information for all products:

Product name
Price
Category
Availability (In Stock or Out of Stock)
Include logic to mark products with a stock quantity of 0 as "Out of Stock" and all others as "In Stock."

*/

SELECT 
    price AS `Price`, 
    categories.name AS `Category`, 
    products.stock_available,
    CASE 
        WHEN products.stock_available = 0 THEN 'Out of Stock' 
        ELSE 'In Stock' 
    END AS stock_status
FROM 
    products
JOIN 
    categories 
ON 
    products.category_id = categories.category_id;


SELECT 
    price AS `Price`, 
    categories.name AS `Category`, 
    products.stock_available,
    IF(products.stock_available = 0, 'Out of Stock', 'In Stock') AS stock_status
FROM 
    products
JOIN 
    categories 
ON 
    products.category_id = categories.category_id;

