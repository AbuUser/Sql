/*
   SQL Puzzle Questions + Sales/Customers/Products Queries
   Author: Abdulaziz
   Date: 2025-09-05
   Database: SQL Server
*/

----------------------------------------------------------
-- Puzzle 1: Extract month with leading zero
----------------------------------------------------------
create table Dates (
    Id int,
    Dt datetime
);
insert into Dates values
(1,'2018-04-06 11:06:43.020'),
(2,'2017-12-06 11:06:43.020'),
(3,'2016-01-06 11:06:43.020'),
(4,'2015-11-06 11:06:43.020'),
(5,'2014-10-06 11:06:43.020');

select 
    Id, 
    Dt,
    right('0' + cast(month(Dt) as varchar(2)),2) as MonthPrefixedWithZero
from Dates;

----------------------------------------------------------
-- Puzzle 2: Distinct Ids and Sum of Max vals
----------------------------------------------------------
create table MyTabel (
    Id int,
    rID int,
    Vals int
);
insert into MyTabel values
(121, 9, 1), (121, 9, 8),
(122, 9, 14), (122, 9, 0), (122, 9, 1),
(123, 9, 1), (123, 9, 2), (123, 9, 10);

select 
    count(distinct Id) as Distinct_Ids,
    rID,
    sum(max_val) as TotalOfMaxVals
from (
    select Id, rID, max(Vals) as max_val
    from MyTabel
    group by Id, rID
) t
group by rID;

----------------------------------------------------------
-- Puzzle 3: Strings with length between 6 and 10
----------------------------------------------------------
create table TestFixLengths (
    Id int,
    Vals varchar(100)
);
insert into TestFixLengths values
(1,'11111111'), (2,'123456'), (2,'1234567'),
(2,'1234567890'), (5,''), (6,null),
(7,'123456789012345');

select Id, Vals
from TestFixLengths
where len(isnull(Vals,'')) between 6 and 10;

----------------------------------------------------------
-- Puzzle 4: Max value per Id with item
----------------------------------------------------------
create table TestMaximum (
    ID int,
    Item varchar(20),
    Vals int
);
insert into TestMaximum values
(1, 'a1',15), (1, 'a2',20), (1, 'a3',90),
(2, 'q1',10), (2, 'q2',40), (2, 'q3',60), (2, 'q4',30),
(3, 'q5',20);

select t1.ID, t1.Item, t1.Vals
from TestMaximum t1
join (
    select ID, max(Vals) as max_val
    from TestMaximum
    group by ID
) t2 on t1.ID = t2.ID and t1.Vals = t2.max_val;

----------------------------------------------------------
-- Puzzle 5: Sum of max values per Id and DetailedNumber
----------------------------------------------------------
create table SumOfMax (
    DetailedNumber int,
    Vals int,
    Id int
);
insert into SumOfMax values
(1,5,101), (1,4,101), (2,6,101), (2,3,101),
(3,3,102), (4,2,102), (4,3,102);

select Id, sum(max_val) as SumofMax
from (
    select Id, DetailedNumber, max(Vals) as max_val
    from SumOfMax
    group by Id, DetailedNumber
) t
group by Id;

----------------------------------------------------------
-- Puzzle 6: a - b with blank if zero
----------------------------------------------------------
create table TheZeroPuzzle (
    Id int,
    a int,
    b int
);
insert into TheZeroPuzzle values
(1,10,4), (2,10,10), (3,1, 10000000), (4,15,15);

select 
    Id, a, b,
    case when a-b = 0 then '' else cast(a-b as varchar(20)) end as OUTPUT
from TheZeroPuzzle;

----------------------------------------------------------
-- SALES / CUSTOMERS / PRODUCTS TABLES
----------------------------------------------------------
create table Customers (
    CustomerID int primary key identity(1,1),
    CustomerName varchar(100),
    Region varchar(50),
    JoinDate date
);
insert into Customers (CustomerName, Region, JoinDate) values
('John Doe', 'North', '2022-03-01'),
('Jane Smith', 'West', '2023-06-15'),
('Emily Davis', 'East', '2021-11-20'),
('Michael Brown', 'South', '2023-01-10'),
('Sarah Wilson', 'North', '2022-07-25'),
('David Martinez', 'East', '2023-04-30'),
('Laura Johnson', 'West', '2022-09-14'),
('Kevin Anderson', 'South', '2021-12-05'),
('Sophia Moore', 'North', '2023-02-17'),
('Daniel Garcia', 'East', '2022-08-22');

create table Sales (
    SaleID int primary key identity(1,1),
    Product varchar(50),
    Category varchar(50),
    QuantitySold int,
    UnitPrice decimal(10,2),
    SaleDate date,
    Region varchar(50),
    CustomerID int foreign key references Customers(CustomerID)
);
insert into Sales (Product, Category, QuantitySold, UnitPrice, SaleDate, Region, CustomerID) values
('Laptop', 'Electronics', 10, 800.00, '2024-01-01', 'North', 1),
('Smartphone', 'Electronics', 15, 500.00, '2024-01-02', 'North', 2),
('Tablet', 'Electronics', 8, 300.00, '2024-01-03', 'East', 3),
('Headphones', 'Electronics', 25, 100.00, '2024-01-04', 'West', 4),
('TV', 'Electronics', 5, 1200.00, '2024-01-05', 'South', 5),
('Refrigerator', 'Appliances', 3, 1500.00, '2024-01-06', 'South', 6),
('Microwave', 'Appliances', 7, 200.00, '2024-01-07', 'East', 7),
('Washing Machine', 'Appliances', 4, 1000.00, '2024-01-08', 'North', 8),
('Oven', 'Appliances', 6, 700.00, '2024-01-09', 'West', 9),
('Smartwatch', 'Electronics', 12, 250.00, '2024-01-10', 'East', 10),
('Vacuum Cleaner', 'Appliances', 5, 400.00, '2024-01-11', 'South', 1),
('Gaming Console', 'Electronics', 9, 450.00, '2024-01-12', 'North', 2),
('Monitor', 'Electronics', 14, 300.00, '2024-01-13', 'West', 3),
('Keyboard', 'Electronics', 20, 50.00, '2024-01-14', 'South', 4),
('Mouse', 'Electronics', 30, 25.00, '2024-01-15', 'East', 5),
('Blender', 'Appliances', 10, 150.00, '2024-01-16', 'North', 6),
('Fan', 'Appliances', 12, 75.00, '2024-01-17', 'South', 7),
('Heater', 'Appliances', 8, 120.00, '2024-01-18', 'East', 8),
('Air Conditioner', 'Appliances', 2, 2000.00, '2024-01-19', 'West', 9),
('Camera', 'Electronics', 7, 900.00, '2024-01-20', 'North', 10);

create table Products (
    ProductID int primary key identity(1,1),
    ProductName varchar(50),
    Category varchar(50),
    CostPrice decimal(10,2),
    SellingPrice decimal(10,2)
);
insert into Products (ProductName, Category, CostPrice, SellingPrice) values
('Laptop', 'Electronics', 600.00, 800.00),
('Smartphone', 'Electronics', 350.00, 500.00),
('Tablet', 'Electronics', 200.00, 300.00),
('Headphones', 'Electronics', 50.00, 100.00),
('TV', 'Electronics', 900.00, 1200.00),
('Refrigerator', 'Appliances', 1100.00, 1500.00),
('Microwave', 'Appliances', 120.00, 200.00),
('Washing Machine', 'Appliances', 700.00, 1000.00),
('Oven', 'Appliances', 500.00, 700.00),
('Gaming Console', 'Electronics', 320.00, 450.00);

----------------------------------------------------------
-- Sales Queries
----------------------------------------------------------
-- Q7: Total revenue
select sum(QuantitySold * UnitPrice) as TotalRevenue from Sales;

-- Q8: Average unit price
select avg(UnitPrice) as AvgUnitPrice from Sales;

-- Q9: Number of sales transactions
select count(*) as TotalTransactions from Sales;

-- Q10: Highest units sold in one transaction
select max(QuantitySold) as MaxUnitsSold from Sales;

-- Q11: Products sold in each category
select Category, sum(QuantitySold) as TotalUnits
from Sales
group by Category;

-- Q12: Total revenue per region
select Region, sum(QuantitySold * UnitPrice) as Revenue
from Sales
group by Region;

-- Q13: Product with highest total revenue
select top 1 Product, sum(QuantitySold * UnitPrice) as Revenue
from Sales
group by Product
order by Revenue desc;

-- Q14: Running total revenue by date
select SaleDate,
       sum(QuantitySold * UnitPrice) as DailyRevenue,
       sum(sum(QuantitySold * UnitPrice)) over(order by SaleDate) as RunningTotal
from Sales
group by SaleDate
order by SaleDate;

-- Q15: Category contribution %
select Category,
       sum(QuantitySold * UnitPrice) as Revenue,
       cast(100.0 * sum(QuantitySold * UnitPrice) / sum(sum(QuantitySold * UnitPrice)) over() as decimal(5,2)) as ContributionPercent
from Sales
group by Category;

----------------------------------------------------------
-- Customer Queries
----------------------------------------------------------
-- Q17: Sales with customer names
select s.SaleID, s.Product, s.QuantitySold, s.UnitPrice, c.CustomerName
from Sales s
join Customers c on s.CustomerID = c.CustomerID;

-- Q18: Customers with no purchases
select c.CustomerID, c.CustomerName
from Customers c
left join Sales s on c.CustomerID = s.CustomerID
where s.SaleID is null;

-- Q19: Total revenue per customer
select c.CustomerID, c.CustomerName, sum(s.QuantitySold * s.UnitPrice) as Revenue
from Customers c
join Sales s on c.CustomerID = s.CustomerID
group by c.CustomerID, c.CustomerName;

-- Q20: Top customer by revenue
select top 1 c.CustomerID, c.CustomerName, sum(s.QuantitySold * s.UnitPrice) as Revenue
from Customers c
join Sales s on c.CustomerID = s.CustomerID
group by c.CustomerID, c.CustomerName
order by Revenue desc;

-- Q21: Total sales per customer (units sold)
select c.CustomerID, c.CustomerName, sum(s.QuantitySold) as TotalUnits
from Customers c
join Sales s on c.CustomerID = s.CustomerID
group by c.CustomerID, c.CustomerName;

----------------------------------------------------------
-- Product Queries
----------------------------------------------------------
-- Q22: Products sold at least once
select distinct p.ProductID, p.ProductName
from Products p
join Sales s on p.ProductName = s.Product;

-- Q23: Most expensive product
select top 1 * from Products order by SellingPrice desc;

-- Q24: Products above category avg price
select p.ProductID, p.ProductName, p.Category, p.SellingPrice
from Products p
join (
    select Category, avg(SellingPrice) as avg_price
    from Products
    group by Category
) t on p.Category = t.Category
where p.SellingPrice > t.avg_price;
