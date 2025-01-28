### **Creating a User with Full Privileges**

1. **Create a User:**
   Use the `CREATE USER` command to create a new user account.

   ```sql
   create user 'new_user'@'localhost' identified by 'password123';
   ```

   - `'new_user'` is the username.
   - `'localhost'` restricts connections to the local machine. Use `'%'` to allow connections from any host.
   - `'password123'` is the password for the user.

2. **Grant Full Privileges:**
   Grant the user all privileges on all databases and tables.

   ```sql
   grant all privileges on *.* to 'new_user'@'localhost';
   ```

   - `*.*` means all databases (`*`) and all tables (`*`).
   - `all privileges` allows the user to perform any operation.

3. **Apply Privilege Changes:**
   After granting privileges, ensure they take effect.

   ```sql
   flush privileges;
   ```

4. **Verify Privileges:**
   View the privileges granted to the user.

   ```sql
   show grants for 'new_user'@'localhost';
   ```

---

### **Reducing Privileges Gradually**

1. **Revoke Global Privileges:**
   Remove all privileges globally to start customizing.

   ```sql
   revoke all privileges, grant option from 'new_user'@'localhost';
   ```

2. **Grant Database-Level Privileges:**
   Limit access to a specific database (e.g., `ecommerce_db`).

   ```sql
   grant select, insert, update on ecommerce_db.* to 'new_user'@'localhost';
   ```

   - This allows the user to `SELECT`, `INSERT`, and `UPDATE` data in the `ecommerce_db`.

3. **Grant Table-Level Privileges:**
   Restrict access to specific tables within a database.

   ```sql
   grant select, insert on ecommerce_db.orders to 'new_user'@'localhost';
   ```

4. **Grant Column-Level Privileges:**
   Further refine access to specific columns in a table.

   ```sql
   grant select (customer_name, order_date) on ecommerce_db.orders to 'new_user'@'localhost';
   ```

5. **Grant Procedure Privileges:**
   Allow execution of specific stored procedures.

   ```sql
   grant execute on procedure ecommerce_db.generate_report to 'new_user'@'localhost';
   ```

6. **Revoke Specific Privileges:**
   Remove specific access as needed.

   ```sql
   revoke insert on ecommerce_db.orders from 'new_user'@'localhost';
   ```

---

### **Principle of Least Privilege**

Encourage the use of the "principle of least privilege" by ensuring users have only the permissions necessary for their tasks. This enhances security and minimizes risks.
