/*
---

**Task 1-12: Delete Outdated Products**
   Remove all products that were created more than 1 year ago.

   **Hint**:
   ```sql
   DELETE FROM products 
   WHERE created_at < DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR);
   ```


*/