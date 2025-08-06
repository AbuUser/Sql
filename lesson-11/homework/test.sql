-- Lesson 11 Homework Tasks
-- Author: Abdulaziz
-- Topic: Advanced Filtering, Aggregation & Conditions in SQL Server
-------------------------------------------------------

-- 🟢 EASY TASKS

-- 1. Show all orders placed after 2022 with customer names
select o.OrderID, c.FirstName + ' ' + c.LastName as CustomerName, o.OrderDate
from Orders o join Customers c on o.CustomerID = c.CustomerID
where year(o.OrderDate) > 2022;

-- 2. Employees who work in Sales or Marketing department
select e.Name as EmployeeName, d.DepartmentName
from Employees e join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentName in ('Sales', 'Marketing');

-- 3. Highest salary for each department
select d.DepartmentName, max(e.Salary) as MaxSalary
from Departments d join Employees e on d.DepartmentID = e.DepartmentID
group by d.DepartmentName;

-- 4. Customers from USA who placed orders in 2023
select c.FirstName + ' ' + c.LastName as CustomerName, o.OrderID, o.OrderDate
from Customers c join Orders o on c.CustomerID = o.CustomerID
where c.Country = 'USA' and year(o.OrderDate) = 2023;

-- 5. How many orders each customer placed
select c.FirstName + ' ' + c.LastName as CustomerName, count(o.OrderID) as TotalOrders
from Customers c left join Orders o on c.CustomerID = o.CustomerID
group by c.FirstName, c.LastName;

-- 6. Products supplied by Gadget Supplies or Clothing Mart
select p.ProductName, s.SupplierName
from Products p join Suppliers s on p.SupplierID = s.SupplierID
where s.SupplierName in ('Gadget Supplies', 'Clothing Mart');

-- 7. Most recent order for each customer (include those with no orders)
select c.FirstName + ' ' + c.LastName as CustomerName, max(o.OrderDate) as MostRecentOrderDate
from Customers c left join Orders o on c.CustomerID = o.CustomerID
group by c.FirstName, c.LastName;

-------------------------------------------------------
-- 🟠 MEDIUM TASKS

-- 8. Customers who have an order with total amount > 500
select c.FirstName + ' ' + c.LastName as CustomerName, o.TotalAmount as OrderTotal
from Customers c join Orders o on c.CustomerID = o.CustomerID
where o.TotalAmount > 500;

-- 9. Product sales in 2022 or sale amount > 400
select p.ProductName, s.SaleDate, s.SaleAmount
from Sales s join Products p on s.ProductID = p.ProductID
where year(s.SaleDate) = 2022 or s.SaleAmount > 400;

-- 10. Each product with total sales amount
select p.ProductName, sum(s.SaleAmount) as TotalSalesAmount
from Products p join Sales s on p.ProductID = s.ProductID
group by p.ProductName;

-- 11. Employees in HR with salary > 60000
select e.Name as EmployeeName, d.DepartmentName, e.Salary
from Employees e join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentName = 'Human Resources' and e.Salary > 60000;

-- 12. Products sold in 2023 and stock > 100
select p.ProductName, s.SaleDate, p.StockQuantity
from Products p join Sales s on p.ProductID = s.ProductID
where year(s.SaleDate) = 2023 and p.StockQuantity > 100;

-- 13. Employees in Sales department or hired after 2020
select e.Name as EmployeeName, d.DepartmentName, e.HireDate
from Employees e join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentName = 'Sales' or year(e.HireDate) > 2020;

-------------------------------------------------------
-- 🔴 HARD TASKS

-- 14. Orders by USA customers whose address starts with 4 digits
select c.FirstName + ' ' + c.LastName as CustomerName, o.OrderID, c.Address, o.OrderDate
from Customers c join Orders o on c.CustomerID = o.CustomerID
where c.Country = 'USA' and c.Address like '[0-9][0-9][0-9][0-9]%';

-- 15. Product sales in Electronics category or sale amount > 350
select p.ProductName, p.Category, s.SaleAmount
from Sales s join Products p on s.ProductID = p.ProductID
where p.Category = 'Electronics' or s.SaleAmount > 350;

-- 16. Number of products in each category
select Category as CategoryName, count(*) as ProductCount
from Products
group by Category;

-- 17. Orders where customer is from Los Angeles and amount > 300
select c.FirstName + ' ' + c.LastName as CustomerName, c.City, o.OrderID, o.TotalAmount as Amount
from Customers c join Orders o on c.CustomerID = o.CustomerID
where c.City = 'Los Angeles' and o.TotalAmount > 300;

-- 18. Employees in HR or Finance or name contains 4+ vowels
select e.Name as EmployeeName, d.DepartmentName
from Employees e join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentName in ('Human Resources', 'Finance')
   or (len(replace(replace(replace(replace(replace(e.Name,'a',''),'e',''),'i',''),'o',''),'u','')) <= len(e.Name) - 4);

-- 19. Employees in Sales or Marketing with salary > 60000
select e.Name as EmployeeName, d.DepartmentName, e.Salary
from Employees e join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentName in ('Sales', 'Marketing') and e.Salary > 60000;
