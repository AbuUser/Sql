/*
 Lesson-21: WINDOW FUNCTIONS
 Author: Abdulaziz
 Date: 2025-09-02
 Database: SQL Server
*/

----------------------------------------------------------
-- CREATE TABLES AND DATA
----------------------------------------------------------
drop table if exists ProductSales;
create table ProductSales (
    SaleID int primary key,
    ProductName varchar(50) not null,
    SaleDate date not null,
    SaleAmount decimal(10,2) not null,
    Quantity int not null,
    CustomerID int not null
);

insert into ProductSales (SaleID, ProductName, SaleDate, SaleAmount, Quantity, CustomerID)
values 
(1, 'Product A', '2023-01-01', 148.00, 2, 101),
(2, 'Product B', '2023-01-02', 202.00, 3, 102),
(3, 'Product C', '2023-01-03', 248.00, 1, 103),
(4, 'Product A', '2023-01-04', 149.50, 4, 101),
(5, 'Product B', '2023-01-05', 203.00, 5, 104),
(6, 'Product C', '2023-01-06', 252.00, 2, 105),
(7, 'Product A', '2023-01-07', 151.00, 1, 101),
(8, 'Product B', '2023-01-08', 205.00, 8, 102),
(9, 'Product C', '2023-01-09', 253.00, 7, 106),
(10, 'Product A', '2023-01-10', 152.00, 2, 107),
(11, 'Product B', '2023-01-11', 207.00, 3, 108),
(12, 'Product C', '2023-01-12', 249.00, 1, 109),
(13, 'Product A', '2023-01-13', 153.00, 4, 110),
(14, 'Product B', '2023-01-14', 208.50, 5, 111),
(15, 'Product C', '2023-01-15', 251.00, 2, 112),
(16, 'Product A', '2023-01-16', 154.00, 1, 113),
(17, 'Product B', '2023-01-17', 210.00, 8, 114),
(18, 'Product C', '2023-01-18', 254.00, 7, 115),
(19, 'Product A', '2023-01-19', 155.00, 3, 116),
(20, 'Product B', '2023-01-20', 211.00, 4, 117),
(21, 'Product C', '2023-01-21', 256.00, 2, 118),
(22, 'Product A', '2023-01-22', 157.00, 5, 119),
(23, 'Product B', '2023-01-23', 213.00, 3, 120),
(24, 'Product C', '2023-01-24', 255.00, 1, 121),
(25, 'Product A', '2023-01-25', 158.00, 6, 122),
(26, 'Product B', '2023-01-26', 215.00, 7, 123),
(27, 'Product C', '2023-01-27', 257.00, 3, 124),
(28, 'Product A', '2023-01-28', 159.50, 4, 125),
(29, 'Product B', '2023-01-29', 218.00, 5, 126),
(30, 'Product C', '2023-01-30', 258.00, 2, 127);

----------------------------------------------------------
-- Task 1: Row number by SaleDate
----------------------------------------------------------
select *, row_number() over(order by SaleDate) as RowNum
from ProductSales;

----------------------------------------------------------
-- Task 2: Rank products by total quantity sold
----------------------------------------------------------
select ProductName, sum(Quantity) as TotalQty,
    dense_rank() over(order by sum(Quantity) desc) as Rnk
from ProductSales
group by ProductName;

----------------------------------------------------------
-- Task 3: Top sale per customer
----------------------------------------------------------
select * from (
    select *, row_number() over(partition by CustomerID order by SaleAmount desc) as rn
    from ProductSales
) t
where rn = 1;

----------------------------------------------------------
-- Task 4: Current and next sale amount
----------------------------------------------------------
select SaleID, SaleAmount,
    lead(SaleAmount) over(order by SaleDate) as NextSale
from ProductSales;

----------------------------------------------------------
-- Task 5: Current and previous sale amount
----------------------------------------------------------
select SaleID, SaleAmount,
    lag(SaleAmount) over(order by SaleDate) as PrevSale
from ProductSales;

----------------------------------------------------------
-- Task 6: Sales greater than previous sale
----------------------------------------------------------
select * from (
    select SaleID, SaleAmount,
        lag(SaleAmount) over(order by SaleDate) as PrevSale
    from ProductSales
) t
where SaleAmount > PrevSale;

----------------------------------------------------------
-- Task 7: Difference from previous sale (per product)
----------------------------------------------------------
select SaleID, ProductName, SaleAmount,
    SaleAmount - lag(SaleAmount) over(partition by ProductName order by SaleDate) as DiffPrev
from ProductSales;

----------------------------------------------------------
-- Task 8: % change vs next sale
----------------------------------------------------------
select SaleID, SaleAmount,
    lead(SaleAmount) over(order by SaleDate) as NextSale,
    (cast(lead(SaleAmount) over(order by SaleDate) as float) - SaleAmount) * 100.0 / SaleAmount as PctChange
from ProductSales;

----------------------------------------------------------
-- Task 9: Ratio current / previous (per product)
----------------------------------------------------------
select SaleID, ProductName, SaleAmount,
    cast(SaleAmount as float) / lag(SaleAmount) over(partition by ProductName order by SaleDate) as RatioPrev
from ProductSales;

----------------------------------------------------------
-- Task 10: Difference from first sale (per product)
----------------------------------------------------------
select SaleID, ProductName, SaleAmount,
    SaleAmount - first_value(SaleAmount) over(partition by ProductName order by SaleDate) as DiffFirst
from ProductSales;

----------------------------------------------------------
-- Task 11: Continuously increasing sales (per product)
----------------------------------------------------------
select * from (
    select SaleID, ProductName, SaleAmount,
        lag(SaleAmount) over(partition by ProductName order by SaleDate) as PrevSale
    from ProductSales
) t
where SaleAmount > PrevSale;

----------------------------------------------------------
-- Task 12: Running total (closing balance)
----------------------------------------------------------
select SaleID, SaleAmount,
    sum(SaleAmount) over(order by SaleDate rows between unbounded preceding and current row) as RunningTotal
from ProductSales;

----------------------------------------------------------
-- Task 13: Moving average (last 3 sales)
----------------------------------------------------------
select SaleID, SaleAmount,
    avg(SaleAmount) over(order by SaleDate rows between 2 preceding and current row) as MovingAvg3
from ProductSales;

----------------------------------------------------------
-- Task 14: Diff from average
----------------------------------------------------------
select SaleID, SaleAmount,
    SaleAmount - avg(SaleAmount) over() as DiffFromAvg
from ProductSales;

----------------------------------------------------------
-- Employees1
----------------------------------------------------------
drop table if exists Employees1;
create table Employees1 (
    EmployeeID   int primary key,
    Name         varchar(50),
    Department   varchar(50),
    Salary       decimal(10,2),
    HireDate     date
);

insert into Employees1 (EmployeeID, Name, Department, Salary, HireDate) values
(1, 'John Smith', 'IT', 60000.00, '2020-03-15'),
(2, 'Emma Johnson', 'HR', 50000.00, '2019-07-22'),
(3, 'Michael Brown', 'Finance', 75000.00, '2018-11-10'),
(4, 'Olivia Davis', 'Marketing', 55000.00, '2021-01-05'),
(5, 'William Wilson', 'IT', 62000.00, '2022-06-12'),
(6, 'Sophia Martinez', 'Finance', 77000.00, '2017-09-30'),
(7, 'James Anderson', 'HR', 52000.00, '2020-04-18'),
(8, 'Isabella Thomas', 'Marketing', 58000.00, '2019-08-25'),
(9, 'Benjamin Taylor', 'IT', 64000.00, '2021-11-17'),
(10, 'Charlotte Lee', 'Finance', 80000.00, '2016-05-09'),
(11, 'Ethan Harris', 'IT', 63000.00, '2023-02-14'),
(12, 'Mia Clark', 'HR', 53000.00, '2022-09-05'),
(13, 'Alexander Lewis', 'Finance', 78000.00, '2015-12-20'),
(14, 'Amelia Walker', 'Marketing', 57000.00, '2020-07-28'),
(15, 'Daniel Hall', 'IT', 61000.00, '2018-10-13'),
(16
