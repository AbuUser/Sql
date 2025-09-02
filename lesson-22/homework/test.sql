/*
 Lesson-22: Aggregated Window Functions
 Author: Abdulaziz
 Date: 2025-09-02
*/

----------------------------------------------------------
-- Setup: sales_data table
----------------------------------------------------------

CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
(1,101,'Alice','Electronics','Laptop',1,1200,1200,'2024-01-01','North'),
(2,102,'Bob','Electronics','Phone',2,600,1200,'2024-01-02','South'),
(3,103,'Charlie','Clothing','T-Shirt',5,20,100,'2024-01-03','East'),
(4,104,'David','Furniture','Table',1,250,250,'2024-01-04','West'),
(5,105,'Eve','Electronics','Tablet',1,300,300,'2024-01-05','North'),
(6,106,'Frank','Clothing','Jacket',2,80,160,'2024-01-06','South'),
(7,107,'Grace','Electronics','Headphones',3,50,150,'2024-01-07','East'),
(8,108,'Hank','Furniture','Chair',4,75,300,'2024-01-08','West'),
(9,109,'Ivy','Clothing','Jeans',1,40,40,'2024-01-09','North'),
(10,110,'Jack','Electronics','Laptop',2,1200,2400,'2024-01-10','South'),
(11,101,'Alice','Electronics','Phone',1,600,600,'2024-01-11','North'),
(12,102,'Bob','Furniture','Sofa',1,500,500,'2024-01-12','South'),
(13,103,'Charlie','Electronics','Camera',1,400,400,'2024-01-13','East'),
(14,104,'David','Clothing','Sweater',2,60,120,'2024-01-14','West'),
(15,105,'Eve','Furniture','Bed',1,800,800,'2024-01-15','North'),
(16,106,'Frank','Electronics','Monitor',1,200,200,'2024-01-16','South'),
(17,107,'Grace','Clothing','Scarf',3,25,75,'2024-01-17','East'),
(18,108,'Hank','Furniture','Desk',1,350,350,'2024-01-18','West'),
(19,109,'Ivy','Electronics','Speaker',2,100,200,'2024-01-19','North'),
(20,110,'Jack','Clothing','Shoes',1,90,90,'2024-01-20','South'),
(21,111,'Kevin','Electronics','Mouse',3,25,75,'2024-01-21','East'),
(22,112,'Laura','Furniture','Couch',1,700,700,'2024-01-22','West'),
(23,113,'Mike','Clothing','Hat',4,15,60,'2024-01-23','North'),
(24,114,'Nancy','Electronics','Smartwatch',1,250,250,'2024-01-24','South'),
(25,115,'Oscar','Furniture','Wardrobe',1,1000,1000,'2024-01-25','East');

----------------------------------------------------------
-- Easy Questions
----------------------------------------------------------

-- Task 1: Running Total Sales per Customer
select sale_id, customer_id, total_amount,
       sum(total_amount) over(partition by customer_id order by order_date) as running_total
from sales_data;

-- Task 2: Count Orders per Product Category
select distinct product_category,
       count(*) over(partition by product_category) as order_count
from sales_data;

-- Task 3: Max Total Amount per Category
select sale_id, product_category, total_amount,
       max(total_amount) over(partition by product_category) as max_amount
from sales_data;

-- Task 4: Min Price per Category
select sale_id, product_category, unit_price,
       min(unit_price) over(partition by product_category) as min_price
from sales_data;

-- Task 5: Moving Avg of Sales 3 days
select sale_id, order_date, total_amount,
       avg(total_amount) over(order by order_date rows between 1 preceding and 1 following) as moving_avg
from sales_data;

-- Task 6: Total Sales per Region
select region, sum(total_amount) over(partition by region) as total_sales
from sales_data
group by region, sale_id;

-- Task 7: Rank Customers by Total Purchase
select customer_id, customer_name,
       rank() over(order by sum(total_amount) over(partition by customer_id) desc) as rnk
from sales_data
group by customer_id, customer_name;

-- Task 8: Difference Between Current & Previous Sale Amount per Customer
select sale_id, customer_id, total_amount,
       total_amount - lag(total_amount) over(partition by customer_id order by order_date) as diff_prev
from sales_data;

-- Task 9: Top 3 Most Expensive Products in Each Category
select *
from (
    select *, dense_rank() over(partition by product_category order by unit_price desc) as rnk
    from sales_data
) t
where rnk <= 3;

-- Task 10: Cumulative Sum of Sales Per Region
select sale_id, region, order_date, total_amount,
       sum(total_amount) over(partition by region order by order_date) as cumulative_sales
from sales_data;

----------------------------------------------------------
-- Medium Questions
----------------------------------------------------------

-- Task 11: Cumulative Revenue per Category
select product_category, order_date, total_amount,
       sum(total_amount) over(partition by product_category order by order_date) as cumulative_revenue
from sales_data;

-- Task 12: Sum of Previous Values (1 to N)
with nums as (
    select 1 as id union all
    select 2 union all
    select 3 union all
    select 4 union all
    select 5
)
select id, sum(id) over(order by id) as SumPreValues
from nums;

-- Task 13: Sum of Previous Values to Current Value
create table OneColumn (Value smallint);
insert into OneColumn values (10),(20),(30),(40),(100);

select Value,
       sum(Value) over(order by Value rows between unbounded preceding and current row) as [Sum of Previous]
from OneColumn;

-- Task 14: Customers with multiple categories
select customer_id, customer_name
from sales_data
group by customer_id, customer_name
having count(distinct product_category) > 1;

-- Task 15: Customers with Above-Average Spending in Region
select customer_id, customer_name, region, sum(total_amount) as total_spent
from sales_data
group by customer_id, customer_name, region
having sum(total_amount) > avg(sum(total_amount)) over(partition by region);

-- Task 16: Rank customers by spending within region
select customer_id, customer_name, region,
       rank() over(partition by region order by sum(total_amount) over(partition by customer_id,region) desc) as rnk
from sales_data
group by customer_id, customer_name, region;

-- Task 17: Running total per customer
select sale_id, customer_id, order_date, total_amount,
       sum(total_amount) over(partition by customer_id order by order_date) as cumulative_sales
from sales_data;

-- Task 18: Sales growth rate month over month
select format(order_date,'yyyy-MM') as month,
       sum(total_amount) as monthly_sales,
       (sum(total_amount) - lag(sum(total_amount)) over(order by format(order_date,'yyyy-MM'))) * 100.0 /
       lag(sum(total_amount)) over(order by format(order_date,'yyyy-MM')) as growth_rate
from sales_data
group by format(order_date,'yyyy-MM');

-- Task 19: Customers whose total_amount > last order
select sale_id, customer_id, total_amount,
       case when total_amount > lag(total_amount) over(partition by customer_id order by order_date) then 1 else 0 end as higher_than_last
from sales_data;

----------------------------------------------------------
-- Hard Questions
----------------------------------------------------------

-- Task 20: Products above average price
select *
from sales_data
where unit_price > (select avg(unit_price) from sales_data);

-- Task 21: Sum Val1+Val2 at first row of group
create table MyData(Id int, Grp int, Val1 int, Val2 int);
insert into MyData values
(1,1,30,29),(2,1,19,0),(3,1,11,45),(4,2,0,0),(5,2,100,17);

select Id, Grp, Val1, Val2,
       case when row_number() over(partition by Grp order by Id)=1
            then sum(Val1+Val2) over(partition by Grp) end as Tot
from MyData;

-- Task 22: Puzzle - sum cost, quantity
create table TheSumPuzzle(Id int, Cost int, Quantity int);
insert into TheSumPuzzle values
(1234,12,164),(1234,13,164),(1235,100,130),(1235,100,135),(1236,12,136);

select Id, sum(Cost) as Cost, sum(Quantity) as Quantity
from TheSumPuzzle
group by Id;

-- Task 23: Seat Gaps
create table Seats(SeatNumber int);
insert into Seats values
(7),(13),(14),(15),(27),(28),(29),(30),(31),(32),(33),(34),(35),(52),(53),(54);

with ordered as (
    select SeatNumber,
           SeatNumber - row_number() over(order by SeatNumber) as grp
    from Seats
),
ranges as (
    select min(SeatNumber) as start_seat, max(SeatNumber) as end_seat
    from ordered
    group by grp
)
select lag(end_seat+1) over(order by start_seat) as GapStart,
       start_seat-1 as GapEnd
from ranges
where lag(end_seat+1) over(order by start_seat) is not null;
