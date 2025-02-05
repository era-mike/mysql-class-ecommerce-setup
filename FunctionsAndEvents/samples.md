## **Project: Employee Data Management Automation**
**Scenario:**  
You are the **lead developer** on a project to automate certain tasks in the **employees database**. Your team needs to implement **triggers** and **events** to maintain data integrity, enforce business rules, and automate repetitive tasks.

### **Task 1: Automatically Update Employee Titles on Promotion**
When an employee receives a promotion (i.e., a **new row** is inserted into the `titles` table), the system should **update the old title’s `to_date` field** to mark it as **inactive**.

**Solution**
<details>
<summary>Click to view solution</summary>

```sql
delimiter //

create trigger update_old_title
before insert on titles
for each row
begin
    update titles
    set to_date = curdate()
    where emp_no = new.emp_no
    and to_date = '9999-01-01';
end //

delimiter ;
```

</details>

---

### **Task 2: Maintain a Log of Employee Salary Changes**
Every time an employee's salary is **updated** in the `salaries` table, a record of the **old salary** should be stored in a `salary_changes_log` table.

**Solution**
<details>
<summary>Click to view solution</summary>

```sql
create table salary_changes_log (
    id int auto_increment primary key,
    emp_no int,
    old_salary int,
    new_salary int,
    change_date timestamp default current_timestamp
);

delimiter //

create trigger log_salary_changes
before update on salaries
for each row
begin
    insert into salary_changes_log (emp_no, old_salary, new_salary)
    values (old.emp_no, old.salary, new.salary);
end //

delimiter ;
```

</details>

---

### **Task 3: Automatically Assign a Default Department to New Employees**
When a **new employee** is added to the `employees` table, they should be **automatically assigned to the "Unassigned" department** (`dept_no = 'd009'`).

**Solution**
<details>
<summary>Click to view solution</summary>

```sql
delimiter //

create trigger assign_default_department
after insert on employees
for each row
begin
    insert into dept_emp (emp_no, dept_no, from_date, to_date)
    values (new.emp_no, 'd009', curdate(), '9999-01-01');
end //

delimiter ;
```

</details>

---

### **Task 4: Ensure That No Two Employees Have the Same Salary**
If a **new salary** is being inserted that is **already assigned to another employee**, prevent the insert.

**Solution**
<details>
<summary>Click to view solution</summary>

```sql
delimiter //

create trigger prevent_duplicate_salary
before insert on salaries
for each row
begin
    if exists (
        select 1 from salaries where salary = new.salary
    ) then
        signal sqlstate '45000'
        set message_text = 'Salary already exists for another employee';
    end if;
end //

delimiter ;
```

</details>

---

### **Task 5: Generate a Monthly Report of Employees Without Departments**
A **scheduled event** should run on the **1st of every month** to find employees who are not assigned to any department and log them into a table called `unassigned_employees_log`.

**Solution**
<details>
<summary>Click to view solution</summary>

```sql
create table unassigned_employees_log (
    emp_no int,
    log_date timestamp default current_timestamp
);

delimiter //

create event log_unassigned_employees
on schedule every 1 month
starts timestamp(curdate(), '00:00:00')
do
begin
    insert into unassigned_employees_log (emp_no)
    select e.emp_no
    from employees e
    left join dept_emp d on e.emp_no = d.emp_no
    where d.emp_no is null;
end //

delimiter ;
```

</details>

---

### **Task 6: Delete Old Salary Records After 10 Years**
A scheduled **event** should automatically delete salary records that are **older than 10 years**.

**Solution**
<details>
<summary>Click to view solution</summary>

```sql
delimiter //

create event delete_old_salaries
on schedule every 1 year
do
begin
    delete from salaries
    where to_date < date_sub(curdate(), interval 10 year);
end //

delimiter ;
```

</details>

---

### **Task 7: List Employees Who Earn More Than Their Managers**
Find employees whose salary is **higher than their direct manager’s salary**.

**Solution**
<details>
<summary>Click to view solution</summary>

```sql
select e.emp_no, e.first_name, e.last_name, s.salary as emp_salary, m.salary as manager_salary
from employees e
join salaries s on e.emp_no = s.emp_no
join dept_emp de on e.emp_no = de.emp_no
join dept_manager dm on de.dept_no = dm.dept_no
join salaries m on dm.emp_no = m.emp_no
where s.salary > m.salary
and s.to_date = '9999-01-01'
and m.to_date = '9999-01-01';
```

</details>

---

### **Task 8: Identify Employees Without a Manager**
List all employees **who do not have an assigned manager** in the `dept_manager` table.

**Solution**
<details>
<summary>Click to view solution</summary>

```sql
select e.emp_no, e.first_name, e.last_name
from employees e
left join dept_emp de on e.emp_no = de.emp_no
left join dept_manager dm on de.dept_no = dm.dept_no
where dm.emp_no is null;
```

</details>

---

### **Task 9: Find Employees Who Have Changed Departments More Than Twice**
Identify employees who have been **assigned to more than two departments** over time.

**Solution**
<details>
<summary>Click to view solution</summary>

```sql
select emp_no, count(distinct dept_no) as dept_count
from dept_emp
group by emp_no
having dept_count > 2;
```

</details>

---

### **Task 10: Find Employees Who Have a Salary Below the Average of Their Department**
List employees earning **less than the average salary of their department**.

**Solution**
<details>
<summary>Click to view solution</summary>

```sql
select e.emp_no, e.first_name, e.last_name, s.salary, avg_salaries.avg_salary
from employees e
join salaries s on e.emp_no = s.emp_no
join dept_emp de on e.emp_no = de.emp_no
join (
    select de.dept_no, avg(s.salary) as avg_salary
    from salaries s
    join dept_emp de on s.emp_no = de.emp_no
    where s.to_date = '9999-01-01'
    group by de.dept_no
) as avg_salaries on de.dept_no = avg_salaries.dept_no
where s.salary < avg_salaries.avg_salary
and s.to_date = '9999-01-01';
```

</details>
