-- 1. Display the full name of employees using alias
select FirstName + ' ' + LastName as FullName from Employees;

-- 2. Combine product names and customer names into a single column using UNION
select ProductName as Name from Products
union
select CustomerName from Customers;

-- 3. Find customers who have placed orders using INTERSECT
select CustomerID from Customers
intersect
select CustomerID from Orders;

-- 4. Find employees who haven’t made any sales using EXCEPT
select EmployeeID from Employees
except
select EmployeeID from Sales;

-- 5. Use CASE to categorize products based on price
select ProductName,
       Price,
       case
           when Price < 50 then 'Cheap'
           when Price between 50 and 100 then 'Moderate'
           else 'Expensive'
       end as PriceCategory
from Products;

-- 6. Use IIF to check if stock is available (assume Stock column exists)
select ProductName,
       IIF(Stock > 0, 'In Stock', 'Out of Stock') as Availability
from Products;

-- 7. List all orders and show status using CASE (if TotalAmount > 1000 = 'Large', else 'Small')
select OrderID,
       TotalAmount,
       case
           when TotalAmount > 1000 then 'Large'
           else 'Small'
       end as OrderStatus
from Orders;

-- 8. Use UNION ALL to show all product and customer names (duplicates allowed)
select ProductName as Name from Products
union all
select CustomerName from Customers;

-- 9. Use INTERSECT to find employees who are also customers (same name)
select FirstName from Employees
intersect
select CustomerName from Customers;

-- 10. Use EXCEPT to find customers who haven’t placed any orders
select CustomerID from Customers
except
select CustomerID from Orders;

-- 11. Add alias to all columns for readability
select ProductName as Name, Price as Cost from Products;

-- 12. Use IIF in WHERE to filter only 'Expensive' products (Price > 100)
select ProductName, Price
from Products
where IIF(Price > 100, 1, 0) = 1;

-- 13. Use CASE in SELECT to tag customers as 'VIP' if ID < 5
select CustomerID,
       CustomerName,
       case
           when CustomerID < 5 then 'VIP'
           else 'Regular'
       end as CustomerType
from Customers;

-- 14. Use IF...ELSE structure (note: this is T-SQL specific)
declare @total int = (select count(*) from Orders);
if @total > 10
    print 'More than 10 orders';
else
    print '10 or fewer orders';

-- 15. Use WHILE loop to print first 5 ProductIDs
declare @i int = 1;
while @i <= 5
begin
    print @i;
    set @i = @i + 1;
end;
