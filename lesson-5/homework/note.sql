-- Lesson 5: Aliases, Conditional Columns, Set Operators

-- 1. Using alias for readability
select p.ProductName as Product, p.Price as Cost
from Products as p;

-- 2. Using CASE to classify products based on price
select ProductName,
       case 
           when Price >= 100 then 'Expensive'
           when Price between 50 and 99.99 then 'Moderate'
           else 'Cheap'
       end as PriceCategory
from Products;

-- 3. Using IIF for quick conditional logic
select CustomerName, 
       iif(City = 'Tashkent', 'Local', 'Non-Local') as CustomerType
from Customers;

-- 4. Using UNION to combine all unique product names sold and in stock
select ProductName from Products
union
select ProductName from Sales;

-- 5. Using INTERSECT to find product names that are both in products and sold
select ProductName from Products
intersect
select ProductName from Sales;

-- 6. Using EXCEPT to find products that were never sold
select ProductName from Products
except
select ProductName from Sales;

-- 7. Using alias and CASE in joined query to display order type
select o.OrderID, c.CustomerName,
       case 
           when o.TotalAmount > 1000 then 'Large Order'
           else 'Regular Order'
       end as OrderCategory
from Orders as o
join Customers as c on o.CustomerID = c.CustomerID;

-- 8. Using IF to print a message (for illustrative purposes only)
if exists (select * from Employees where JobTitle = 'Manager')
    print 'There are managers in the company';

-- 9. Using WHILE to print numbers from 1 to 5 (for loop concept)
declare @counter int = 1;
while @counter <= 5
begin
    print 'Counter: ' + cast(@counter as varchar);
    set @counter = @counter + 1;
end;

-- 10. Using alias and conditional logic in a more complex query
select e.EmployeeName as Name,
       case 
           when o.TotalAmount > 500 then 'High Value'
           else 'Standard'
       end as SalesCategory
from Employees as e
join Orders as o on e.EmployeeID = o.EmployeeID;
