

# MySQL Exercises Using the `hobbies` Database

Below is a set of exercises that you can assign to your students. Each exercise is followed by a collapsible solution section.

---

## Exercise 1 – Basic SELECT Statement

**Task:**  
Select all columns from the `activities` table.

<details>
  <summary>Solution</summary>

```sql
SELECT * FROM activities;
```

</details>

---

## Exercise 2 – SELECT with Specific Columns and Filtering

**Task:**  
Select the `name` and `description` columns from the `activities` table where the category is `2` (Intellectual). (Hint: Use the foreign key `category_id`.)

<details>
  <summary>Solution</summary>

```sql
SELECT name, description
FROM activities
WHERE category_id = 2;
```

</details>

---

## Exercise 3 – INNER JOIN Between Tables

**Task:**  
Write a query to retrieve the activity `name` along with its corresponding category `name`. Use an INNER JOIN between `activities` and `categories`.

<details>
  <summary>Solution</summary>

```sql
SELECT a.name AS activity_name, c.name AS category_name
FROM activities a
INNER JOIN categories c ON a.category_id = c.id;
```

</details>

---

## Exercise 4 – LEFT JOIN Example

**Task:**  
Retrieve all activities and any associated example names from the `examples` table. Include activities even if they have no examples.

<details>
  <summary>Solution</summary>

```sql
SELECT a.name AS activity_name, e.name AS example_name
FROM activities a
LEFT JOIN examples e ON a.id = e.activity_id;
```

</details>

---

## Exercise 5 – RIGHT JOIN Example

**Task:**  
Assuming every example is associated with an activity, retrieve all examples along with the corresponding activity name using a RIGHT JOIN.  
*Note:* RIGHT JOIN might be less common in MySQL; this is for practice.

<details>
  <summary>Solution</summary>

```sql
SELECT a.name AS activity_name, e.name AS example_name
FROM activities a
RIGHT JOIN examples e ON a.id = e.activity_id;
```

</details>

---

## Exercise 6 – CROSS JOIN

**Task:**  
Write a query that performs a CROSS JOIN between `categories` and `activities` to generate a result showing every combination of category and activity.

<details>
  <summary>Solution</summary>

```sql
SELECT c.name AS category_name, a.name AS activity_name
FROM categories c
CROSS JOIN activities a;
```

</details>

---

## Exercise 7 – Filtering with LIKE

**Task:**  
Select all columns from the `_activities_old` table where the `activity_name` contains the word “Drawing”.

<details>
  <summary>Solution</summary>

```sql
SELECT *
FROM _activities_old
WHERE activity_name LIKE '%Drawing%';
```

</details>

---

## Exercise 8 – Filtering with IN

**Task:**  
Select the `name` and `description` from `activities` where the `category_id` is either 1 or 3.

<details>
  <summary>Solution</summary>

```sql
SELECT name, description
FROM activities
WHERE category_id IN (1, 3);
```

</details>

---

## Exercise 9 – UPDATE Statement

**Task:**  
Update the `description` of the activity with `id` = 2 in the `activities` table to "A refreshing walk in nature".

<details>
  <summary>Solution</summary>

```sql
UPDATE activities
SET description = 'A refreshing walk in nature'
WHERE id = 2;
```

</details>

---

## Exercise 10 – DELETE Statement

**Task:**  
Delete the influencer record where the `name` is "Leonardo da Vinci" from the `influencers` table.

<details>
  <summary>Solution</summary>

```sql
DELETE FROM influencers
WHERE name = 'Leonardo da Vinci';
```

</details>

---

## Exercise 11 – Using ORDER BY

**Task:**  
Select all columns from the `activities` table and order the results by the `name` column in ascending order.

<details>
  <summary>Solution</summary>

```sql
SELECT *
FROM activities
ORDER BY name ASC;
```

</details>

