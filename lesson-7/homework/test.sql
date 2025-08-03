-- Lesson 7: Aggregation Functions and Grouping
-- 1. Employees jadvalidan eng kichik ish haqini topish
select min(Salary) as MinSalary from Employees;

-- 2. Employees jadvalidan eng katta ish haqini topish
select max(Salary) as MaxSalary from Employees;

-- 3. Employees jadvalidan barcha ishchilarning umumiy ish haqini hisoblash
select sum(Salary) as TotalSalary from Employees;

-- 4. Employees jadvalidan ishchilarning o'rtacha ish haqini hisoblash
select avg(Salary) as AverageSalary from Employees;

-- 5. Employees jadvalidan jami ishchilar sonini aniqlash
select count(*) as EmployeeCount from Employees;

-- 6. Products jadvalidan eng arzon mahsulot narxini topish
select min(Price) as MinProductPrice from Products;

-- 7. Products jadvalidan eng qimmat mahsulot narxini topish
select max(Price) as MaxProductPrice from Products;

-- 8. Products jadvalidan barcha mahsulotlarning umumiy narxini topish
select sum(Price) as TotalProductsPrice from Products;

-- 9. Products jadvalidan mahsulotlarning o'rtacha narxini hisoblash
select avg(Price) as AverageProductPrice from Products;

-- 10. Customers jadvalidan jami mijozlar sonini hisoblash
select count(*) as CustomerCount from Customers;

-- 11. Employees jadvalidan har bir lavozim bo'yicha ishchilar sonini ko'rsatish
select Position, count(*) as EmployeeCount from Employees group by Position;

-- 12. Employees jadvalidan har bir lavozim bo'yicha o'rtacha ish haqini hisoblash
select Position, avg(Salary) as AvgSalary from Employees group by Position;

-- 13. Employees jadvalidan har bir lavozim bo'yicha eng katta ish haqini aniqlash
select Position, max(Salary) as MaxSalary from Employees group by Position;

-- 14. Products jadvalidan har bir kategoriya bo'yicha mahsulotlar sonini ko'rsatish
select Category, count(*) as ProductCount from Products group by Category;

-- 15. Products jadvalidan har bir kategoriya bo'yicha eng qimmat mahsulot narxini topish
select Category, max(Price) as MaxPrice from Products group by Category;

-- 16. Products jadvalidan har bir kategoriya bo'yicha umumiy narxni hisoblash
select Category, sum(Price) as TotalPrice from Products group by Category;

-- 17. Sales jadvalidan har bir mijoz bo'yicha jami sotuvlar summasini ko'rsatish
select CustomerID, sum(Amount) as TotalSales from Sales group by CustomerID;

-- 18. Sales jadvalidan har bir mijoz bo'yicha o'rtacha sotuv summasini ko'rsatish
select CustomerID, avg(Amount) as AverageSale from Sales group by CustomerID;

-- 19. Orders jadvalidan har bir mijoz bo'yicha nechta buyurtma berganini ko'rsatish
select CustomerID, count(*) as OrderCount from Orders group by CustomerID;

-- 20. Orders jadvalidan har bir mijoz bo'yicha jami buyurtma summasini hisoblash
select CustomerID, sum(TotalAmount) as TotalOrderAmount from Orders group by CustomerID;

-- 21. Employees jadvalidan faqat ishchilar soni 2 tadan ortiq bo'lgan lavozimlarni chiqarish
select Position, count(*) as EmployeeCount from Employees group by Position having count(*) > 2;

-- 22. Products jadvalidan faqat umumiy narxi 5000 dan ortiq bo'lgan kategoriyalarni chiqarish
select Category, sum(Price) as TotalPrice from Products group by Category having sum(Price) > 5000;

-- 23. Sales jadvalidan faqat jami sotuvlari 10000 dan oshgan mijozlarni chiqarish
select CustomerID, sum(Amount) as TotalSales from Sales group by CustomerID having sum(Amount) > 10000;

-- 24. Orders jadvalidan faqat jami buyurtma summasi 15000 dan oshgan mijozlarni chiqarish
select CustomerID, sum(TotalAmount) as TotalAmount from Orders group by CustomerID having sum(TotalAmount) > 15000;

-- 25. Employees jadvalidan o'rtacha ish haqi 3000 dan katta bo'lgan lavozimlarni chiqarish
select Position, avg(Salary) as AvgSalary from Employees group by Position having avg(Salary) > 3000;
