----------------------------------------------------------
-- Lesson 17 : Practice (SQL Server Solutions)
----------------------------------------------------------

----------------------------------------------------------
-- 1. Distributors and Sales by Region (fill missing with 0)
----------------------------------------------------------
drop table if exists #RegionSales;
create table #RegionSales (
  Region varchar(100),
  Distributor varchar(100),
  Sales int not null,
  primary key (Region, Distributor)
);
insert into #RegionSales values
('North','ACE',10),('South','ACE',67),('East','ACE',54),
('North','ACME',65),('South','ACME',9),('East','ACME',1),('West','ACME',7),
('North','Direct Parts',8),('South','Direct Parts',7),('West','Direct Parts',12);

select r.Region, d.Distributor, isnull(s.Sales,0) as Sales
from (select distinct Region from #RegionSales) r
cross join (select distinct Distributor from #RegionSales) d
left join #RegionSales s
  on r.Region=s.Region and d.Distributor=s.Distributor
order by d.Distributor, r.Region;

----------------------------------------------------------
-- 2. Managers with at least 5 direct reports
----------------------------------------------------------
create table Employee (id int, name varchar(255), department varchar(255), managerId int);
truncate table Employee;
insert into Employee values
(101,'John','A',null),(102,'Dan','A',101),(103,'James','A',101),
(104,'Amy','A',101),(105,'Anne','A',101),(106,'Ron','B',101);

select e.name
from Employee e
join Employee m on e.id=m.managerId
group by e.id,e.name
having count(m.id)>=5;

----------------------------------------------------------
-- 3. Products with ≥100 units in Feb 2020
----------------------------------------------------------
create table Products(product_id int,product_name varchar(40),product_category varchar(40));
create table Orders(product_id int,order_date date,unit int);
truncate table Products;
insert into Products values
(1,'Leetcode Solutions','Book'),
(2,'Jewels of Stringology','Book'),
(3,'HP','Laptop'),(4,'Lenovo','Laptop'),(5,'Leetcode Kit','T-shirt');
truncate table Orders;
insert into Orders values
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

select p.product_name, sum(o.unit) as unit
from Products p join Orders o on p.product_id=o.product_id
where o.order_date between '2020-02-01' and '2020-02-29'
group by p.product_name
having sum(o.unit)>=100;

----------------------------------------------------------
-- 4. Vendor with most orders per customer
----------------------------------------------------------
drop table if exists Orders;
create table Orders (
  OrderID int primary key,
  CustomerID int not null,
  [Count] money not null,
  Vendor varchar(100) not null
);
insert into Orders values
(1,1001,12,'Direct Parts'),(2,1001,54,'Direct Parts'),(3,1001,32,'ACME'),
(4,2002,7,'ACME'),(5,2002,16,'ACME'),(6,2002,5,'Direct Parts');

;with cte as (
  select CustomerID,Vendor,count(*) as cnt,
         row_number() over(partition by CustomerID order by count(*) desc) as rn
  from Orders group by CustomerID,Vendor
)
select CustomerID,Vendor from cte where rn=1;

----------------------------------------------------------
-- 5. Prime number check
----------------------------------------------------------
declare @Check_Prime int=91, @i int=2, @flag bit=1;
while @i<=@Check_Prime/2
begin
  if @Check_Prime%@i=0 begin set @flag=0; break; end
  set @i+=1;
end
if @flag=1 and @Check_Prime>1
  print 'This number is prime';
else
  print 'This number is not prime';

----------------------------------------------------------
-- 6. Device signals (locations, max signal location, totals)
----------------------------------------------------------
create table Device(Device_id int,Locations varchar(25));
insert into Device values
(12,'Bangalore'),(12,'Bangalore'),(12,'Bangalore'),(12,'Bangalore'),
(12,'Hosur'),(12,'Hosur'),
(13,'Hyderabad'),(13,'Hyderabad'),(13,'Secunderabad'),
(13,'Secunderabad'),(13,'Secunderabad');

;with cte as (
  select Device_id,Locations,count(*) as cnt
  from Device group by Device_id,Locations
),
ranked as (
  select *, row_number() over(partition by Device_id order by cnt desc) as rn
  from cte
)
select r.Device_id,
       (select count(distinct Locations) from cte c where c.Device_id=r.Device_id) as no_of_location,
       r.Locations as max_signal_location,
       (select sum(cnt) from cte c where c.Device_id=r.Device_id) as no_of_signals
from ranked r where rn=1;

----------------------------------------------------------
-- 7. Employees earning above dept average
----------------------------------------------------------
create table Employee (
  EmpID int,EmpName varchar(30),Salary float,DeptID int
);
insert into Employee values
(1001,'Mark',60000,2),(1002,'Antony',40000,2),(1003,'Andrew',15000,1),
(1004,'Peter',35000,1),(1005,'John',55000,1),(1006,'Albert',25000,3),(1007,'Donald',35000,3);

;with cte as (
  select DeptID,avg(Salary) as avg_sal from Employee group by DeptID
)
select e.EmpID,e.EmpName,e.Salary
from Employee e join cte c on e.DeptID=c.DeptID
where e.Salary>c.avg_sal;

----------------------------------------------------------
-- 8. Lottery winnings
----------------------------------------------------------
create table Numbers(Number int);
insert into Numbers values(25),(45),(78);
create table Tickets(TicketID varchar(10),Number int);
insert into Tickets values
('A23423',25),('A23423',45),('A23423',78),
('B35643',25),('B35643',45),('B35643',98),
('C98787',67),('C98787',86),('C98787',91);

;with ticket_match as (
  select t.TicketID,count(distinct t.Number) as matched
  from Tickets t join Numbers n on t.Number=n.Number
  group by t.TicketID
)
select sum(case when matched=(select count(*) from Numbers) then 100
                when matched>0 then 10 else 0 end) as Total_Winnings
from ticket_match;

----------------------------------------------------------
-- 9. Spending by platform (mobile/desktop/both)
----------------------------------------------------------
create table Spending(User_id int,Spend_date date,Platform varchar(10),Amount int);
insert into Spending values
(1,'2019-07-01','Mobile',100),(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),(3,'2019-07-02','Desktop',100);

;with cte as (
  select Spend_date,User_id,
    max(case when Platform='Mobile' then 1 else 0 end) as m,
    max(case when Platform='Desktop' then 1 else 0 end) as d,
    sum(case when Platform='Mobile' then Amount else 0 end) as m_amt,
    sum(case when Platform='Desktop' then Amount else 0 end) as d_amt
  from Spending group by Spend_date,User_id
)
select Spend_date,'Mobile' as Platform,
       sum(m_amt) as Total_Amount,
       sum(case when m=1 and d=0 then 1 else 0 end) as Total_users
from cte group by Spend_date
union all
select Spend_date,'Desktop',
       sum(d_amt),
       sum(case when d=1 and m=0 then 1 else 0 end)
from cte group by Spend_date
union all
select Spend_date,'Both',
       sum(m_amt+d_amt),
       sum(case when m=1 and d=1 then 1 else 0 end)
from cte group by Spend_date
order by Spend_date,Platform;

----------------------------------------------------------
-- 10. De-grouping data
----------------------------------------------------------
drop table if exists Grouped;
create table Grouped(Product varchar(100) primary key,Quantity int not null);
insert into Grouped values('Pencil',3),('Eraser',4),('Notebook',2);

;with nums as (
  select 1 as n union all select 2 union all select 3 union all select 4 union all select 5
)
select g.Product,1 as Quantity
from Grouped g join nums n on n.n<=g.Quantity
order by g.Product;
