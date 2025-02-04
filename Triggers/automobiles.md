# **🚗 Automobile Maintenance Database Tasks**
This project is intended to develop a relational database system for managing **vehicles, maintenance schedules, and service records**. The goal is to automate maintenance tracking using **triggers**, as well as reinforce knowledge of **joins** and **complex queries**.

---

## **Task 1: Create the Database and Core Tables**
📌 **Task:** Design and create a relational database schema that includes the following tables:
1. `vehicles` - Stores vehicle details.
2. `maintenance_records` - Logs service history for each vehicle.
3. `service_types` - Defines different types of maintenance services.
4. `maintenance_schedule` - Specifies maintenance intervals based on mileage.


# **Project Specifications: Automobile Maintenance Database**  
**Developer Instructions:** Below are the tables you need to create, including the required fields, data types, and relationships. Ensure that all relationships between tables are properly enforced.

---

## **1️⃣ Vehicles Table**  
Stores details about each vehicle in the system.  

- **Fields:**
  - **Vehicle ID** – Unique identifier for each vehicle (auto-incrementing number).  
  - **Make** – The manufacturer of the vehicle (string, up to 50 characters).  
  - **Model** – The specific model of the vehicle (string, up to 50 characters).  
  - **Year** – The year the vehicle was manufactured (4-digit number).  
  - **Mileage** – The total miles/kilometers the vehicle has traveled (whole number).  
  - **VIN (Vehicle Identification Number)** – A globally unique identifier for the vehicle (string, exactly 17 characters, must be unique).  

- **Relationships:**  
  - The **Vehicle ID** is referenced by the **Maintenance Records** and **Maintenance Schedule** tables.  

---

## **2️⃣ Service Types Table**  
Defines the different types of vehicle maintenance services that can be performed.  

- **Fields:**
  - **Service ID** – Unique identifier for each service type (auto-incrementing number).  
  - **Service Name** – Name of the service (e.g., Oil Change, Tire Rotation) (string, up to 100 characters).  
  - **Description** – Additional details about the service (text, no fixed length).  

- **Relationships:**  
  - The **Service ID** is referenced by the **Maintenance Records** and **Maintenance Schedule** tables.  

---

## **3️⃣ Maintenance Records Table**  
Logs maintenance activities performed on each vehicle.  

- **Fields:**
  - **Record ID** – Unique identifier for each maintenance record (auto-incrementing number).  
  - **Vehicle ID** – The vehicle that received maintenance (references the **Vehicles Table**).  
  - **Service ID** – The type of maintenance performed (references the **Service Types Table**).  
  - **Service Date** – The date the maintenance was completed (date format).  
  - **Mileage at Service** – The vehicle's mileage at the time of maintenance (whole number).  
  - **Notes** – Any additional comments or details about the maintenance performed (text, no fixed length).  

- **Relationships:**  
  - The **Vehicle ID** links to the **Vehicles Table**.  
  - The **Service ID** links to the **Service Types Table**.  

---

## **4️⃣ Maintenance Schedule Table**  
Tracks upcoming maintenance needs based on mileage intervals.  

- **Fields:**
  - **Schedule ID** – Unique identifier for each scheduled maintenance (auto-incrementing number).  
  - **Vehicle ID** – The vehicle that requires maintenance (references the **Vehicles Table**).  
  - **Service ID** – The type of maintenance that is due (references the **Service Types Table**).  
  - **Due Mileage** – The mileage at which the maintenance should be performed (whole number).  
  - **Status** – Indicates whether the maintenance is "Pending" or "Completed" (fixed set of values).  

- **Relationships:**  
  - The **Vehicle ID** links to the **Vehicles Table**.  
  - The **Service ID** links to the **Service Types Table**.  

---

### **Additional Notes for Development:**
- Ensure all primary keys are unique and auto-incrementing where necessary.  
- Enforce foreign key relationships so that maintenance records and schedules cannot exist without valid vehicles and services.  
- The **VIN** field in the **Vehicles Table** should be strictly 17 characters and must be unique.  
- The **Status** field in the **Maintenance Schedule Table** should only allow predefined values ("Pending", "Completed").  
- The system should trigger **new maintenance schedule entries** automatically when maintenance is performed (e.g., if an oil change is done at 30,000 miles, schedule the next one at 40,000 miles).  

---

This structure provides a **clear, maintainable** relational database model for tracking automobile maintenance. Let me know if you need any modifications! 🚀

<details>
<summary>💡 Solution (Click to expand)</summary>

```sql
-- Create the database
create database automobile_maintenance;
use automobile_maintenance;

-- Vehicles table
create table vehicles (
    vehicle_id int auto_increment primary key,
    make varchar(50) not null,
    model varchar(50) not null,
    year int not null,
    mileage int not null,
    vin varchar(17) unique not null
);

-- Service types table
create table service_types (
    service_id int auto_increment primary key,
    service_name varchar(100) not null,
    description text
);

-- Maintenance records table
create table maintenance_records (
    record_id int auto_increment primary key,
    vehicle_id int not null,
    service_id int not null,
    service_date date not null,
    mileage_at_service int not null,
    notes text,
    foreign key (vehicle_id) references vehicles(vehicle_id),
    foreign key (service_id) references service_types(service_id)
);

-- Maintenance schedule table
create table maintenance_schedule (
    schedule_id int auto_increment primary key,
    vehicle_id int not null,
    service_id int not null,
    due_mileage int not null,
    status enum('pending', 'completed') default 'pending',
    foreign key (vehicle_id) references vehicles(vehicle_id),
    foreign key (service_id) references service_types(service_id)
);
```
</details>

---

## **Task 2: Insert Sample Data**
📌 **Task:** Insert **sample vehicles, maintenance records, and service types**.

<details>
<summary>💡 Solution (Click to expand)</summary>

```sql
-- Insert sample vehicles
insert into vehicles (make, model, year, mileage, vin) values
('Toyota', 'Camry', 2018, 35000, '1HGCM82633A004352'),
('Ford', 'F-150', 2020, 15000, '1FTFW1E55LFB90565'),
('Honda', 'Civic', 2017, 60000, '2HGFA16558H318962'),
('Chevrolet', 'Silverado', 2019, 45000, '3GCPKSE74BG171234'),
('Nissan', 'Altima', 2021, 20000, '1N4BL4EV2KC197632'),
('Tesla', 'Model 3', 2022, 12000, '5YJ3E1EA4KF467829'),
('BMW', 'X5', 2016, 75000, 'WBAVC53587AZ41238'),
('Mercedes', 'C-Class', 2015, 90000, 'WDDGF81X38F145678'),
('Subaru', 'Outback', 2018, 55000, '4S4BRCAC9F3287214'),
('Jeep', 'Wrangler', 2023, 8000, '1C4HJXDN4MW846732'),
('Hyundai', 'Tucson', 2019, 30000, 'KM8J3CA46HU266789'),
('Kia', 'Sorento', 2020, 22000, '5XYPGDA50KG634512'),
('Volkswagen', 'Jetta', 2017, 58000, '3VW167AJ1HM046215'),
('Mazda', 'CX-5', 2021, 18000, 'JM3KFBCM1M1468923'),
('Lexus', 'RX 350', 2015, 82000, '2T2GK31U98C072358'),
('Chevrolet', 'Malibu', 2016, 69000, '1G1ZD5ST7GF289347'),
('Ford', 'Escape', 2019, 34000, '1FMCU9HD2KUB05627'),
('Ram', '1500', 2020, 29000, '1C6RR7GT0LS124539'),
('Dodge', 'Charger', 2018, 41000, '2C3CDXHG8JH255894'),
('Acura', 'MDX', 2017, 54000, '5FRYD3H59GB057138'),
('GMC', 'Sierra 1500', 2022, 10000, '1GTU9DED5NZ531678'),
('Audi', 'A4', 2016, 71000, 'WAUDF68E85A403742'),
('Honda', 'Pilot', 2021, 25000, '5FNYF6H93LB034279'),
('Toyota', 'Corolla', 2020, 28000, '2T1BURHE1KC241874'),
('Subaru', 'Forester', 2019, 47000, 'JF2SJAGC4KH456392');

insert into service_types (service_name, description) values
('Oil Change', 'Routine engine oil change'),
('Tire Rotation', 'Rotating tires to ensure even wear'),
('Brake Inspection', 'Inspection of brake pads and discs'),
('Battery Replacement', 'Replacing the vehicle battery'),
('Transmission Fluid Change', 'Routine transmission fluid replacement'),
('Alignment Check', 'Checking and correcting wheel alignment'),
('Coolant Flush', 'Flushing and replacing engine coolant'),
('Air Filter Replacement', 'Replacing engine air filter'),
('Timing Belt Replacement', 'Replacing timing belt for maintenance'),
('Spark Plug Replacement', 'Replacing spark plugs for optimal performance');


-- Insert sample maintenance records
insert into maintenance_records (vehicle_id, service_id, service_date, mileage_at_service, notes) values
(1, 1, '2024-01-10', 30000, 'Synthetic oil used'),
(1, 2, '2024-01-15', 32000, 'Rotated all tires, balanced wheels'),
(2, 3, '2024-02-05', 14000, 'Brake pads replaced'),
(3, 4, '2023-11-10', 55000, 'New battery installed'),
(4, 5, '2023-09-15', 40000, 'Transmission fluid changed'),
(5, 6, '2023-12-20', 18000, 'Alignment adjusted'),
(6, 7, '2024-01-05', 10000, 'Coolant system flushed'),
(7, 8, '2024-01-28', 72000, 'Air filter replaced'),
(8, 9, '2023-11-22', 85000, 'Timing belt replaced'),
(9, 10, '2024-01-30', 52000, 'Spark plugs replaced'),
(10, 1, '2024-02-05', 6000, 'Oil changed early due to long trip'),
(11, 2, '2024-02-10', 27000, 'Rotated tires'),
(12, 3, '2024-02-12', 20000, 'Brake inspection - no issues found'),
(13, 4, '2023-08-20', 48000, 'Battery replaced before failure'),
(14, 5, '2023-10-10', 23000, 'Transmission fluid flushed'),
(15, 6, '2024-01-15', 79000, 'Alignment correction done'),
(16, 7, '2023-12-05', 67000, 'Coolant replaced'),
(17, 8, '2023-07-30', 31000, 'Air filter checked - replaced as needed'),
(18, 9, '2024-01-25', 42000, 'Timing belt replaced to prevent failure'),
(19, 10, '2023-09-22', 35000, 'Spark plugs changed'),
(20, 1, '2024-02-15', 9000, 'Oil changed on schedule'),
(21, 2, '2024-02-20', 11000, 'Tires rotated and balanced'),
(22, 3, '2023-12-12', 47000, 'Brake check completed'),
(23, 4, '2024-01-17', 50000, 'Battery health check - replaced'),
(24, 5, '2024-02-03', 19000, 'Transmission service done'),
(25, 6, '2024-02-10', 43000, 'Alignment slightly off, corrected');


-- Insert scheduled maintenance
insert into maintenance_schedule (vehicle_id, service_id, due_mileage, status) values
(1, 1, 40000, 'pending'),
(2, 2, 20000, 'pending'),
(3, 3, 65000, 'pending'),
(4, 4, 60000, 'pending'),
(5, 5, 30000, 'pending'),
(6, 6, 15000, 'pending'),
(7, 7, 80000, 'pending'),
(8, 8, 95000, 'pending'),
(9, 9, 60000, 'pending'),
(10, 10, 70000, 'pending'),
(11, 1, 35000, 'completed'),
(12, 2, 40000, 'completed'),
(13, 3, 55000, 'completed'),
(14, 4, 50000, 'completed'),
(15, 5, 25000, 'completed'),
(16, 6, 85000, 'pending'),
(17, 7, 92000, 'pending'),
(18, 8, 54000, 'completed'),
(19, 9, 72000, 'pending'),
(20, 10, 80000, 'pending'),
(21, 1, 12000, 'completed'),
(22, 2, 25000, 'completed'),
(23, 3, 60000, 'pending'),
(24, 4, 35000, 'pending'),
(25, 5, 50000, 'pending');
```
</details>

---

## **Task 3: Create a Trigger for Automatic Maintenance Scheduling**
📌 **Task:** Create a **trigger** that automatically adds a new maintenance schedule when a vehicle reaches the next mileage checkpoint.

<details>
<summary>💡 Solution (Click to expand)</summary>

```sql
delimiter //

create trigger after_maintenance_update
after insert on maintenance_records
for each row
begin
    declare next_service_mileage int;
    
    -- Define next service interval (assume every 10,000 miles for simplicity)
    set next_service_mileage = new.mileage_at_service + 10000;

    -- Insert new maintenance schedule entry
    insert into maintenance_schedule (vehicle_id, service_id, due_mileage, status)
    values (new.vehicle_id, new.service_id, next_service_mileage, 'pending');
end;
//

delimiter ;
```
</details>

---

## **Task 4: Query Maintenance Records Using INNER JOIN**
📌 **Task:** Write a query to **retrieve all maintenance records** with vehicle details and service descriptions.

<details>
<summary>💡 Solution (Click to expand)</summary>

```sql
select v.make, v.model, v.year, v.mileage, s.service_name, m.service_date, m.mileage_at_service, m.notes
from maintenance_records m
inner join vehicles v on m.vehicle_id = v.vehicle_id
inner join service_types s on m.service_id = s.service_id;
```
</details>

---

## **Task 5: Use LEFT JOIN to Find Vehicles Without Maintenance Records**
📌 **Task:** Retrieve a list of vehicles **that have never had maintenance recorded**.

<details>
<summary>💡 Solution (Click to expand)</summary>

```sql
select v.vehicle_id, v.make, v.model, v.year, v.mileage
from vehicles v
left join maintenance_records m on v.vehicle_id = m.vehicle_id
where m.record_id is null;
```
</details>

---

## **Task 6: Use CROSS JOIN to Show All Possible Service Assignments**
📌 **Task:** Generate all **possible service types** for each vehicle.

<details>
<summary>💡 Solution (Click to expand)</summary>

```sql
select v.vehicle_id, v.make, v.model, v.year, s.service_name
from vehicles v
cross join service_types s;
```
</details>

---

## **Task 7: Advanced WHERE Clause with Multiple Conditions**
📌 **Task:** Retrieve **all maintenance records** for vehicles that are **older than 2019 and have exceeded 20,000 miles**.

<details>
<summary>💡 Solution (Click to expand)</summary>

```sql
select v.make, v.model, v.year, m.service_date, s.service_name
from maintenance_records m
join vehicles v on m.vehicle_id = v.vehicle_id
join service_types s on m.service_id = s.service_id
where v.year < 2019 and v.mileage > 20000;
```
</details>

---

# **🚀 Summary of Learning Objectives**
- ✅ **Created a relational database** with multiple tables.
- ✅ **Used INNER, LEFT, and CROSS JOINs** to query related data.
- ✅ **Implemented a TRIGGER** to automate maintenance scheduling.
- ✅ **Practiced WHERE clauses** with multiple conditions.

Would you like to expand this further with **stored procedures or performance tuning queries**? 🚀