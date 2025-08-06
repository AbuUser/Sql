/* ==========================================================
   1. Combine Two Tables
   Task: Show firstName, lastName, city, state from Person & Address
   ========================================================== */
select p.firstName, p.lastName, a.city, a.state
from Person p
left join Address a on p.personId = a.personId;


/* ==========================================================
   2. Employees Earning More Than Their Managers
   Task: Find employees who earn more than their manager
   ========================================================== */
select e.name as Employee
from Employee e
join Employee m on e.managerId = m.id
where e.salary > m.salary;


/* ==========================================================
   3. Duplicate Emails
   Task: Find all duplicate emails in the Person table
   ========================================================== */
select email
from Person
group by email
having count(*) > 1;


/* ==========================================================
   4. Delete Duplicate Emails
   Task: Remove duplicate emails, keep the smallest id
   ========================================================== */
delete p
from Person p
join Person q on p.email = q.email and p.id > q.id;


/* ==========================================================
   5. Find those parents who have only girls
   Task: Show parent names who have daughters but no sons
   ========================================================== */
select distinct g.ParentName
from girls g
where g.ParentName not in (select ParentName from boys);


/* ==========================================================
   6. Total over 50 and least (TSQL2012 – Sales.Orders)
   Task: For each customer, show total sales and minimum weight (only if weight > 50)
   ========================================================== */
select custid, sum(salesamount) as TotalSales, min(weight) as LeastWeight
from Sales.Orders
where weight > 50
group by custid;


/* ==========================================================
   7. Carts (FULL OUTER JOIN)
   Task: Combine Cart1 and Cart2 to show all items from both carts
   ========================================================== */
select c1.Item as [Item Cart 1], c2.Item as [Item Cart 2]
from Cart1 c1
full outer join Cart2 c2 on c1.Item = c2.Item;


/* ==========================================================
   8. Customers Who Never Order
   Task: Find customers who never placed an order
   ========================================================== */
select name as Customers
from Customers c
left join Orders o on c.id = o.customerId
where o.id is null;


/* ==========================================================
   9. Students and Examinations
   Task: For each student and subject, count attended exams
   ========================================================== */
select s.student_id, s.student_name, sub.subject_name, count(e.subject_name) as attended_exams
from Students s
cross join Subjects sub
left join Examinations e on s.student_id = e.student_id and sub.subject_name = e.subject_name
group by s.student_id, s.student_name, sub.subject_name
order by s.student_id, sub.subject_name;
