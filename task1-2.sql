/*
Task 4: Order Fulfillment Insights
Scenario: To monitor order fulfillment, you need data on delayed orders.

Task: Write an SQL query to list all orders where the delivery date exceeds the expected delivery date. Include:

Order ID
Customer First Name
Customer Last Name
Expected delivery date
Actual delivery date

*/

select orders.order_id as `Order ID`, 
	customers.first_name as `Customer First Name`,
    customers.last_name as `Customer Last Name`,
	expected_delivery_date as `Expected Delivery Date`, 
    actual_delivery_date as `Actual Delivery Date`
from customers 
join orders on customers.customer_id = orders.customer_id
where actual_delivery_date > expected_delivery_date;