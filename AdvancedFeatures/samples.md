
## **1️⃣ MERGE (Simulated using `INSERT ... ON DUPLICATE KEY UPDATE`)**
🔹 **MERGE** is not natively supported in MySQL, but we can **simulate it** using `INSERT ... ON DUPLICATE KEY UPDATE`.

**Use Case:** If a person exists, update their last name; otherwise, insert a new record.
```sql
INSERT INTO people (person_id, person_first_name, person_last_name, person_title, building_id)
VALUES (1, 'John', 'DoeUpdated', 'Professor', 3)
ON DUPLICATE KEY UPDATE person_last_name = VALUES(person_last_name);
```
✅ **What this does:**  
- If `person_id = 1` **exists**, it updates `person_last_name` to `'DoeUpdated'`.
- Otherwise, it **inserts a new row**.

---

## **2️⃣ UPSERT (INSERT ... ON DUPLICATE KEY UPDATE)**
🔹 **UPSERT** is inserting or updating data **in one step**.

**Use Case:** If a device exists, update its `device_type_id`; otherwise, insert a new device.
```sql
INSERT INTO devices (device_id, person_id, device_type_id)
VALUES (1, 10, 3)
ON DUPLICATE KEY UPDATE device_type_id = VALUES(device_type_id);
```
✅ **What this does:**  
- If `device_id = 1` **exists**, it updates `device_type_id` to `3`.
- Otherwise, it **inserts a new row**.

---

## **3️⃣ UNION (Combining Results from Two Tables)**
🔹 **`UNION`** combines results from **multiple queries**, eliminating duplicates.

**Use Case:** Get **all unique** people and buildings' names.
```sql
SELECT person_first_name AS name FROM people
UNION
SELECT building_name FROM buildings;
```
✅ **What this does:**  
- Combines **people's first names** and **building names** into one list.
- **Removes duplicates**.

---

## **4️⃣ INTERSECT (Simulated with `INNER JOIN`)**
🔹 **MySQL does NOT support `INTERSECT`** directly, but we can **simulate it** with `INNER JOIN`.

**Use Case:** Find people who have at least **one assigned device**.
```sql
SELECT DISTINCT p.person_id, p.person_first_name
FROM people p
INNER JOIN devices d ON p.person_id = d.person_id;
```
✅ **What this does:**  
- Retrieves **only people who have devices**.

---

## **5️⃣ EXCEPT (Simulated with `LEFT JOIN` + `WHERE IS NULL`)**
🔹 **MySQL does NOT support `EXCEPT`**, but we can **simulate it** with `LEFT JOIN`.

**Use Case:** Find people **who do NOT have a device**.
```sql
SELECT p.person_id, p.person_first_name
FROM people p
LEFT JOIN devices d ON p.person_id = d.person_id
WHERE d.person_id IS NULL;
```
✅ **What this does:**  
- Finds **people with no assigned devices**.

---

## **6️⃣ Subqueries**
🔹 **A subquery** is a query inside another query.

**Use Case:** Find **buildings that contain at least 10 people**.
```sql
SELECT building_id, building_name 
FROM buildings 
WHERE building_id IN (
    SELECT building_id FROM people GROUP BY building_id HAVING COUNT(*) >= 10
);
```
✅ **What this does:**  
- Uses a **subquery** to filter **buildings with ≥10 people**.

---

## **7️⃣ Common Table Expressions (CTE)**
🔹 **CTEs** improve readability and allow **reusable subqueries**.

**Use Case:** Find **top 5 buildings with the most people**.
```sql
WITH BuildingCounts AS (
    SELECT building_id, COUNT(*) AS total_people
    FROM people
    GROUP BY building_id
)
SELECT b.building_name, bc.total_people
FROM buildings b
JOIN BuildingCounts bc ON b.building_id = bc.building_id
ORDER BY bc.total_people DESC
LIMIT 5;
```
✅ **What this does:**  
- First, the **CTE (`BuildingCounts`)** groups people by `building_id`.
- Then, we **join with `buildings`** to get names and sort.

---

## **8️⃣ Window Functions**
🔹 **Window functions** calculate values **across rows**.

**Use Case:** Rank people in each building **by person_id**.
```sql
SELECT person_id, person_first_name, building_id,
       RANK() OVER (PARTITION BY building_id ORDER BY person_id) AS rank_in_building
FROM people;
```
✅ **What this does:**  
- **Ranks people** **within each building**, **ordered by `person_id`**.

---

## **9️⃣ Dynamic SQL**
🔹 **Dynamic SQL** is useful for **parameterized queries**.

**Use Case:** Select a building dynamically **based on user input**.
```sql
SET @building_name = 'Building A1';
SET @query = CONCAT('SELECT * FROM buildings WHERE building_name = "', @building_name, '";');
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
```
✅ **What this does:**  
- Allows **dynamic filtering** based on a **variable**.

---

## **🔟 CASE Statements**
🔹 **`CASE`** allows **conditional logic** inside SQL queries.

**Use Case:** Categorize people **based on `building_id`**.
```sql
SELECT person_id, person_first_name, building_id,
       CASE 
           WHEN building_id BETWEEN 1 AND 5 THEN 'Small Campus'
           WHEN building_id BETWEEN 6 AND 15 THEN 'Medium Campus'
           ELSE 'Large Campus'
       END AS campus_size
FROM people;
```
✅ **What this does:**  
- Categorizes buildings into **Small, Medium, Large Campuses**.

---

## **1️⃣1️⃣ Self Join**
🔹 **Self joins** allow a table to join **itself**.

**Use Case:** Find **colleagues in the same building**.
```sql
SELECT p1.person_first_name AS PersonA, p2.person_first_name AS PersonB, p1.building_id
FROM people p1
JOIN people p2 ON p1.building_id = p2.building_id AND p1.person_id <> p2.person_id;
```
✅ **What this does:**  
- Pairs up **people from the same building**.

---

## **1️⃣2️⃣ Cross Join**
🔹 **Cross joins** create **all possible combinations**.

**Use Case:** List **every possible `device_type` each person could have**.
```sql
SELECT p.person_first_name, dt.device_type_name
FROM people p
CROSS JOIN device_types dt;
```
✅ **What this does:**  
- **Matches every person** with **every device type**.

---

## **🚀 Summary Table**
| Concept | Example Use Case |
|----------|--------------------------------|
| **MERGE** | Insert/update people’s last names |
| **UPSERT** | Insert/update device assignments |
| **UNION** | Combine people & building names |
| **INTERSECT** | Find people with devices |
| **EXCEPT** | Find people **without** devices |
| **Subqueries** | Find buildings with ≥10 people |
| **CTE** | Find top 5 largest buildings |
| **Window Functions** | Rank people in buildings |
| **Dynamic SQL** | Filter buildings dynamically |
| **CASE Statements** | Categorize buildings |
| **Self Join** | Find colleagues in the same building |
| **Cross Join** | Generate all person-device combos |

---
