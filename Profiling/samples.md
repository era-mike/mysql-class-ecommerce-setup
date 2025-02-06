## **Detailed Guide: Profiling in MySQL 8+ Using the Employees Database**
This step-by-step guide will help students **analyze query performance**, **identify inefficiencies**, and **optimize performance** using **profiling techniques** in MySQL 8+. 

---
## **💡 Phase 1: Query Execution Time Profiling**
### **Task 1: Detecting Full Table Scans Using `EXPLAIN ANALYZE`**
👉 **Goal**: Determine if queries are scanning an entire table instead of using an index.  

### **Step 1: Run a Query and Analyze Execution**
```sql
EXPLAIN ANALYZE 
SELECT * 
FROM employees 
WHERE hire_date > '2000-01-01';
```
### **How to Interpret the Output**
1. **Look for “full table scan” in the output.**  
   - If MySQL **scans every row**, it's a **table scan** (bad for performance).  
   - You’ll see something like:  
     ```
     rows_examined: 300,000 (all rows scanned)
     ```
     🚩 **Warning**: **Inefficient filtering** → The query is searching **without an index**, making MySQL scan **all rows**.

2. **Check if an index is used**:  
   - If MySQL uses an **index**, the output will include:
     ```
     using index condition
     ```
     ✅ **Good!** MySQL is only scanning **relevant** rows.

3. **Detect large `rows_examined` values**:  
   - A high number (e.g., `300,000` rows) means **MySQL is scanning a large portion of the table**.
   - Compare with the **total table size**:
     ```sql
     SELECT COUNT(*) FROM employees;
     ```
   - If `rows_examined` ≈ total rows → 🚩 Full Table Scan!

---

### **Task 2: Checking Query Performance with `SHOW PROFILE`**
👉 **Goal**: Measure query execution **step-by-step** to see which part is slow.

### **Step 1: Enable Profiling**
```sql
SET profiling = 1;
```

### **Step 2: Run a Query**
```sql
SELECT d.dept_name, AVG(s.salary) 
FROM salaries s 
JOIN dept_emp de ON s.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC;
```

### **Step 3: View Query Performance**
```sql
SHOW PROFILES;
```
➡️ **This lists all executed queries along with their execution time.**  
  
Find the query ID **(let’s say it’s `1`)**, then run:
```sql
SHOW PROFILE FOR QUERY 1;
```

### **How to Interpret the Output**
- **Look for "Sending data"**  
  - If it's taking **too long**, MySQL might be **sorting too many rows**.
- **Check for "Sorting result"**
  - **Sorting can be slow** if done **without an index**.
- **Check for "Creating temporary table"**
  - 🚩 **Red Flag**: MySQL is **creating a temp table** instead of using indexes → **Performance hit!**

---

## **💡 Phase 2: Indexing and Performance Analysis**
### **Task 3: Compare Query Performance Before and After Indexing**
👉 **Goal**: Speed up queries using indexes.

### **Step 1: Check Existing Indexes**
```sql
SHOW INDEX FROM employees;
```
🚩 **If there’s NO index on `hire_date`, we must add one!**  

### **Step 2: Create an Index**
```sql
CREATE INDEX idx_hire_date ON employees(hire_date);
```

### **Step 3: Run the Query Again**
```sql
EXPLAIN ANALYZE 
SELECT * FROM employees WHERE hire_date > '2000-01-01';
```

### **What to Check**
1. **Does MySQL use an index now?**  
   ✅ If you see:
   ```
   using index condition
   ```
   → The index is working!  

2. **Compare `rows_examined`**:
   - Before index: `rows_examined: 300,000`
   - After index: `rows_examined: 5,000`
   🚀 **Huge Improvement!**

---

## **💡 Phase 3: Advanced Optimization**
### **Task 4: Find Slow Queries Using Performance Schema**
👉 **Goal**: Find the slowest queries in MySQL.

### **Step 1: Enable Query Monitoring**
```sql
UPDATE performance_schema.setup_consumers 
SET ENABLED = 'YES' 
WHERE NAME = 'events_statements_history_long';
```

### **Step 2: View Slow Queries**
```sql
SELECT event_id, sql_text, timer_wait, lock_time, rows_examined
FROM performance_schema.events_statements_history_long
ORDER BY timer_wait DESC
LIMIT 5;
```

### **What to Look For**
🚩 **If a query has**:
- **High `timer_wait` values** → The query takes too long.
- **High `rows_examined`** → Scanning too many rows → **Needs an index!**
- **High `lock_time`** → Transaction delays → **Possible row-lock contention!**

---

### **Task 5: Improve Performance with Materialized Views (Precomputed Tables)**
👉 **Goal**: Store **precomputed** results for faster queries.

### **Step 1: Identify a Slow Query**
```sql
SELECT d.dept_name, AVG(s.salary) 
FROM salaries s 
JOIN dept_emp de ON s.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
GROUP BY d.dept_name;
```
💡 **This query runs every time, recalculating averages.**

### **Step 2: Create a Materialized View (Temporary Table)**
```sql
CREATE TABLE dept_salary_summary AS
SELECT d.dept_name, AVG(s.salary) AS avg_salary
FROM salaries s
JOIN dept_emp de ON s.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
GROUP BY d.dept_name;
```

### **Step 3: Query the Precomputed Table**
```sql
SELECT * FROM dept_salary_summary ORDER BY avg_salary DESC;
```
🚀 **Now, MySQL fetches results instantly instead of recalculating every time!**

---

## **💡 Phase 4: Locking and Concurrency Analysis**
### **Task 6: Detect Lock Contention**
👉 **Goal**: Find queries that cause **transaction delays**.

### **Step 1: Enable Lock Monitoring**
```sql
UPDATE performance_schema.setup_instruments 
SET ENABLED = 'YES', TIMED = 'YES' 
WHERE NAME LIKE 'wait/lock/%';
```

### **Step 2: Find Locked Queries**
```sql
SELECT EVENT_NAME, OBJECT_SCHEMA, OBJECT_NAME, TIMER_WAIT
FROM performance_schema.data_locks
ORDER BY TIMER_WAIT DESC
LIMIT 5;
```

### **What to Look For**
🚩 **If you see long lock times**, transactions are slowing down.
- **Check if too many users modify the same table.**
- **Consider using `row-based locking` instead of `table locking`.**

---

## **💡 Phase 5: Generating a Performance Report**
### **Task 7: Find Top Slow Queries**
👉 **Goal**: Identify and fix slowest queries.

### **Step 1: Identify Slow Queries**
```sql
SELECT DIGEST_TEXT, COUNT_STAR, SUM_TIMER_WAIT / 1000000000 AS total_time_ms
FROM performance_schema.events_statements_summary_by_digest
ORDER BY SUM_TIMER_WAIT DESC
LIMIT 5;
```
🚩 **If a query appears often, it should be optimized!**

### **Step 2: Create an Optimization Report**
✅ **Before Optimization:**
| Query | Rows Examined | Execution Time |
|-------|--------------|---------------|
| `SELECT * FROM employees WHERE hire_date > '2000-01-01'` | 300,000 | 2.5 sec |

✅ **After Optimization (Index Added):**
| Query | Rows Examined | Execution Time |
|-------|--------------|---------------|
| `SELECT * FROM employees WHERE hire_date > '2000-01-01'` | 5,000 | 0.02 sec 🚀 |

---

## **🔹 Summary: What We Achieved**
✅ **Reduced full table scans**  
✅ **Improved query execution time**  
✅ **Identified and fixed slow queries**  
✅ **Used indexing and materialized views for optimization**  

These steps **simulate real-world database tuning** for students to master **MySQL profiling & performance optimization**. 🚀