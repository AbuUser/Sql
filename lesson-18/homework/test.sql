/* 
 Lesson-18: View, temp table, variable, functions
 Author: Abdulaziz
 Date: 2025-09-02
 Database: SQL Server
*/

----------------------------------------------------------
-- Task 1: Temporary table - MonthlySales
----------------------------------------------------------
drop table if exists #MonthlySales;

select 
    s.ProductID,
    sum(s.Quantity) as TotalQuantity,
    sum(s.Quantity * p.Price) as TotalRevenue
into #MonthlySales
from Sales s
join Products p on s.ProductID = p.ProductID
where month(s.SaleDate) = month(getdate())
  and year(s.SaleDate) = year(getdate())
group by s.ProductID;

select * from #MonthlySales;

----------------------------------------------------------
-- Task 2: View - vw_ProductSalesSummary
----------------------------------------------------------
create or alter view vw_ProductSalesSummary
as
select 
    p.ProductID,
    p.ProductName,
    p.Category,
    isnull(sum(s.Quantity),0) as TotalQuantitySold
from Products p
left join Sales s on p.ProductID = s.ProductID
group by p.ProductID, p.ProductName, p.Category;

select * from vw_ProductSalesSummary;

----------------------------------------------------------
-- Task 3: Function fn_GetTotalRevenueForProduct
----------------------------------------------------------
create or alter function fn_GetTotalRevenueForProduct(@ProductID int)
returns decimal(18,2)
as
begin
    declare @TotalRevenue decimal(18,2);

    select @TotalRevenue = sum(s.Quantity * p.Price)
    from Sales s
    join Products p on s.ProductID = p.ProductID
    where s.ProductID = @ProductID;

    return isnull(@TotalRevenue,0);
end;

select dbo.fn_GetTotalRevenueForProduct(1) as TotalRevenue;

----------------------------------------------------------
-- Task 4: Function fn_GetSalesByCategory
----------------------------------------------------------
create or alter function fn_GetSalesByCategory(@Category varchar(50))
returns table
as
return
(
    select 
        p.ProductName,
        sum(s.Quantity) as TotalQuantity,
        sum(s.Quantity * p.Price) as TotalRevenue
    from Products p
    left join Sales s on p.ProductID = s.ProductID
    where p.Category = @Category
    group by p.ProductName
);

select * from dbo.fn_GetSalesByCategory('Electronics');

----------------------------------------------------------
-- Task 5: Function fn_IsPrime
----------------------------------------------------------
create or alter function fn_IsPrime(@Number int)
returns varchar(3)
as
begin
    if @Number < 2 return 'No';

    declare @i int = 2;
    while @i <= sqrt(@Number)
    begin
        if @Number % @i = 0 return 'No';
        set @i += 1;
    end
    return 'Yes';
end;

select dbo.fn_IsPrime(7) as IsPrime, dbo.fn_IsPrime(8) as NotPrime;

----------------------------------------------------------
-- Task 6: Table-valued function fn_GetNumbersBetween
----------------------------------------------------------
create or alter function fn_GetNumbersBetween(@Start int, @End int)
returns @Result table (Number int)
as
begin
    declare @i int = @Start;
    while @i <= @End
    begin
        insert into @Result values(@i);
        set @i += 1;
    end
    return;
end;

select * from dbo.fn_GetNumbersBetween(5,10);

----------------------------------------------------------
-- Task 7: Nth Highest Distinct Salary
----------------------------------------------------------
-- Employee sample table
drop table if exists Employee;
create table Employee (
    id int,
    salary int
);

insert into Employee values (1,100),(2,200),(3,300);

-- Solution
declare @N int = 2;
select distinct salary as HighestNSalary
from Employee e1
where @N = (
    select count(distinct salary)
    from Employee e2
    where e2.salary >= e1.salary
);

----------------------------------------------------------
-- Task 8: Most friends
----------------------------------------------------------
drop table if exists RequestAccepted;
create table RequestAccepted (
    requester_id int,
    accepter_id int,
    accept_date date
);

insert into RequestAccepted values
(1,2,'2016-06-03'),
(1,3,'2016-06-08'),
(2,3,'2016-06-08'),
(3,4,'2016-06-09');

select top 1 id, count(*) as num
from (
    select requester_id as id from RequestAccepted
    union all
    select accepter_id as id from RequestAccepted
) t
group by id
order by num desc;

----------------------------------------------------------
-- Task 9: View vw_CustomerOrderSummary
----------------------------------------------------------
create or alter view vw_CustomerOrderSummary
as
select 
    c.customer_id,
    c.name,
    count(o.order_id) as total_orders,
    sum(o.amount) as total_amount,
    max(o.order_date) as last_order_date
from Customers c
left join Orders o on c.customer_id = o.customer_id
group by c.customer_id, c.name;

select * from vw_CustomerOrderSummary;

----------------------------------------------------------
-- Task 10: Fill missing gaps
----------------------------------------------------------
select RowNumber,
       first_value(TestCase) over(partition by grp order by RowNumber) as Workflow
from (
    select *,
           count(case when TestCase is not null then 1 end) 
             over(order by RowNumber rows unbounded preceding) as grp
    from Gaps
) t;
