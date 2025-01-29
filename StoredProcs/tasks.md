Here’s a structured set of tasks simulating a **real-world project** using **stored procedures in MySQL** with the **Employees Sample Database**. These tasks will help students practice creating, altering, and dropping stored procedures while working with multiple parameters, using `LAST_INSERT_ID()`, and handling errors.

---

## **Project Title: Employee Management Automation**
**Scenario:**  
You are a MySQL developer in a company that maintains an **Employee Management System** using MySQL’s **sample `employees` database**. The company wants to automate key operations using stored procedures.

---

## **Task 1: Create a Stored Procedure to Add a New Employee**
### **Business Requirement:**  
HR frequently adds new employees to the system. Create a stored procedure that takes the employee's **first name, last name, gender, and hire date** as parameters and inserts the new employee into the `employees` table. Return the **newly generated `emp_no`**.

<details>
<summary>Solution</summary>

```sql
DELIMITER //

CREATE PROCEDURE AddEmployee(
    IN p_first_name VARCHAR(14),
    IN p_last_name VARCHAR(16),
    IN p_gender ENUM('M', 'F'),
    IN p_hire_date DATE,
    OUT p_emp_no INT
)
BEGIN
    INSERT INTO employees (birth_date, first_name, last_name, gender, hire_date)
    VALUES (DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 40 + 20) YEAR), p_first_name, p_last_name, p_gender, p_hire_date);

    SET p_emp_no = LAST_INSERT_ID();
END //

DELIMITER ;
```

</details>

---

## **Task 2: Assign a Salary to a Newly Created Employee**
### **Business Requirement:**  
Once a new employee is created, they need a **starting salary**. Create a stored procedure that accepts the **employee ID, salary amount, and start date**, and inserts a record into the `salaries` table.

<details>
<summary>Solution</summary>

```sql
DELIMITER //

CREATE PROCEDURE AssignSalary(
    IN p_emp_no INT,
    IN p_salary INT,
    IN p_from_date DATE
)
BEGIN
    INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (p_emp_no, p_salary, p_from_date, '9999-01-01');
END //

DELIMITER ;
```

</details>

---

## **Task 3: Update an Employee's Salary**
### **Business Requirement:**  
If an employee gets a **salary raise**, update their salary in the `salaries` table. The old salary record should have `to_date` set to **the day before the new salary starts**, and a new salary record should be inserted.

<details>
<summary>Solution</summary>

```sql
DELIMITER //

CREATE PROCEDURE UpdateSalary(
    IN p_emp_no INT,
    IN p_new_salary INT,
    IN p_effective_date DATE
)
BEGIN
    -- Update current salary record
    UPDATE salaries
    SET to_date = DATE_SUB(p_effective_date, INTERVAL 1 DAY)
    WHERE emp_no = p_emp_no AND to_date = '9999-01-01';

    -- Insert new salary record
    INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (p_emp_no, p_new_salary, p_effective_date, '9999-01-01');
END //

DELIMITER ;
```

</details>

---

## **Task 4: Assign an Employee to a Department**
### **Business Requirement:**  
Every employee must be assigned to a department. Create a stored procedure that **links an employee to a department**, using the `dept_emp` table.

<details>
<summary>Solution</summary>

```sql
DELIMITER //

CREATE PROCEDURE AssignDepartment(
    IN p_emp_no INT,
    IN p_dept_no CHAR(4),
    IN p_from_date DATE
)
BEGIN
    INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
    VALUES (p_emp_no, p_dept_no, p_from_date, '9999-01-01');
END //

DELIMITER ;
```

</details>

---

## **Task 5: Transfer an Employee to a New Department**
### **Business Requirement:**  
If an employee **transfers to a different department**, update the existing record and create a new one.

<details>
<summary>Solution</summary>

```sql
DELIMITER //

CREATE PROCEDURE TransferEmployee(
    IN p_emp_no INT,
    IN p_new_dept_no CHAR(4),
    IN p_transfer_date DATE
)
BEGIN
    -- Update the current department record
    UPDATE dept_emp
    SET to_date = DATE_SUB(p_transfer_date, INTERVAL 1 DAY)
    WHERE emp_no = p_emp_no AND to_date = '9999-01-01';

    -- Insert new department record
    INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
    VALUES (p_emp_no, p_new_dept_no, p_transfer_date, '9999-01-01');
END //

DELIMITER ;
```

</details>

---

## **Task 6: Drop a Stored Procedure**
### **Business Requirement:**  
HR no longer uses the `AssignSalary` procedure. Drop it.

<details>
<summary>Solution</summary>

```sql
DROP PROCEDURE IF EXISTS AssignSalary;
```

</details>

---

## **Task 7: Modify a Stored Procedure (Increase Salary by Percentage)**
### **Business Requirement:**  
HR wants an **automated salary increment** feature. Modify the `UpdateSalary` procedure to increase the **current salary by a percentage** instead of setting a fixed amount.

<details>
<summary>Solution</summary>

```sql
DELIMITER //

CREATE PROCEDURE IncreaseSalaryByPercentage(
    IN p_emp_no INT,
    IN p_percentage DECIMAL(5,2),
    IN p_effective_date DATE
)
BEGIN
    DECLARE v_old_salary INT;
    
    -- Get the employee's current salary
    SELECT salary INTO v_old_salary 
    FROM salaries
    WHERE emp_no = p_emp_no AND to_date = '9999-01-01'
    ORDER BY from_date DESC
    LIMIT 1;
    
    -- Compute new salary
    SET v_old_salary = v_old_salary * (1 + p_percentage / 100);

    -- Update current salary record
    UPDATE salaries
    SET to_date = DATE_SUB(p_effective_date, INTERVAL 1 DAY)
    WHERE emp_no = p_emp_no AND to_date = '9999-01-01';

    -- Insert new salary record
    INSERT INTO salaries (emp_no, salary, from_date, to_date)
    VALUES (p_emp_no, v_old_salary, p_effective_date, '9999-01-01');
END //

DELIMITER ;
```

</details>

---

## **Task 8: Implement Error Handling in a Stored Procedure**
### **Business Requirement:**  
Create a stored procedure that **adds an employee only if the department exists**. Use error handling to **raise an error if the department does not exist**.

<details>
<summary>Solution</summary>

```sql
DELIMITER //

CREATE PROCEDURE SafeAddEmployee(
    IN p_first_name VARCHAR(14),
    IN p_last_name VARCHAR(16),
    IN p_gender ENUM('M', 'F'),
    IN p_hire_date DATE,
    IN p_dept_no CHAR(4)
)
BEGIN
    DECLARE v_dept_count INT;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET v_dept_count = 0;

    -- Check if department exists
    SELECT COUNT(*) INTO v_dept_count FROM departments WHERE dept_no = p_dept_no;

    -- If department does not exist, signal an error
    IF v_dept_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Department does not exist!';
    ELSE
        -- Insert the employee
        INSERT INTO employees (birth_date, first_name, last_name, gender, hire_date)
        VALUES (DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 40 + 20) YEAR), p_first_name, p_last_name, p_gender, p_hire_date);
    END IF;
END //

DELIMITER ;
```

</details>

---

## **Next Steps:**
- Test the stored procedures using `CALL ProcedureName()`.
- Try altering the procedures to add more functionality.
- Use transactions inside procedures for complex operations.

This provides a **practical, real-world approach** to mastering **stored procedures** in MySQL! 🚀