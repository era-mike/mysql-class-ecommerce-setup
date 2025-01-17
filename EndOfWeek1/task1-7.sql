/*
**Task 1-7: Add a New Order**
   Insert an order for customer ID 3 with a total amount of $350.50 and status `pending`. Set the creation date to today's date and the expected delivery date to 3 days later.

   **Hint**:
   ```sql
   INSERT INTO orders (customer_id, total_amount, status, created_at, expected_delivery_date) 
   VALUES (3, 350.50, 'pending', CURRENT_DATE, DATE_ADD(CURRENT_DATE, INTERVAL 3 DAY));
   ```


*/