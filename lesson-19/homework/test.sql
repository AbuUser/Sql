/* 
 Lesson-19: Stored procedures, Merge and Practice
 Author: Abdulaziz
 Date: 2025-09-02
 Database: SQL Server
*/

----------------------------------------------------------
-- Part 1: Stored Procedures
----------------------------------------------------------

----------------------------------------------------------
-- Task 1: Stored procedure - Employee Bonus
----------------------------------------------------------
create or alter procedure sp_GetEmployeeBonus
as
begin
    drop table if exists #EmployeeBonus;

    select 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName as FullName,
        e.Department,
        e.Salary,
        e.Salary * db.BonusPercentage / 100 as BonusAmount
    into #EmployeeBonus
    from Employees e
    join DepartmentBonus db on e.Department = db.Department;

    select * from #EmployeeBonus;
end;

exec sp_GetEmployeeBonus;

----------------------------------------------------------
-- Task 2: Stored procedure - Increase salary by department
----------------------------------------------------------
create or alter procedure sp_UpdateDepartmentSalary
    @Dept nvarchar(50),
    @Increase decimal(5,2)
as
begin
    update Employees
    set Salary = Salary + (Salary * @Increase / 100)
    where Department = @Dept;

    select * from Employees where Department = @Dept;
end;

exec sp_UpdateDepartmentSalary 'Sales', 5;

----------------------------------------------------------
-- Part 2: MERGE Tasks
----------------------------------------------------------

----------------------------------------------------------
-- Task 3: MERGE - Sync Products
----------------------------------------------------------
merge Products_Current as target
using Products_New as source
on target.ProductID = source.ProductID
when matched then 
    update set target.ProductName = source.ProductName,
               target.Price = source.Price
when not matched by target then
    insert (ProductID, ProductName, Price)
    values (source.ProductID, source.ProductName, source.Price)
when not matched by source then
    delete;

select * from Products_Current;

----------------------------------------------------------
-- Task 4: Tree Node Classification
----------------------------------------------------------
select 
    id,
    case 
        when p_id is null then 'Root'
        when id in (select p_id from Tree where p_id is not null) then 'Inner'
        else 'Leaf'
    end as type
from Tree;

----------------------------------------------------------
-- Task 5: Confirmation Rate
----------------------------------------------------------
select s.user_id,
       cast(isnull(avg(case when c.action = 'confirmed' then 1.0 else 0.0 end),0) as decimal(3,2)) as confirmation_rate
from Signups s
left join Confirmations c on s.user_id = c.user_id
group by s.user_id;

----------------------------------------------------------
-- Task 6: Employees with lowest salary
----------------------------------------------------------
select * 
from employees
where salary = (select min(salary) from employees);

----------------------------------------------------------
-- Task 7: Stored procedure - Product Sales Summary
----------------------------------------------------------
create or alter procedure GetProductSalesSummary
    @ProductID int
as
begin
    select 
        p.ProductName,
        sum(s.Quantity) as TotalQuantitySold,
        sum(s.Quantity * p.Price) as TotalSalesAmount,
        min(s.SaleDate) as FirstSaleDate,
        max(s.SaleDate) as LastSaleDate
    from Products p
    left join Sales s on p.ProductID = s.ProductID
    where p.ProductID = @ProductID
    group by p.ProductName;
end;

exec GetProductSalesSummary 1;
exec GetProductSalesSummary 8;  -- mahsulot bor, lekin savdo bo‘lmasa null qaytadi
