-- Task 1: Create Employees table
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- Task 2: Insert 3 records (single + multiple inserts)
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'Ali', 6000.00);

INSERT INTO Employees (EmpID, Name, Salary)
VALUES 
(2, 'Vali', 5500.00),
(3, 'Karim', 4800.00);

-- Task 3: Update Salary of EmpID = 1
UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1;

-- Task 4: Delete employee where EmpID = 2
DELETE FROM Employees
WHERE EmpID = 2;

-- Task 5: Difference between DELETE, TRUNCATE, DROP
/*
DELETE    => Deletes rows based on condition. Can use WHERE. Logged. Rollback possible.
TRUNCATE  => Removes all rows quickly. No WHERE. Minimal logging. Can't rollback easily.
DROP      => Deletes entire table structure and data permanently.
*/

-- Task 6: Modify Name column to VARCHAR(100)
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);

-- Task 7: Add Department column
ALTER TABLE Employees
ADD Department VARCHAR(50);

-- Task 8: Change Salary data type to FLOAT
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

-- Task 9: Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- Task 10: Truncate Employees table (remove all data)
TRUNCATE TABLE Employees;

-- Task 11: Insert 5 records into Departments using INSERT INTO SELECT
SELECT 1 AS DepartmentID, 'HR' AS DepartmentName
INTO #TempDepartments
UNION ALL
SELECT 2, 'IT'
UNION ALL
SELECT 3, 'Sales'
UNION ALL
SELECT 4, 'Finance'
UNION ALL
SELECT 5, 'Support';

INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT * FROM #TempDepartments;

DROP TABLE #TempDepartments;

-- Task 12: Update Department of employees with Salary > 5000 to 'Management'
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;

-- Task 13: Delete all employees, keep structure
DELETE FROM Employees;

-- Task 14: Drop Department column from Employees
ALTER TABLE Employees
DROP COLUMN Department;

-- Task 15: Rename Employees table to StaffMembers
EXEC sp_rename 'Employees', 'StaffMembers';

-- Task 16: Drop Departments table
DROP TABLE Departments;

-- Task 17: Create Products table with at least 5 columns
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    Description VARCHAR(255)
);

-- Task 18: Add CHECK constraint to ensure Price > 0
ALTER TABLE Products
ADD CONSTRAINT chk_Price CHECK (Price > 0);

-- Task 19: Add StockQuantity column with DEFAULT 50
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;

-- Task 20: Rename Category to ProductCategory
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

-- Task 21: Insert 5 records into Products
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, Description)
VALUES
(1, 'Laptop', 'Electronics', 1200.00, 'Gaming laptop'),
(2, 'Phone', 'Electronics', 800.00, 'Smartphone'),
(3, 'Table', 'Furniture', 150.00, 'Wooden table'),
(4, 'Chair', 'Furniture', 75.00, 'Office chair'),
(5, 'Pen', 'Stationery', 2.50, 'Blue ink pen');

-- Task 22: Use SELECT INTO to create Products_Backup
SELECT * INTO Products_Backup
FROM Products;

-- Task 23: Rename Products to Inventory
EXEC sp_rename 'Products', 'Inventory';

-- Task 24: Change Price from DECIMAL to FLOAT
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;

-- Task 25: Add ProductCode (IDENTITY) starting from 1000, increment 5
-- Step 1: Create new table with IDENTITY
CREATE TABLE Inventory_New (
    ProductCode INT IDENTITY(1000, 5),
    ProductID INT,
    ProductName VARCHAR(100),
    ProductCategory VARCHAR(50),
    Price FLOAT,
    Description VARCHAR(255),
    StockQuantity INT
);

-- Step 2: Insert data from old Inventory table
INSERT INTO Inventory_New (ProductID, ProductName, ProductCategory, Price, Description, StockQuantity)
SELECT ProductID, ProductName, ProductCategory, Price, Description, StockQuantity
FROM Inventory;

-- Step 3: Drop old table
DROP TABLE Inventory;

-- Step 4: Rename new table to Inventory
EXEC sp_rename 'Inventory_New', 'Inventory';
