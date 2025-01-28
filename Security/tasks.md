## **Lesson Plan: Advanced MySQL Security and Data Management**

## **Task 1: Create the Database and Tables**

### **Part A: Create the Database and Tables**

**Instructions**:

1. **Create the Database**:
   - Create a new database named `school_system`.

2. **Create the `schools` Table**:
   - Columns:
     - `school_id`: Integer, Primary Key, Auto-Incremented
     - `school_name`: Variable character (VARCHAR) with a maximum of 100 characters, cannot be NULL
     - `address`: Variable character (VARCHAR) with a maximum of 255 characters, cannot be NULL
     - `principal`: Variable character (VARCHAR) with a maximum of 100 characters, cannot be NULL

3. **Create the `teachers` Table**:
   - Columns:
     - `teacher_id`: Integer, Primary Key, Auto-Incremented
     - `teacher_name`: Variable character (VARCHAR) with a maximum of 100 characters, cannot be NULL
     - `subject`: Variable character (VARCHAR) with a maximum of 100 characters, cannot be NULL
     - `school_id`: Integer, Foreign Key referencing `schools(school_id)`, cannot be NULL

4. **Create the `students` Table**:
   - Columns:
     - `student_id`: Integer, Primary Key, Auto-Incremented
     - `student_name`: Variable character (VARCHAR) with a maximum of 100 characters, cannot be NULL
     - `grade_level`: Integer, cannot be NULL
     - `school_id`: Integer, Foreign Key referencing `schools(school_id)`, cannot be NULL

5. **Create the `classes` Table**:
   - Columns:
     - `class_id`: Integer, Primary Key, Auto-Incremented
     - `class_name`: Variable character (VARCHAR) with a maximum of 100 characters, cannot be NULL
     - `final_grade`: Character (CHAR) of length 1, can be NULL
     - `teacher_id`: Integer, Foreign Key referencing `teachers(teacher_id)`, cannot be NULL

6. **Create the `class_students` Table**:
   - Columns:
     - `student_id`: Integer, Foreign Key referencing `students(student_id)`, cannot be NULL
     - `class_id`: Integer, Foreign Key referencing `classes(class_id)`, cannot be NULL
   - Primary Key:
     - Composite key consisting of `student_id` and `class_id`
<details>
<summary>**Solution**</summary>

```sql
-- Create Database
CREATE DATABASE school_system;
USE school_system;

-- Create Tables

CREATE TABLE schools (
    school_id INT AUTO_INCREMENT PRIMARY KEY,
    school_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    principal VARCHAR(100) NOT NULL
);

CREATE TABLE teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_name VARCHAR(100) NOT NULL,
    subject VARCHAR(100) NOT NULL,
    school_id INT NOT NULL,
    FOREIGN KEY (school_id) REFERENCES schools(school_id)
);

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    grade_level INT NOT NULL,
    school_id INT NOT NULL,
    FOREIGN KEY (school_id) REFERENCES schools(school_id)
);

CREATE TABLE classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL,
    final_grade CHAR(1),
    teacher_id INT NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);

CREATE TABLE class_students (
    student_id INT NOT NULL,
    class_id INT NOT NULL,
    PRIMARY KEY (student_id, class_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);
```

</details>

---

### **Part B: Insert Data into Tables**

**Instructions**:

**Note**: Do **not** specify the primary key values (`school_id`, `teacher_id`, `student_id`, `class_id`) during data insertion. Let MySQL automatically assign these values using the `AUTO_INCREMENT` feature.

1. **Insert Data into the `schools` Table**:
   - Insert the following schools:
     - School Name: `'Springfield High'`
     - Address: `'123 Main St'`
     - Principal: `'Mr. Skinner'`

     ---
     
     - School Name: `'Shelbyville Academy'`
     - Address: `'456 Elm St'`
     - Principal: `'Ms. Crabapple'`

2. **Insert Data into the `teachers` Table**:
   - Insert the following teachers:
     - Teacher Name: `'Ms. Frizzle'`
     - Subject: `'Science'`
     - School ID: `1` *(Assuming `'Springfield High'` has `school_id = 1`)*

     ---
     
     - Teacher Name: `'Mr. Keating'`
     - Subject: `'English'`
     - School ID: `1`

     ---
     
     - Teacher Name: `'Dr. Banner'`
     - Subject: `'Math'`
     - School ID: `2` *(Assuming `'Shelbyville Academy'` has `school_id = 2`)*

3. **Insert Data into the `students` Table**:
   - Insert the following students:
     - Student Name: `'Alice'`
     - Grade Level: `10`
     - School ID: `1` *(Assuming `'Springfield High'` has `school_id = 1`)*

     ---
     
     - Student Name: `'Bob'`
     - Grade Level: `11`
     - School ID: `1`

     ---
     
     - Student Name: `'Charlie'`
     - Grade Level: `10`
     - School ID: `2` *(Assuming `'Shelbyville Academy'` has `school_id = 2`)*

     ---
     
     - Student Name: `'Ferris'`
     - Grade Level: `12`
     - School ID: `2`

4. **Insert Data into the `classes` Table**:
   - Insert the following classes:
     - Class Name: `'Biology'`
     - Final Grade: `NULL`
     - Teacher ID: `1` *(Assuming `'Ms. Frizzle'` has `teacher_id = 1`)*

     ---
     
     - Class Name: `'Literature'`
     - Final Grade: `NULL`
     - Teacher ID: `2` *(Assuming `'Mr. Keating'` has `teacher_id = 2`)*

     ---
     
     - Class Name: `'Algebra'`
     - Final Grade: `NULL`
     - Teacher ID: `3` *(Assuming `'Dr. Banner'` has `teacher_id = 3`)*

5. **Insert Data into the `class_students` Table**:
   - Enroll the following students in classes:
     - **Alice** is enrolled in **Biology**.
     - **Bob** is enrolled in **Literature**.
     - **Charlie** is enrolled in **Algebra**.
     - **Ferris** is enrolled in **Algebra**.

   **Instructions for Mapping**:
   - Determine the `student_id` for each student and the `class_id` for each class based on the data inserted above.
   - Insert the corresponding `student_id` and `class_id` pairs into the `class_students` table.

<details>
<summary>**Solution**</summary>

```sql

-- Insert Data into schools
INSERT INTO schools (school_name, address, principal) VALUES
('Springfield High', '123 Main St', 'Mr. Skinner'),
('Shelbyville Academy', '456 Elm St', 'Ms. Crabapple');

-- Insert Data into teachers
INSERT INTO teachers (teacher_name, subject, school_id) VALUES
('Ms. Frizzle', 'Science', 1),
('Mr. Keating', 'English', 1),
('Dr. Banner', 'Math', 2);

-- Insert Data into students
INSERT INTO students (student_name, grade_level, school_id) VALUES
('Alice', 10, 1),
('Bob', 11, 1),
('Charlie', 10, 2),
('Ferris', 12, 2);

-- Insert Data into classes
INSERT INTO classes (class_name, final_grade, teacher_id) VALUES
('Biology', NULL, 1),
('Literature', NULL, 2),
('Algebra', NULL, 3);

-- Insert Data into class_students
INSERT INTO class_students (student_id, class_id) VALUES
(1, 1), -- Alice in Biology
(2, 2), -- Bob in Literature
(3, 3), -- Charlie in Algebra
(4, 3); -- Ferris in Algebra
```

</details>

---

## **Task 2: Create Users and Assign Privileges**

### **Instructions**:

1. **Create four MySQL users**:
   - `db_admin`
   - `school_staff`
   - `teacher`
   - `student`

2. **Assign privileges to each user**:
   - **`db_admin`**: Full access to the `school_system` database.
   - **`school_staff`**: 
     - Can **SELECT** all columns in the `schools` table.
     - Can **UPDATE** only the `address` column in the `schools` table.
   - **`teacher`**: 
     - Can **SELECT** and **UPDATE** all columns in the `teachers` table.
     - Can **SELECT** all columns in the `classes` and `class_students` tables.
   - **`student`**: 
     - Can **SELECT** and **UPDATE** all columns in the `students` table.
     - Can **SELECT** all columns in the `classes` and `class_students` tables.

---

### **Solution**

Below are the SQL statements to create the users and assign the appropriate privileges as specified:

<details>
<summary>**Solution**</summary>

```sql
-- 1. Create Users

-- Create db_admin with full privileges
CREATE USER 'db_admin'@'localhost' IDENTIFIED BY 'adminpassword';
GRANT ALL PRIVILEGES ON school_system.* TO 'db_admin'@'localhost';
-- adds schools

-- Create school_staff with SELECT and UPDATE privileges on the address column in schools table
CREATE USER 'school_staff'@'localhost' IDENTIFIED BY 'staffpassword';
GRANT SELECT, UPDATE(address) ON school_system.schools TO 'school_staff'@'localhost';

-- school_staff can make new teachers
GRANT ALL PRIVILEGES ON school_system.teachers TO 'school_staff'@'localhost';

-- makes new classes?
GRANT ALL PRIVILEGES ON school_system.classes TO 'school_staff'@'localhost';

-- makes new stduent and puts students in classes?
GRANT ALL PRIVILEGES ON school_system.students TO 'school_staff'@'localhost';
GRANT ALL PRIVILEGES ON school_system.classes_students TO 'school_staff'@'localhost';


-- Create teacher with SELECT and UPDATE privileges on teachers table, and SELECT on classes and class_students tables
CREATE USER 'teacher'@'localhost' IDENTIFIED BY 'teacherpassword';
GRANT SELECT ON school_system.teachers TO 'teacher'@'localhost'; 
GRANT UPDATE(teacher_name) ON school_system.teachers TO 'teacher'@'localhost';  ## ***** NO ROW-LEVEL PROTECTIONS
GRANT SELECT ON school_system.classes TO 'teacher'@'localhost'; ## see all classes
GRANT SELECT ON school_system.students TO 'teacher'@'localhost'; ## see all students
GRANT SELECT ON school_system.class_students TO 'teacher'@'localhost'; ## see which students are in which classes


-- Create student with SELECT and UPDATE privileges on students table, and SELECT on classes and class_students tables
CREATE USER 'student'@'localhost' IDENTIFIED BY 'studentpassword';
GRANT SELECT ON school_system.students TO 'student'@'localhost'; ## really need full access to students table?
GRANT UPDATE(student_name) ON school_system.students TO 'student'@'localhost';  ## can update their name ***** NO ROW-LEVEL PROTECTIONS
GRANT SELECT ON school_system.classes TO 'student'@'localhost';
```

-- 2. Apply Privilege Changes
FLUSH PRIVILEGES;
```

</details>

---

### **Explanation of SQL Statements**

1. **Creating Users**:
   - **`CREATE USER`** statements create new users with specified usernames and passwords.
   - The `'localhost'` host specification restricts these users to connect only from the local machine. If remote access is required in the future, adjust the host accordingly.

2. **Assigning Privileges**:
   - **`db_admin`**:
     - **`GRANT ALL PRIVILEGES`**: Provides full access to all tables and operations within the `school_system` database.
   - **`school_staff`**:
     - **`GRANT SELECT`**: Allows viewing all columns in the `schools` table.
     - **`GRANT UPDATE(address)`**: Permits updating only the `address` column in the `schools` table.
   - **`teacher`**:
     - **`GRANT SELECT, UPDATE`** on `teachers`: Enables viewing and modifying all columns in the `teachers` table.
     - **`GRANT SELECT`** on `classes` and `class_students`: Allows viewing all columns in these tables without modification rights.
   - **`student`**:
     - **`GRANT SELECT, UPDATE`** on `students`: Enables viewing and modifying all columns in the `students` table.
     - **`GRANT SELECT`** on `classes` and `class_students`: Allows viewing all columns in these tables without modification rights.

3. **Applying Privilege Changes**:
   - **`FLUSH PRIVILEGES;`** ensures that all privilege changes take effect immediately.

---

### **Important Considerations**

1. **Column-Level Privileges**:
   - MySQL allows granting privileges on specific columns. In this case, `school_staff` is restricted to updating only the `address` column in the `schools` table while retaining the ability to select all columns.

2. **Row-Level Security Limitation**:
   - MySQL does not support row-level security natively. This means that while we can restrict column-level access, we cannot directly enforce that users like `teacher` and `student` can only update their own records using privilege statements alone.
   - **Future Enhancements**: To achieve row-level security, consider implementing **Views**, **Stored Procedures**, or **Triggers** in subsequent tasks. These mechanisms can help simulate row-level restrictions by controlling the data that users can interact with based on their identity.

3. **Security Best Practices**:
   - **Strong Passwords**: Ensure that passwords are strong and secure to prevent unauthorized access.
   - **Least Privilege Principle**: Users should be granted the minimum privileges necessary to perform their tasks. This principle is adhered to by restricting `school_staff`, `teacher`, and `student` users to only the necessary operations and columns.
   - **Regular Audits**: Periodically review and audit user privileges to maintain security and adjust permissions as needed.

---

### **Verification**

After executing the above SQL statements, you can verify the privileges assigned to each user using the following queries:

<details>
<summary>**Solution**</summary>

```sql
-- View privileges for db_admin
SHOW GRANTS FOR 'db_admin'@'localhost';

-- View privileges for school_staff
SHOW GRANTS FOR 'school_staff'@'localhost';

-- View privileges for teacher
SHOW GRANTS FOR 'teacher'@'localhost';

-- View privileges for student
SHOW GRANTS FOR 'student'@'localhost';
```

</details>

---

### **Task 3: Create Connections and Query with Each User**

**Instructions**:
1. Create a connection in MySQL Workbench for each user (`db_admin`, `school_staff`, `teacher`, `student`).
2. Write and execute queries to test their permissions:
   - `db_admin` should have unrestricted access.
   - `school_staff` can update the `address` in the `schools` table but not other columns.
   - `teacher` can update their own record and view their classes.
   - `student` can update their own record and view their enrolled classes.

<details>
<summary>**Example Queries**</summary>

```sql
-- Test for db_admin
select * from schools;
update students set grade_level = 11 where student_id = 1;

-- Test for school_staff
update schools set address = '789 New Ave' where school_id = 1; -- Success
update schools set school_name = 'New Name' where school_id = 1; -- Failure

-- Test for teacher
update teachers set subject = 'Advanced Biology' where teacher_id = 1; -- Success if logged in as Ms. Frizzle
update teachers set subject = 'Physics' where teacher_id = 2; -- Failure

-- Test for student
update students set grade_level = 12 where student_id = 2; -- Success if logged in as Bob
update students set grade_level = 11 where student_id = 1; -- Failure
```

</details>

---



## **Task 4: Practice Writing Joins**

### **Examples by User Role**

#### **1. db_admin**

**Role Overview**: The `db_admin` has full access to the `school_system` database, enabling them to perform comprehensive data analysis, system monitoring, and administrative tasks.

**Example Scenarios**:

##### **a. Generate a Report of All Teachers and Their Assigned Schools**

**Scenario**: The `db_admin` wants to create a report listing every teacher along with the name of the school they are assigned to.

**SQL Query**:
```sql
SELECT 
    t.teacher_id,
    t.teacher_name,
    t.subject,
    s.school_name,
    s.address
FROM 
    teachers t
INNER JOIN 
    schools s ON t.school_id = s.school_id;
```

##### **b. List All Classes, Including Those Without Assigned Teachers**

**Scenario**: The `db_admin` wants to identify any classes that do not currently have an assigned teacher.

**SQL Query**:
```sql
SELECT 
    c.class_id,
    c.class_name,
    t.teacher_name
FROM 
    classes c
LEFT JOIN 
    teachers t ON c.teacher_id = t.teacher_id;
```

---

#### **2. school_staff**

**Role Overview**: The `school_staff` user can view and update the `address` of schools. They may need to analyze or verify school information.

**Example Scenarios**:

##### **a. View All Schools and Their Current Addresses**

**Scenario**: The `school_staff` wants to view a list of all schools along with their addresses to verify contact information.

**SQL Query**:
```sql
SELECT 
    school_id,
    school_name,
    address
FROM 
    schools;
```

##### **b. Identify Schools with No Assigned Teachers**

**Scenario**: The `school_staff` wants to identify any schools that currently do not have any teachers assigned.

**SQL Query**:
```sql
SELECT 
    s.school_id,
    s.school_name,
    s.address
FROM 
    schools s
LEFT JOIN 
    teachers t ON s.school_id = t.school_id
WHERE 
    t.teacher_id IS NULL;
```

*Note*: While `school_staff` does not have direct access to the `teachers` table, this example assumes they have indirect access or that the query is executed by a user with broader privileges. Adjust according to actual privileges.

---

#### **3. teacher**

**Role Overview**: The `teacher` user can view and update their own record in the `teachers` table and view classes and enrolled students.

**Example Scenarios**:

##### **a. View All Classes Taught by the Logged-In Teacher Along with Enrolled Students**

**Scenario**: A teacher wants to see all the classes they are teaching and the students enrolled in each class.

**Assumption**: The teacher's `teacher_id` is known (e.g., `teacher_id = 1`).

**SQL Query**:
```sql
SELECT 
    c.class_id,
    c.class_name,
    s.student_id,
    s.student_name,
    s.grade_level
FROM 
    classes c
INNER JOIN 
    class_students cs ON c.class_id = cs.class_id
INNER JOIN 
    students s ON cs.student_id = s.student_id
WHERE 
    c.teacher_id = 1;
```

##### **b. List All Teachers Along with Their Schools**

**Scenario**: A teacher wants to view other teachers and the schools they are associated with (e.g., for collaboration purposes).

**SQL Query**:
```sql
SELECT 
    t.teacher_id,
    t.teacher_name,
    t.subject,
    s.school_name
FROM 
    teachers t
INNER JOIN 
    schools s ON t.school_id = s.school_id;
```

---

#### **4. student**

**Role Overview**: The `student` user can view and update their own record in the `students` table and view their enrolled classes.

**Example Scenarios**:

##### **a. View All Classes the Logged-In Student Is Enrolled In**

**Scenario**: A student wants to see a list of all classes they are currently enrolled in.

**Assumption**: The student's `student_id` is known (e.g., `student_id = 1`).

**SQL Query**:
```sql
SELECT 
    c.class_id,
    c.class_name,
    t.teacher_name,
    c.final_grade
FROM 
    class_students cs
INNER JOIN 
    classes c ON cs.class_id = c.class_id
INNER JOIN 
    teachers t ON c.teacher_id = t.teacher_id
WHERE 
    cs.student_id = 1;
```

##### **b. List All Students Enrolled in a Specific Class**

**Scenario**: A student wants to see who else is enrolled in one of their classes (e.g., Biology).

**Assumption**: The `class_id` for Biology is known (e.g., `class_id = 1`).

**SQL Query**:
```sql
SELECT 
    s.student_id,
    s.student_name,
    s.grade_level
FROM 
    class_students cs
INNER JOIN 
    students s ON cs.student_id = s.student_id
WHERE 
    cs.class_id = 1;
```

---

### **Additional Examples**

To further solidify understanding, here are more examples that incorporate both **INNER JOIN** and **LEFT JOIN** operations, suitable for different user roles.

#### **a. db_admin: Identify Students Without Enrollments**

**Scenario**: The `db_admin` wants to find all students who are not enrolled in any classes.

**SQL Query**:
```sql
SELECT 
    s.student_id,
    s.student_name,
    s.grade_level,
    s.school_id
FROM 
    students s
LEFT JOIN 
    class_students cs ON s.student_id = cs.student_id
WHERE 
    cs.class_id IS NULL;
```

**Explanation**:
- **LEFT JOIN** ensures all students are listed.
- The `WHERE` clause filters out students who have no entries in `class_students`, indicating no enrollments.

#### **b. teacher: View Students' Grades in Their Classes**

**Scenario**: A teacher wants to view the final grades of students in their classes.

**Assumption**: The teacher's `teacher_id` is known (e.g., `teacher_id = 1`).

**SQL Query**:
```sql
SELECT 
    s.student_id,
    s.student_name,
    s.grade_level,
    c.class_name,
    c.final_grade
FROM 
    class_students cs
INNER JOIN 
    students s ON cs.student_id = s.student_id
INNER JOIN 
    classes c ON cs.class_id = c.class_id
WHERE 
    c.teacher_id = 1;
```

**Explanation**:
- **INNER JOIN** connects `class_students`, `students`, and `classes` to retrieve relevant information.
- The `WHERE` clause ensures that only classes taught by the specific teacher are included.

#### **c. student: View Detailed Information About Enrolled Classes**

**Scenario**: A student wants detailed information about each class they are enrolled in, including the teacher's name and the school's address.

**Assumption**: The student's `student_id` is known (e.g., `student_id = 1`).

**SQL Query**:
```sql
SELECT 
    c.class_id,
    c.class_name,
    t.teacher_name,
    s.school_name,
    s.address
FROM 
    class_students cs
INNER JOIN 
    classes c ON cs.class_id = c.class_id
INNER JOIN 
    teachers t ON c.teacher_id = t.teacher_id
INNER JOIN 
    schools s ON t.school_id = s.school_id
WHERE 
    cs.student_id = 1;
```

**Explanation**:
- **INNER JOIN** operations link `class_students` with `classes`, `teachers`, and `schools` to provide comprehensive class details.
- The `WHERE` clause filters the results to the specific student.

---

### **Summary of Example Queries**

| **User Role** | **Scenario**                                           | **Join Type** | **Tables Involved**                     |
|---------------|--------------------------------------------------------|---------------|-----------------------------------------|
| db_admin      | List all teachers with their schools                   | INNER JOIN    | `teachers`, `schools`                   |
| db_admin      | Identify classes without assigned teachers             | LEFT JOIN     | `classes`, `teachers`                   |
| school_staff  | View all schools and their addresses                   | N/A           | `schools`                               |
| school_staff  | Identify schools with no assigned teachers             | LEFT JOIN     | `schools`, `teachers`                   |
| teacher       | View their classes and enrolled students               | INNER JOIN    | `classes`, `class_students`, `students` |
| teacher       | List all teachers and their schools for collaboration  | INNER JOIN    | `teachers`, `schools`                   |
| student       | View enrolled classes and associated teachers          | INNER JOIN    | `class_students`, `classes`, `teachers` |
| student       | List all students in a specific class                  | INNER JOIN    | `class_students`, `students`            |
| db_admin      | Identify students without any class enrollments        | LEFT JOIN     | `students`, `class_students`            |
| teacher       | View students' grades in their classes                 | INNER JOIN    | `class_students`, `students`, `classes` |
| student       | View detailed class information including school details| INNER JOIN    | `class_students`, `classes`, `teachers`, `schools` |

---

### **Practical Tips for Students**

1. **Understand the Relationships**:
   - Before writing a join query, clearly understand how tables are related through primary and foreign keys.
   
2. **Alias Tables for Clarity**:
   - Use table aliases (e.g., `t` for `teachers`) to make queries more readable.
   
3. **Use `WHERE` Clauses Effectively**:
   - Apply `WHERE` clauses to filter results based on specific criteria, such as `teacher_id` or `student_id`.
   
4. **Check for `NULL` Values in Outer Joins**:
   - When using `LEFT JOIN` or `RIGHT JOIN`, remember that unmatched records will have `NULL` values in the columns from the joined table.
   
5. **Test Incrementally**:
   - Build your queries step-by-step, verifying each join and condition to ensure accuracy.

6. **Review and Optimize Queries**:
   - After writing a query, review it for efficiency and ensure it retrieves only the necessary data.

---

### **Exercises for Students**

To reinforce the concepts, here are some exercises based on the examples provided:

1. **Exercise 1**: As a `db_admin`, write a query to list all students along with the names of the teachers for the classes they are enrolled in.

2. **Exercise 2**: As a `teacher`, create a query to find all classes that do not have any enrolled students.

3. **Exercise 3**: As a `student`, write a query to view all teachers along with the subjects they teach, even if they are not teaching any classes currently.

4. **Exercise 4**: As a `db_admin`, generate a list of all schools and the number of teachers assigned to each school.

---

### **Sample Solutions to Exercises**

<details>
<summary>**Solution to Exercise 1**</summary>

```sql
SELECT 
    s.student_name,
    t.teacher_name,
    c.class_name
FROM 
    class_students cs
INNER JOIN 
    students s ON cs.student_id = s.student_id
INNER JOIN 
    classes c ON cs.class_id = c.class_id
INNER JOIN 
    teachers t ON c.teacher_id = t.teacher_id;
```

</details>


<details>
<summary>**Solution to Exercise 2**</summary>

```sql
SELECT 
    c.class_id,
    c.class_name
FROM 
    classes c
LEFT JOIN 
    class_students cs ON c.class_id = cs.class_id
WHERE 
    cs.class_id IS NULL;
```

</details>

<details>
<summary>**Solution to Exercise 3**</summary>

```sql
SELECT 
    t.teacher_name,
    t.subject
FROM 
    teachers t
LEFT JOIN 
    classes c ON t.teacher_id = c.teacher_id;
```

</details>


<details>
<summary>**Solution to Exercise 4**</summary>

```sql
SELECT 
    s.school_name,
    COUNT(t.teacher_id) AS number_of_teachers
FROM 
    schools s
LEFT JOIN 
    teachers t ON s.school_id = t.school_id
GROUP BY 
    s.school_id, s.school_name;
```

</details>

