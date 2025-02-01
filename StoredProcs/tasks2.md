1. **Basic SELECT Procedure**  
   *Task:*  
   Create a stored procedure named `sp_get_employee_by_emp_no` that accepts an input parameter for an employee number (`emp_no`) and returns the corresponding employee's details (e.g., first name, last name, gender, hire date) from the `employees` table.  
   *Hints:*  
   - Use a simple `SELECT` statement with a `WHERE` clause filtering on `emp_no`.  
   - Test the procedure by calling it with a known `emp_no`.

   ```sql
    delimiter $$

    create procedure sp_get_employee_by_emp_no(
    in p_emp_no int
    )
    begin
    select emp_no, first_name, last_name, gender, hire_date
    from employees
    where emp_no = p_emp_no;
    end$$

    delimiter ;

    call sp_get_employee_by_emp_no(10003);
```

2. **Procedure with Multiple Parameters and Joins**  
   *Task:*  
   Create a stored procedure named `sp_get_employees_by_department` that takes a department number (`dept_no`) as input and returns a list of employees working in that department. Join the `dept_emp` table with the `employees` table to retrieve employee details.  
   *Hints:*  
   - Use an `INNER JOIN` to link `dept_emp` and `employees` on `emp_no`.  
   - Ensure the procedure handles cases where there are no employees in the specified department.

3. **Update Operation within a Procedure**  
   *Task:*  
   Create a stored procedure named `sp_update_current_salary` that accepts two parameters: an employee number (`emp_no`) and a salary increment (a numeric value). The procedure should update the employee's current salary in the `salaries` table by adding the given increment.  
   *Hints:*  
   - Assume the current salary row is identified by a `to_date` value of `'9999-01-01'`.  
   - Include basic error handling to check if the employee exists and if a current salary record is found before performing the update.

4. **Aggregated Data Using Joins**  
   *Task:*  
   Create a stored procedure named `sp_avg_salary_by_dept` that accepts a department number (`dept_no`) and calculates the average current salary of employees in that department. Return the average salary as part of the result set.  
   *Hints:*  
   - Join the `dept_emp` and `salaries` tables (filtering for the current salary using `to_date = '9999-01-01'`).  
   - Use an aggregate function (`AVG()`) to calculate the average.

5. **Using Cursors and Error Handling**  
   *Task:*  
   Create a stored procedure named `sp_highest_salary_by_department` that iterates over all departments and, for each department, finds the highest current salary among its employees. For each department, insert a record (department number and highest salary) into a temporary table.  
   *Hints:*  
   - Use a cursor to loop through the list of departments from the `departments` table.  
   - Within the loop, use a subquery (or a joined query) to determine the highest salary from the `salaries` table (again, filtering for current salary).  
   - Include proper error handling and ensure that the cursor is closed and deallocated after use.

