/* =====================================================
   LESSON 20 – PRACTICE SOLUTIONS
   SQL Server
   ===================================================== */

---------------------------------------------------------
-- 1. Customers who purchased at least one item in March 2024 using EXISTS
---------------------------------------------------------
select distinct s.CustomerName
from #Sales s
where exists (
    select 1
    from #Sales x
    where x.CustomerName = s.CustomerName
      and month(x.SaleDate) = 3
      and year(x.SaleDate) = 2024
);

---------------------------------------------------------
-- 2. Product with the highest total sales revenue
---------------------------------------------------------
select top 1 Product
from (
    select Product, sum(Quantity * Price) as TotalRevenue
    from #Sales
    group by Product
) t
order by TotalRevenue desc;

---------------------------------------------------------
-- 3. Second highest sale amount
---------------------------------------------------------
select max(TotalAmount) as SecondHighest
from (
    select distinct Quantity*Price as TotalAmount
    from #Sales
) t
where TotalAmount < (select max(Quantity*Price) from #Sales);

---------------------------------------------------------
-- 4. Total quantity of products sold per month
---------------------------------------------------------
select year(SaleDate) as Y, month(SaleDate) as M,
       (select sum(Quantity) 
        from #Sales s2 
        where year(s2.SaleDate)=year(s1.SaleDate) 
          and month(s2.SaleDate)=month(s1.SaleDate)) as TotalQty
from #Sales s1
group by year(SaleDate), month(SaleDate);

---------------------------------------------------------
-- 5. Customers who bought same products as another customer using EXISTS
---------------------------------------------------------
select distinct s1.CustomerName
from #Sales s1
where exists (
    select 1
    from #Sales s2
    where s1.CustomerName <> s2.CustomerName
      and s1.Product = s2.Product
);

---------------------------------------------------------
-- 6. Fruits pivot
---------------------------------------------------------
select Name,
    sum(case when Fruit='Apple' then 1 else 0 end) as Apple,
    sum(case when Fruit='Orange' then 1 else 0 end) as Orange,
    sum(case when Fruit='Banana' then 1 else 0 end) as Banana
from Fruits
group by Name;

---------------------------------------------------------
-- 7. Family hierarchy (older people with younger ones)
---------------------------------------------------------
select f1.ParentId as PID, f2.ChildID as CHID
from Family f1
join Family f2 on f1.ChildID=f2.ParentId
union
select ParentId, ChildID from Family
union
select f1.ParentId, f3.ChildID
from Family f1
join Family f2 on f1.ChildID=f2.ParentId
join Family f3 on f2.ChildID=f3.ParentId;

---------------------------------------------------------
-- 8. Customers with CA delivery and their TX orders
---------------------------------------------------------
select o.*
from #Orders o
where o.DeliveryState='TX'
  and exists (
    select 1 from #Orders x
    where x.CustomerID=o.CustomerID and x.DeliveryState='CA'
);

---------------------------------------------------------
-- 9. Insert missing names from address
---------------------------------------------------------
update #residents
set fullname = parsename(replace(substring(address, charindex('name=',address)+5,50),' ','.'),1)
where fullname not in (substring(address, charindex('name=',address)+5,50));

---------------------------------------------------------
-- 10. Route from Tashkent to Khorezm (cheapest & most expensive)
---------------------------------------------------------
with paths as (
    select 'Tashkent - Samarkand - Khorezm' as Route, 100+400 as Cost
    union all
    select 'Tashkent - Samarkand - Bukhoro - Khorezm', 100+200+300
    union all
    select 'Tashkent - Jizzakh - Samarkand - Khorezm', 100+50+400
    union all
    select 'Tashkent - Jizzakh - Samarkand - Bukhoro - Khorezm', 100+50+200+300
)
select * from paths
where Cost in ((select min(Cost) from paths), (select max(Cost) from paths));

---------------------------------------------------------
-- 11. Rank products based on insertion
---------------------------------------------------------
select ID, Vals,
       sum(case when Vals='Product' then 1 else 0 end) 
       over(order by ID rows unbounded preceding) as GroupNum
from #RankingPuzzle;

---------------------------------------------------------
-- 12. Employees with sales > average in their department
---------------------------------------------------------
select e.*
from #EmployeeSales e
where e.SalesAmount > (
    select avg(SalesAmount)
    from #EmployeeSales x
    where x.Department=e.Department
      and x.SalesMonth=e.SalesMonth
      and x.SalesYear=e.SalesYear
);

---------------------------------------------------------
-- 13. Employees with highest sales in any month using EXISTS
---------------------------------------------------------
select distinct e.EmployeeName
from #EmployeeSales e
where not exists (
    select 1 from #EmployeeSales x
    where x.SalesMonth=e.SalesMonth and x.SalesYear=e.SalesYear
      and x.Department=e.Department
      and x.SalesAmount>e.SalesAmount
);

---------------------------------------------------------
-- 14. Employees who made sales in every month using NOT EXISTS
---------------------------------------------------------
select distinct e.EmployeeName
from #EmployeeSales e
where not exists (
    select distinct SalesMonth
    from #EmployeeSales
    where not exists (
        select 1
        from #EmployeeSales x
        where x.EmployeeName=e.EmployeeName
          and x.SalesMonth=#EmployeeSales.SalesMonth
          and x.SalesYear=#EmployeeSales.SalesYear
    )
);

---------------------------------------------------------
-- 15. Products more expensive than average price
---------------------------------------------------------
select Name from Products
where Price > (select avg(Price) from Products);

---------------------------------------------------------
-- 16. Products with stock lower than highest stock
---------------------------------------------------------
select Name from Products
where Stock < (select max(Stock) from Products);

---------------------------------------------------------
-- 17. Products in same category as Laptop
---------------------------------------------------------
select Name from Products
where Category = (select Category from Products where Name='Laptop');

---------------------------------------------------------
-- 18. Products whose price > lowest price in Electronics
---------------------------------------------------------
select Name from Products
where Price > (
    select min(Price) from Products where Category='Electronics'
);

---------------------------------------------------------
-- 19. Products higher than avg price in their category
---------------------------------------------------------
select p.Name
from Products p
where p.Price > (
    select avg(x.Price) from Products x where x.Category=p.Category
);

---------------------------------------------------------
-- 20. Products ordered at least once
---------------------------------------------------------
select distinct p.Name
from Products p
join Orders o on p.ProductID=o.ProductID;

---------------------------------------------------------
-- 21. Products ordered more than avg quantity
---------------------------------------------------------
select p.Name
from Products p
join Orders o on p.ProductID=o.ProductID
group by p.Name
having sum(o.Quantity) > (select avg(Quantity) from Orders);

---------------------------------------------------------
-- 22. Products never ordered
---------------------------------------------------------
select p.Name
from Products p
where not exists (select 1 from Orders o where o.ProductID=p.ProductID);

---------------------------------------------------------
-- 23. Product with highest total quantity ordered
------------------------------------------
