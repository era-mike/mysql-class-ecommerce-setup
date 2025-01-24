


#### **Step 1: Non-Normalized Data**
| OrderID | CustomerName | CustomerAddress | Products                  | TotalPrice |
|---------|--------------|-----------------|---------------------------|------------|
| 1       | Alice        | 123 Apple St    | Widget A, Widget B        | 40.00      |
| 2       | Bob          | 456 Orange St   | Widget C                  | 20.00      |
| 3       | Alice        | 123 Apple St    | Widget A, Widget D, Widget E | 65.00  |

- **Issues:**
  - The **Products** column contains multiple values (non-atomic data).
  - Calculating or analyzing individual product sales is difficult since they are not broken into rows.
  - Updating prices for individual products is cumbersome, as they are embedded in a string.

---

#### **Step 2: First Normal Form (1NF)**
- Break down non-atomic columns into atomic values and eliminate repeating groups.

**1NF Data:**
| OrderID | CustomerName | CustomerAddress | Product     | ProductPrice |
|---------|--------------|-----------------|-------------|--------------|
| 1       | Alice        | 123 Apple St    | Widget A    | 25.00        |
| 1       | Alice        | 123 Apple St    | Widget B    | 15.00        |
| 2       | Bob          | 456 Orange St   | Widget C    | 20.00        |
| 3       | Alice        | 123 Apple St    | Widget A    | 25.00        |
| 3       | Alice        | 123 Apple St    | Widget D    | 20.00        |
| 3       | Alice        | 123 Apple St    | Widget E    | 20.00        |

- **Changes Made:**
  - Each product is represented in a separate row.
  - Atomic values achieved; no repeating groups or multi-value fields.

- **CRUD Challenges:**
  - Redundant customer details (name and address) repeated across rows for each product.
  - Updates to customer information require changes in multiple rows.

---

#### **Step 3: Second Normal Form (2NF)**
- Remove partial dependencies by splitting data into separate tables. Ensure non-key attributes depend entirely on the primary key.

**Orders Table:**
| OrderID | CustomerID |
|---------|------------|
| 1       | C001       |
| 2       | C002       |
| 3       | C001       |

**Customers Table:**
| CustomerID | CustomerName | CustomerAddress |
|------------|--------------|-----------------|
| C001       | Alice        | 123 Apple St    |
| C002       | Bob          | 456 Orange St   |

**OrderDetails Table:**
| OrderID | Product     | ProductPrice |
|---------|-------------|--------------|
| 1       | Widget A    | 25.00        |
| 1       | Widget B    | 15.00        |
| 2       | Widget C    | 20.00        |
| 3       | Widget A    | 25.00        |
| 3       | Widget D    | 20.00        |
| 3       | Widget E    | 20.00        |

- **Changes Made:**
  - Separated customers into their own table, linked to orders by `CustomerID`.
  - Order details (products and prices) moved to a separate table.

- **CRUD Challenges:**
  - Updating product prices still requires changes in multiple rows (e.g., Widget A price appears twice).
  - Improved efficiency for customer updates, but still some redundancy in product prices.

---

#### **Step 4: Third Normal Form (3NF)**
- Eliminate transitive dependencies by creating a separate table for products.

**Orders Table:** *(Same as 2NF)*

**Customers Table:** *(Same as 2NF)*

**OrderDetails Table:**
| OrderID | ProductID |
|---------|-----------|
| 1       | 101       |
| 1       | 102       |
| 2       | 103       |
| 3       | 101       |
| 3       | 104       |
| 3       | 105       |

**Products Table:**
| ProductID | ProductName | ProductPrice |
|-----------|-------------|--------------|
| 101       | Widget A    | 25.00        |
| 102       | Widget B    | 15.00        |
| 103       | Widget C    | 20.00        |
| 104       | Widget D    | 20.00        |
| 105       | Widget E    | 20.00        |

- **Changes Made:**
  - Products moved to their own table to remove price redundancy.
  - OrderDetails now references ProductID.

- **CRUD Advantages:**
  - **Create:** Adding new products does not involve duplicate entries.
  - **Read:** Easy to join tables and retrieve complete order details.
  - **Update:** Updating product prices requires changing only one row in the `Products` table.
  - **Delete:** Deleting a product or customer does not affect unrelated data.

---

### **Key Takeaways**
- **1NF:** Focuses on atomicity and eliminating repeating groups.
- **2NF:** Removes partial dependencies by organizing data into separate entities.
- **3NF:** Eliminates transitive dependencies to minimize redundancy further.




Let's break down the explanation further and make each step of the transitive dependency concept clear with detailed examples and simpler explanations.

---

### The Original Table
| **EmployeeID** | **EmployeeName** | **DepartmentID** | **DepartmentName** |
|-----------------|------------------|------------------|--------------------|
| 1               | Alice            | D01              | HR                 |
| 2               | Bob              | D02              | IT                 |

---

### 1. **Understanding the Primary Key (`EmployeeID`)**
- The **primary key** is `EmployeeID`, which uniquely identifies each row in the table.
  - For example:
    - `EmployeeID = 1` always represents Alice.
    - `EmployeeID = 2` always represents Bob.

### 2. **Understanding Functional Dependency**
Functional dependency means that one attribute determines another. Let’s explore the dependencies step by step.

---

#### a) **`EmployeeID → DepartmentID`**
- This means that the value of `DepartmentID` is determined by `EmployeeID`.
- In this table:
  - Alice (`EmployeeID = 1`) is in the department with `DepartmentID = D01`.
  - Bob (`EmployeeID = 2`) is in the department with `DepartmentID = D02`.
- **Key point**: If you know an employee's `EmployeeID`, you can determine their `DepartmentID`. This is what we mean when we say "`DepartmentID` is functionally dependent on `EmployeeID`."

---

#### b) **`DepartmentID → DepartmentName`**
- This means that the `DepartmentName` is determined by the `DepartmentID`.
- For example:
  - `DepartmentID = D01` always corresponds to `DepartmentName = HR`.
  - `DepartmentID = D02` always corresponds to `DepartmentName = IT`.
- **Key point**: The `DepartmentID` determines the `DepartmentName`. There is no ambiguity.

---

#### c) **`EmployeeID → DepartmentName` (Indirect or Transitive Dependency)**
- This is the result of the two previous dependencies:
  1. If you know `EmployeeID`, you can find `DepartmentID`.
  2. If you know `DepartmentID`, you can find `DepartmentName`.
- Therefore:
  - `EmployeeID → DepartmentName` is **indirect** because it depends on `EmployeeID` passing through `DepartmentID`.

This indirect dependency creates a **transitive dependency**, which violates **3NF**.

---

### Why the Transitive Dependency is a Problem
- **Redundancy**:
  - If multiple employees belong to the same department, the department's name (`DepartmentName`) is repeated unnecessarily.
  - For example:
    | **EmployeeID** | **EmployeeName** | **DepartmentID** | **DepartmentName** |
    |-----------------|------------------|------------------|--------------------|
    | 1               | Alice            | D01              | HR                 |
    | 3               | Charlie          | D01              | HR                 |
  - `HR` is stored twice, which wastes space.
- **Update Anomalies**:
  - If the department name changes (e.g., `HR` becomes `Human Resources`), you would need to update every row where `DepartmentID = D01`.
  - If you forget to update one row, the data becomes inconsistent.
- **Delete Anomalies**:
  - If all employees in a department are deleted, you lose the information about the department (e.g., `D01 → HR`).

---

### How to Fix the Transitive Dependency
To resolve the transitive dependency, we break the table into two tables. This ensures that:
1. Every non-key column depends **directly** on the primary key in its table.
2. There are no indirect (transitive) dependencies.

#### Split into Two Tables:

##### Table 1: Employee Table
| **EmployeeID** | **EmployeeName** | **DepartmentID** |
|-----------------|------------------|------------------|
| 1               | Alice            | D01              |
| 2               | Bob              | D02              |

- **Explanation**:
  - `DepartmentID` depends directly on `EmployeeID` (no transitive dependency here).
  - `EmployeeName` also depends directly on `EmployeeID`.

##### Table 2: Department Table
| **DepartmentID** | **DepartmentName** |
|------------------|--------------------|
| D01              | HR                 |
| D02              | IT                 |

- **Explanation**:
  - `DepartmentName` now depends **directly** on `DepartmentID`, which is the primary key of this table.

---

### Benefits of Fixing the Transitive Dependency
1. **Eliminates Redundancy**:
   - Each department name (`HR`, `IT`) is stored only once in the `Department` table.
2. **Prevents Anomalies**:
   - Updating or deleting department details affects only the `Department` table, not multiple rows in the `Employee` table.
3. **Follows 3NF**:
   - Every non-key attribute in both tables depends directly on the primary key of its table.

By splitting the table, we achieve a cleaner, more efficient database design while avoiding the pitfalls of transitive dependencies.