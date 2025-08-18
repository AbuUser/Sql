-- 1. Find Employees with Minimum Salary
select * from employees e where e.salary = (select min(salary) from employees);

-- 2. Find Products Above Average Price
select * from products p where p.price > (select avg(price) from products);

-- 3. Find Employees in Sales Department
select * from employees e where e.department_id = (select d.id from departments d where d.department_name = 'Sales');

-- 4. Find Customers with No Orders
select * from customers c where not exists (select 1 from orders o where o.customer_id = c.customer_id);

-- 5. Find Products with Max Price in Each Category
select * from products p where p.price = (select max(p2.price) from products p2 where p2.category_id = p.category_id);

-- 6. Find Employees in Department with Highest Average Salary
select * from employees e where e.department_id = (
    select top 1 d.department_id
    from employees d
    group by d.department_id
    order by avg(d.salary) desc
);

-- 7. Find Employees Earning Above Department Average
select * from employees e where e.salary > (
    select avg(e2.salary) from employees e2 where e2.department_id = e.department_id
);

-- 8. Find Students with Highest Grade per Course
select s.student_id, s.name, g.course_id, g.grade
from students s join grades g on s.student_id = g.student_id
where g.grade = (
    select max(g2.grade) from grades g2 where g2.course_id = g.course_id
);

-- 9. Find Third-Highest Price per Category
select * from products p where 2 = (
    select count(distinct p2.price) from products p2
    where p2.category_id = p.category_id and p2.price > p.price
);

-- 10. Find Employees whose Salary Between Company Average and Department Max Salary
select * from employees e
where e.salary > (select avg(salary) from employees)
  and e.salary < (select max(e2.salary) from employees e2 where e2.department_id = e.department_id);
