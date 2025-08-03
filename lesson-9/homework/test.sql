-- Lesson 9: JOINS (INNER JOIN, CROSS JOIN, ON filtering)  
-- Abdulaziz style: handwritten, queries yonma-yon yoki pastida davom etadi.

------------------------------------------------------
-- Task 1: Employees va Orders jadvalini INNER JOIN qilib, har bir buyurtma kim tomonidan qabul qilinganini ko‘rsatish
select e.EmployeeID, e.FirstName, e.LastName, o.OrderID, o.OrderDate  
from Employees e inner join Orders o on e.EmployeeID = o.EmployeeID;

------------------------------------------------------
-- Task 2: Har bir Order uchun mijozning ismi bilan ko‘rsatish (Customers bilan join)
select o.OrderID, o.OrderDate, c.CustomerName, c.City  
from Orders o inner join Customers c on o.CustomerID = c.CustomerID;

------------------------------------------------------
-- Task 3: Har bir buyurtmadagi mahsulotlarni ko‘rsatish (Orders va Products)
select o.OrderID, p.ProductName, p.Price  
from Orders o inner join Products p on o.ProductID = p.ProductID;

------------------------------------------------------
-- Task 4: Orders + Customers + Employees (3 ta jadvalni birlashtirish)
select o.OrderID, c.CustomerName, e.FirstName, e.LastName  
from Orders o inner join Customers c on o.CustomerID = c.CustomerID  
inner join Employees e on o.EmployeeID = e.EmployeeID;

------------------------------------------------------
-- Task 5: Har bir buyurtma uchun mijoz shahri va xodim ismini ko‘rsatish
select o.OrderID, c.City, e.FirstName  
from Orders o inner join Customers c on o.CustomerID = c.CustomerID  
inner join Employees e on o.EmployeeID = e.EmployeeID;

------------------------------------------------------
-- Task 6: CROSS JOIN misoli (Products va Customers kombinatsiyasi)
select c.CustomerName, p.ProductName  
from Customers c cross join Products p;

------------------------------------------------------
-- Task 7: Har bir xodim sotgan umumiy mahsulotlar ro‘yxati (INNER JOIN bilan)
select distinct e.EmployeeID, e.FirstName, p.ProductName  
from Employees e inner join Orders o on e.EmployeeID = o.EmployeeID  
inner join Products p on o.ProductID = p.ProductID;

------------------------------------------------------
-- Task 8: Har bir mijoz nechta buyurtma qilgan (INNER JOIN + COUNT)
select c.CustomerName, count(o.OrderID) as TotalOrders  
from Customers c inner join Orders o on c.CustomerID = o.CustomerID  
group by c.CustomerName;

------------------------------------------------------
-- Task 9: Har bir xodim nechta buyurtmani qabul qilgan
select e.FirstName, e.LastName, count(o.OrderID) as OrderCount  
from Employees e inner join Orders o on e.EmployeeID = o.EmployeeID  
group by e.FirstName, e.LastName;

------------------------------------------------------
-- Task 10: Eng qimmat mahsulotni olgan mijoz ismi
select top 1 c.CustomerName, p.ProductName, p.Price  
from Orders o inner join Customers c on o.CustomerID = c.CustomerID  
inner join Products p on o.ProductID = p.ProductID  
order by p.Price desc;

------------------------------------------------------
-- Task 11: Xodimlar va ularning sotgan mahsulot narxlarini ko‘rsatish
select e.FirstName, p.ProductName, p.Price  
from Employees e inner join Orders o on e.EmployeeID = o.EmployeeID  
inner join Products p on o.ProductID = p.ProductID;

------------------------------------------------------
-- Task 12: Har bir mahsulot nechta buyurtmada borligini aniqlash
select p.ProductName, count(o.OrderID) as OrderCount  
from Products p inner join Orders o on p.ProductID = o.ProductID  
group by p.ProductName;

------------------------------------------------------
-- Task 13: Har bir mijoz uchun eng oxirgi buyurtma sanasini ko‘rsatish
select c.CustomerName, max(o.OrderDate) as LastOrderDate  
from Customers c inner join Orders o on c.CustomerID = o.CustomerID  
group by c.CustomerName;

------------------------------------------------------
-- Task 14: Har bir xodim uchun eng qimmat sotgan mahsuloti
select e.FirstName, max(p.Price) as MaxSoldPrice  
from Employees e inner join Orders o on e.EmployeeID = o.EmployeeID  
inner join Products p on o.ProductID = p.ProductID  
group by e.FirstName;

------------------------------------------------------
-- Task 15: Sales jadvalini Orders bilan birlashtirib, har bir buyurtmaning summasini ko‘rsatish
select o.OrderID, s.Quantity * p.Price as TotalPrice  
from Sales s inner join Orders o on s.OrderID = o.OrderID  
inner join Products p on o.ProductID = p.ProductID;

------------------------------------------------------
-- Task 16: Har bir mijoz qancha pul sarflagan (SUM)
select c.CustomerName, sum(p.Price * s.Quantity) as TotalSpent  
from Customers c inner join Orders o on c.CustomerID = o.CustomerID  
inner join Sales s on s.OrderID = o.OrderID  
inner join Products p on o.ProductID = p.ProductID  
group by c.CustomerName;

------------------------------------------------------
-- Task 17: Har bir xodim qancha savdo qilgan
select e.FirstName, sum(p.Price * s.Quantity) as TotalSales  
from Employees e inner join Orders o on e.EmployeeID = o.EmployeeID  
inner join Sales s on s.OrderID = o.OrderID  
inner join Products p on o.ProductID = p.ProductID  
group by e.FirstName;

------------------------------------------------------
-- Task 18: Har bir mahsulotdan umumiy qancha sotilganini hisoblash
select p.ProductName, sum(s.Quantity) as TotalQuantity  
from Products p inner join Orders o on p.ProductID = o.ProductID  
inner join Sales s on s.OrderID = o.OrderID  
group by p.ProductName;

------------------------------------------------------
-- Task 19: Eng ko‘p buyurtma qilgan mijozni topish
select top 1 c.CustomerName, count(o.OrderID) as OrderCount  
from Customers c inner join Orders o on c.CustomerID = o.CustomerID  
group by c.CustomerName  
order by OrderCount desc;

------------------------------------------------------
-- Task 20: Eng ko‘p sotuv qilgan xodimni topish
select top 1 e.FirstName, count(o.OrderID) as OrdersHandled  
from Employees e inner join Orders o on e.EmployeeID = o.EmployeeID  
group by e.FirstName  
order by OrdersHandled desc;

------------------------------------------------------
-- Task 21: Har bir mijozning har bir mahsulot bo‘yicha qancha sotib olganini ko‘rsatish
select c.CustomerName, p.ProductName, sum(s.Quantity) as TotalQty  
from Customers c inner join Orders o on c.CustomerID = o.CustomerID  
inner join Products p on o.ProductID = p.ProductID  
inner join Sales s on s.OrderID = o.OrderID  
group by c.CustomerName, p.ProductName;

------------------------------------------------------
-- Task 22: Har bir buyurtmada nechta mahsulot borligini aniqlash
select o.OrderID, count(p.ProductID) as ProductCount  
from Orders o inner join Products p on o.ProductID = p.ProductID  
group by o.OrderID;

------------------------------------------------------
-- Task 23: Xodimlar qaysi shahardagi mijozlarga xizmat ko‘rsatganini ko‘rsatish
select distinct e.FirstName, c.City  
from Employees e inner join Orders o on e.EmployeeID = o.EmployeeID  
inner join Customers c on o.CustomerID = c.CustomerID;

------------------------------------------------------
-- Task 24: CROSS JOIN bilan Employees va Products kombinatsiyasi
select e.FirstName, p.ProductName  
from Employees e cross join Products p;

------------------------------------------------------
-- Task 25: Customers va Employees o‘rtasida barcha kombinatsiyalarni CROSS JOIN bilan chiqarish
select c.CustomerName, e.FirstName  
from Customers c cross join Employees e;
