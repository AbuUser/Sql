------------------------------------------------------------
-- Lesson 16: CTEs and Derived Tables
-- SQL Server solutions (handwritten style)
------------------------------------------------------------

------------------------------------------------------------
-- EASY TASKS
------------------------------------------------------------

-- 1. create a numbers table using a recursive query from 1 to 1000
;with nums as (
    select 1 as n
    union all
    select n+1 from nums where n < 1000
)
select n from nums option (maxrecursion 1000);

-- 2. total sales per employee using a derived table (Sales, Employees)
select e.EmployeeID, e.FirstName, e.LastName, t.TotalSales
from Employees e
join (
    select EmployeeID, sum(SalesAmount) as TotalSales
    from Sales
    group by EmployeeID
) t on e.EmployeeID = t.EmployeeID;

-- 3. cte to find the average salary of employees
;with avg_sal as (
    select avg(Salary) as average_salary from Employees
)
select average_salary from avg_sal;

-- 4. highest sales for each product using a derived table
select p.ProductID, p.ProductName, t.MaxSale
from Products p
join (
    select ProductID, max(SalesAmount) as MaxSale
    from Sales
    group by ProductID
) t on p.ProductID = t.ProductID;

-- 5. beginning at 1, double the number until max < 1,000,000
;with doubles as (
    select 1 as val
    union all
    select val*2 from doubles where val*2 < 1000000
)
select val from doubles;

-- 6. employees who made more than 5 sales (cte)
;with emp_sales as (
    select EmployeeID, count(*) as cnt
    from Sales
    group by EmployeeID
)
select e.EmployeeID, e.FirstName, e.LastName
from Employees e
join emp_sales es on e.EmployeeID = es.EmployeeID
where es.cnt > 5;

-- 7. products with sales greater than 500 (cte)
;with prod_sales as (
    select ProductID, sum(SalesAmount) as total_sales
    from Sales
    group by ProductID
)
select p.ProductID, p.ProductName, ps.total_sales
from Products p
join prod_sales ps on p.ProductID = ps.ProductID
where ps.total_sales > 500;

-- 8. employees with salaries above average (cte)
;with avg_s as (select avg(Salary) as avg_salary from Employees)
select e.EmployeeID, e.FirstName, e.Salary
from Employees e, avg_s
where e.Salary > avg_s.avg_salary;

------------------------------------------------------------
-- MEDIUM TASKS
------------------------------------------------------------

-- 1. top 5 employees by number of orders (derived table)
select top 5 e.EmployeeID, e.FirstName, e.LastName, t.OrderCount
from Employees e
join (
    select EmployeeID, count(*) as OrderCount
    from Sales
    group by EmployeeID
) t on e.EmployeeID = t.EmployeeID
order by t.OrderCount desc;

-- 2. sales per product category (derived table)
select p.CategoryID, sum(t.SalesAmount) as TotalCategorySales
from Products p
join (
    select ProductID, SalesAmount from Sales
) t on p.ProductID = t.ProductID
group by p.CategoryID;

-- 3. factorial of each number (Numbers1) using recursion
;with fact as (
    select Number, cast(Number as bigint) as fact_val, Number as step
    from Numbers1
    union all
    select f.Number, f.fact_val_
