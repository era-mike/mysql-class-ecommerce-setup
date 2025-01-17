/*


Task 5: Adding a New Product
Scenario: A new product is being added to the database.

Task 5: Write an SQL script to:

Add a new product with the following details:
Name: "Wireless Headphones"
Description: "These phones are for your head!"
Price: $120
Stock: 50 units
Category: "Electronics"
Verify that the product has been added correctly using a SELECT query.

*/

insert into products (name, description, price, stock_available, category_id)
values ('Wireless Headphones', 'These phones are for your head!',120,50, 1);

## subquery


insert into products (name, description, price, stock_available, category_id)
values ('Wireless Headphones 2', 'These phones are for your head!',120,50, (select category_id from categories where name = 'Electronics'));

select *
from products 
order by product_id desc;
