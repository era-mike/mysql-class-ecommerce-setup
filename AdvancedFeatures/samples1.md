To disable **query cache** for a specific query in MySQL, use the `SQL_NO_CACHE` hint:

```sql
SELECT SQL_NO_CACHE * FROM people WHERE person_last_name = 'Smith';
```

### **Explanation**
- `SQL_NO_CACHE` **prevents MySQL from using the query cache**.
- Each execution of the query **fetches fresh data** from the table instead of retrieving it from cache.

---

### **To Disable Query Cache Globally (For All Queries)**
If you want to **turn off MySQL query cache** completely (not recommended for production), use:

```sql
SET SESSION query_cache_type = OFF;
SET GLOBAL query_cache_type = OFF;
```

