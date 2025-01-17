/*

**Task 1-13: Cancel Pending Orders**
   Delete all orders that are in `pending` status and were created more than 7 days ago.

   **Hint**:
   ```sql
   DELETE FROM orders 
   WHERE status = 'pending' AND created_at < DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY);
   `

   
*/