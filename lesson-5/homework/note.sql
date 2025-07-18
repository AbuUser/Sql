-- Lesson 5: Working with Joins and Aggregations

-- 1. Show all orders along with the customer name who placed them.
select o.OrderID, o.OrderDate, c.CustomerName
from Orders o
join Customers c on o.CustomerID = c.CustomerID;

-- 2. List all products sold along with the quantity from the Sales table.
select s.SaleID, p.ProductName, s.Quantity
from Sales s
join Products p on s.ProductID = p.ProductID;

-- 3. Show employee names and the orders they handled.
select e.FullName, o.OrderID, o.OrderDate
from Orders o
join Employees e on o.EmployeeID = e.EmpID;

-- 4. Get a list of all customers and their respective orders (if any).
select c.CustomerName, o.OrderID, o.OrderDate
from Customers c
left join Orders o on c.CustomerID = o.CustomerID;

-- 5. Show products that have not been sold yet.
select p.ProductID, p.ProductName
from Products p
left join Sales s on p.ProductID = s.ProductID
where s.SaleID is null;

-- 6. Count the total number of orders placed by each customer.
select c.CustomerName, count(o.OrderID) as TotalOrders
from Customers c
left join Orders o on c.CustomerID = o.CustomerID
group by c.CustomerName;

-- 7. Find the total quantity sold for each product.
select p.ProductName, sum(s.Quantity) as TotalSold
from Products p
join Sales s on p.ProductID = s.ProductID
group by p.ProductName;

-- 8. Get the number of employees in each department.
select Department, count(*) as TotalEmployees
from Employees
group by Department;

-- 9. Find the average price of products in the Products table.
select avg(Price) as AveragePrice
from Products;

-- 10. Show each employee and how many orders they have handled.
select e.FullName, count(o.OrderID) as TotalOrdersHandled
from Employees e
left join Orders o on e.EmpID = o.EmployeeID
group by e.FullName;
