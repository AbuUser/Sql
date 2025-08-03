/* LESSON 8: Subqueries & Common Table Expressions */
/* Total: 40 Tasks (20 Easy, 12 Medium, 8 Hard) */
/* Tables: Employees, Products, Customers, Sales, Orders */

/* ---------------------- EASY LEVEL ---------------------- */

/* 1. Find all employees whose salary is greater than the average salary. */
select * from Employees where Salary > (select avg(Salary) from Employees)

/* 2. Get all products that are more expensive than the cheapest product. */
select * from Products where Price > (select min(Price) from Products)

/* 3. List customers who have placed at least one order. */
select * from Customers where CustomerID in (select distinct CustomerID from Orders)

/* 4. Find products that are not sold in any order. */
select * from Products where ProductID not in (select distinct ProductID from Sales)

/* 5. Show employees working in the same department as 'John Smith'. */
select * from Employees where DepartmentID = (select DepartmentID from Employees where Name = 'John Smith')

/* 6. Get customers who have ordered 'Laptop'. */
select * from Customers where CustomerID in (select CustomerID from Orders where ProductID = (select ProductID from Products where ProductName = 'Laptop'))

/* 7. List orders that contain the most expensive product. */
select * from Orders where ProductID = (select top 1 ProductID from Products order by Price desc)

/* 8. Find the names of employees who have never sold anything. */
select Name from Employees where EmployeeID not in (select distinct EmployeeID from Sales)

/* 9. Show products with price above average price. */
select * from Products where Price > (select avg(Price) from Products)

/* 10. List customers who never made an order. */
select * from Customers where CustomerID not in (select CustomerID from Orders)

/* 11. Find the highest salary using subquery. */
select max(Salary) as HighestSalary from Employees

/* 12. Show employees whose salary equals the minimum salary. */
select * from Employees where Salary = (select min(Salary) from Employees)

/* 13. Find products cheaper than average price. */
select * from Products where Price < (select avg(Price) from Products)

/* 14. Display customers who ordered at least 3 different products. */
select * from Customers where CustomerID in (select CustomerID from Orders group by CustomerID having count(distinct ProductID) >= 3)

/* 15. Show orders made by customers from 'Tashkent'. */
select * from Orders where CustomerID in (select CustomerID from Customers where City = 'Tashkent')

/* 16. Get products sold by employee 'Ali'. */
select * from Products where ProductID in (select ProductID from Sales where EmployeeID = (select EmployeeID from Employees where Name = 'Ali'))

/* 17. Show employees whose department has more than 5 employees. */
select * from Employees where DepartmentID in (select DepartmentID from Employees group by DepartmentID having count(*) > 5)

/* 18. List all customers who bought the cheapest product. */
select * from Customers where CustomerID in (select CustomerID from Orders where ProductID = (select top 1 ProductID from Products order by Price))

/* 19. Show products never sold by employee with ID = 1. */
select * from Products where ProductID not in (select ProductID from Sales where EmployeeID = 1)

/* 20. Find employees who have the same salary as someone else. */
select * from Employees where Salary in (select Salary from Employees group by Salary having count(*) > 1)


/* ---------------------- MEDIUM LEVEL ---------------------- */

/* 21. Show customers who spent more than the average spending. */
select * from Customers where CustomerID in (select CustomerID from Orders group by CustomerID having sum(TotalAmount) > (select avg(TotalAmount) from Orders))

/* 22. List employees who sold more products than the average quantity. */
select * from Employees where EmployeeID in (select EmployeeID from Sales group by EmployeeID having sum(Quantity) > (select avg(Quantity) from Sales))

/* 23. Find customers who bought all products in the 'Electronics' category. */
select * from Customers where not exists (
    select * from Products where Category = 'Electronics' and ProductID not in (
        select ProductID from Orders where Orders.CustomerID = Customers.CustomerID
    )
)

/* 24. Show the product with the second highest price. */
select top 1 * from Products where Price < (select max(Price) from Products) order by Price desc

/* 25. Get employees whose salary is above average in their department. */
select * from Employees e where Salary > (select avg(Salary) from Employees where DepartmentID = e.DepartmentID)

/* 26. Display customers who placed orders in every month of 2024. */
select * from Customers where not exists (
    select * from (select distinct month(OrderDate) as M from Orders where year(OrderDate)=2024) as Months
    where M not in (select month(OrderDate) from Orders where CustomerID = Customers.CustomerID and year(OrderDate)=2024)
)

/* 27. Find employees who earn less than the maximum salary in their department but more than the minimum. */
select * from Employees e where Salary > (select min(Salary) from Employees where DepartmentID = e.DepartmentID) and Salary < (select max(Salary) from Employees where DepartmentID = e.DepartmentID)

/* 28. List customers who have the same city as employee 'Dilshod'. */
select * from Customers where City = (select City from Employees where Name = 'Dilshod')

/* 29. Find products that are more expensive than all products in 'Furniture' category. */
select * from Products where Price > all(select Price from Products where Category='Furniture')

/* 30. Show employees who handled orders worth more than 1,000,000 total. */
select * from Employees where EmployeeID in (select EmployeeID from Sales group by EmployeeID having sum(TotalPrice) > 1000000)

/* 31. Show orders with quantity greater than average quantity of that product. */
select * from Orders o where Quantity > (select avg(Quantity) from Orders where ProductID = o.ProductID)

/* 32. Find customers who bought products only from one category. */
select * from Customers where CustomerID in (
    select CustomerID from Orders join Products on Orders.ProductID=Products.ProductID group by CustomerID having count(distinct Category)=1
)


/* ---------------------- HARD LEVEL ---------------------- */

/* 33. Find the top 3 customers by total spending using CTE. */
with CustomerTotals as (
    select CustomerID, sum(TotalAmount) as TotalSpent from Orders group by CustomerID
)
select top 3 * from CustomerTotals order by TotalSpent desc

/* 34. Show employees ranked by their sales total using CTE and ROW_NUMBER. */
with EmployeeSales as (
    select EmployeeID, sum(TotalPrice) as SalesTotal from Sales group by EmployeeID
)
select EmployeeID, SalesTotal, row_number() over(order by SalesTotal desc) as Rank from EmployeeSales

/* 35. Find categories with average price higher than overall average using CTE. */
with CategoryAvg as (
    select Category, avg(Price) as AvgPrice from Products group by Category
)
select * from CategoryAvg where AvgPrice > (select avg(Price) from Products)

/* 36. Get the highest order amount per customer using CTE. */
with MaxOrders as (
    select CustomerID, max(TotalAmount) as MaxOrder from Orders group by CustomerID
)
select * from MaxOrders

/* 37. Rank customers by number of orders using CTE. */
with CustOrders as (
    select CustomerID, count(*) as OrderCount from Orders group by CustomerID
)
select CustomerID, OrderCount, rank() over(order by OrderCount desc) as Rank from CustOrders

/* 38. Show the difference between each employee's salary and the department average using CTE. */
with DeptAvg as (
    select DepartmentID, avg(Salary) as DeptAverage from Employees group by DepartmentID
)
select e.Name, e.Salary, e.DepartmentID, (e.Salary - d.DeptAverage) as Difference
from Employees e join DeptAvg d on e.DepartmentID = d.DepartmentID

/* 39. Find customers who spent more than any other customer in their city using CTE. */
with CityTotals as (
    select City, CustomerID, sum(TotalAmount) as TotalSpent from Customers join Orders on Customers.CustomerID=Orders.CustomerID group by City, Customers.CustomerID
)
select * from CityTotals c1 where TotalSpent = (select max(TotalSpent) from CityTotals c2 where c2.City = c1.City)

/* 40. Display the product with the highest price per category using CTE. */
with MaxPrice as (
    select Category, max(Price) as MaxP from Products group by Category
)
select p.* from Products p join MaxPrice mp on p.Category = mp.Category and p.Price = mp.MaxP
