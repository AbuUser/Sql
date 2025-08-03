-- Task 1: Using the Employees and Departments tables, return the names and salaries of employees whose salary is greater than 50000, along with their department names.
select e.EmployeeName, e.Salary, d.DepartmentName
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where e.Salary > 50000;

-- Task 2: Using the Customers and Orders tables, display customer names and order dates for orders placed in the year 2023.
select c.FirstName, c.LastName, o.OrderDate
from Customers c
join Orders o on c.CustomerID = o.CustomerID
where year(o.OrderDate) = 2023;

-- Task 3: Using the Employees and Departments tables, show all employees along with their department names. Include employees who do not belong to any department.
select e.EmployeeName, d.DepartmentName
from Employees e
left join Departments d on e.DepartmentID = d.DepartmentID;

-- Task 4: Using the Products and Suppliers tables, list all suppliers and the products they supply. Show suppliers even if they don’t supply any product.
select s.SupplierName, p.ProductName
from Suppliers s
left join Products p on s.SupplierID = p.SupplierID;

-- Task 5: Using the Orders and Payments tables, return all orders and their corresponding payments. Include orders without payments and payments not linked to any order.
select o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
from Orders o
full join Payments p on o.OrderID = p.OrderID;

-- Task 6: Using the Employees table, show each employee's name along with the name of their manager.
select e.EmployeeName, m.EmployeeName as ManagerName
from Employees e
left join Employees m on e.ManagerID = m.EmployeeID;

-- Task 7: Using the Students, Courses, and Enrollments tables, list the names of students who are enrolled in the course named 'Math 101'.
select s.StudentName, c.CourseName
from Students s
join Enrollments e on s.StudentID = e.StudentID
join Courses c on e.CourseID = c.CourseID
where c.CourseName = 'Math 101';

-- Task 8: Using the Customers and Orders tables, find customers who have placed an order with more than 3 items. Return their name and the quantity they ordered.
select c.FirstName, c.LastName, o.Quantity
from Customers c
join Orders o on c.CustomerID = o.CustomerID
where o.Quantity > 3;

-- Task 9: Using the Employees and Departments tables, list employees working in the 'Human Resources' department.
select e.EmployeeName, d.DepartmentName
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentName = 'Human Resources';

-- Task 10: Using the Employees and Departments tables, return department names that have more than 5 employees.
select d.DepartmentName, count(e.EmployeeID) as EmployeeCount
from Departments d
join Employees e on d.DepartmentID = e.DepartmentID
group by d.DepartmentName
having count(e.EmployeeID) > 5;

-- Task 11: Using the Products and Sales tables, find products that have never been sold.
select p.ProductID, p.ProductName
from Products p
left join Sales s on p.ProductID = s.ProductID
where s.SaleID is null;

-- Task 12: Using the Customers and Orders tables, return customer names who have placed at least one order.
select c.FirstName, c.LastName, count(o.OrderID) as TotalOrders
from Customers c
join Orders o on c.CustomerID = o.CustomerID
group by c.FirstName, c.LastName;

-- Task 13: Using the Employees and Departments tables, show only those records where both employee and department exist (no NULLs).
select e.EmployeeName, d.DepartmentName
from Employees e
inner join Departments d on e.DepartmentID = d.DepartmentID;

-- Task 14: Using the Employees table, find pairs of employees who report to the same manager.
select e1.EmployeeName as Employee1, e2.EmployeeName as Employee2, e1.ManagerID
from Employees e1
join Employees e2 on e1.ManagerID = e2.ManagerID and e1.EmployeeID < e2.EmployeeID;

-- Task 15: Using the Orders and Customers tables, list all orders placed in 2022 along with the customer name.
select o.OrderID, o.OrderDate, c.FirstName, c.LastName
from Orders o
join Customers c on o.CustomerID = c.CustomerID
where year(o.OrderDate) = 2022;

-- Task 16: Using the Employees and Departments tables, return employees from the 'Sales' department whose salary is above 60000.
select e.EmployeeName, e.Salary, d.DepartmentName
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentName = 'Sales' and e.Salary > 60000;

-- Task 17: Using the Orders and Payments tables, return only those orders that have a corresponding payment.
select o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
from Orders o
inner join Payments p on o.OrderID = p.OrderID;

-- Task 18: Using the Products and Orders tables, find products that were never ordered.
select p.ProductID, p.ProductName
from Products p
left join Orders o on p.ProductID = o.ProductID
where o.OrderID is null;

-- Task 19: Using the Employees table, find employees whose salary is greater than the average salary in their own departments.
select e.EmployeeName, e.Salary
from Employees e
join (
    select DepartmentID, avg(Salary) as AvgSalary
    from Employees
    group by DepartmentID
) dept on e.DepartmentID = dept.DepartmentID
where e.Salary > dept.AvgSalary;

-- Task 20: Using the Orders and Payments tables, list all orders placed before 2020 that have no corresponding payment.
select o.OrderID, o.OrderDate
from Orders o
left join Payments p on o.OrderID = p.OrderID
where p.PaymentID is null and o.OrderDate < '2020-01-01';

-- Task 21: Using the Products and Categories tables, return products that do not have a matching category.
select p.ProductID, p.ProductName
from Products p
left join Categories c on p.CategoryID = c.CategoryID
where c.CategoryID is null;

-- Task 22: Using the Employees table, find employees who report to the same manager and earn more than 60000.
select e1.EmployeeName as Employee1, e2.EmployeeName as Employee2, e1.ManagerID, e1.Salary
from Employees e1
join Employees e2 on e1.ManagerID = e2.ManagerID and e1.EmployeeID < e2.EmployeeID
where e1.Salary > 60000 and e2.Salary > 60000;

-- Task 23: Using the Employees and Departments tables, return employees who work in departments which name starts with the letter 'M'.
select e.EmployeeName, d.DepartmentName
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentName like 'M%';

-- Task 24: Using the Products and Sales tables, list sales where the amount is greater than 500, including product names.
select s.SaleID, p.ProductName, s.SaleAmount
from Sales s
join Products p on s.ProductID = p.ProductID
where s.SaleAmount > 500;

-- Task 25: Using the Students, Courses, and Enrollments tables, find students who have not enrolled in the course 'Math 101'.
select s.StudentID, s.StudentName
from Students s
where s.StudentID not in (
    select e.StudentID
    from Enrollments e
    join Courses c on e.CourseID = c.CourseID
    where c.CourseName = 'Math 101'
);

-- Task 26: Using the Orders and Payments tables, return orders that are missing payment details.
select o.OrderID, o.OrderDate, p.PaymentID
from Orders o
left join Payments p on o.OrderID = p.OrderID
where p.PaymentID is null;

-- Task 27: Using the Products and Categories tables, list products that belong to either the 'Electronics' or 'Furniture' category.
select p.ProductID, p.ProductName, c.CategoryName
from Products p
join Categories c on p.CategoryID = c.CategoryID
where c.CategoryName in ('Electronics', 'Furniture');
