-- Lesson 3: Importing and Exporting Data (Human-like Style)

-- 1. Define and explain the purpose of BULK INSERT in SQL Server.
-- BULK INSERT bu katta hajmdagi fayldagi ma’lumotlarni jadvalga tezda yuklash uchun ishlatiladi.

-- 2. List four file formats that can be imported into SQL Server.
-- Masalan: .txt, .csv, .xls, .xlsx

-- 3. Create a table Products with required columns
create table Products (
    ProductID int primary key,
    ProductName varchar(50),
    Price decimal(10,2)
);

-- 4. Insert three records into the Products table
insert into Products values (1, 'Laptop', 999.99);
insert into Products values (2, 'Mouse', 19.99);
insert into Products values (3, 'Keyboard', 49.99);

-- 5. Explain the difference between NULL and NOT NULL.
-- NULL bu qiymat yo‘qligini bildiradi, NOT NULL esa qiymat majburiy kiritilishini bildiradi.

-- 6. Add UNIQUE constraint to ProductName
alter table Products
add constraint UQ_ProductName unique (ProductName);

-- 7. Write a comment in a SQL query explaining its purpose
-- Bu yerda Products jadvaliga yangi ustun qo‘shilmoqda

-- 8. Add CategoryID column to Products
alter table Products
add CategoryID int;

-- 9. Create Categories table
create table Categories (
    CategoryID int primary key,
    CategoryName varchar(50) unique
);

-- 10. Explain purpose of IDENTITY
-- IDENTITY ustun avtomatik tartib raqam beradi, har safar yangi qator qo‘shilganda.

-- 11. BULK INSERT (simple syntax, file format faraz qilinmoqda)
-- Fayl manzili misol tariqasida yozildi.
bulk insert Products
from 'C:\data\products.txt'
with (
    fieldterminator = ',',
    rowterminator = '\n'
);

-- 12. FOREIGN KEY yaratish
alter table Products
add constraint FK_Category foreign key (CategoryID)
references Categories(CategoryID);

-- 13. PRIMARY KEY va UNIQUE KEY farqlari
-- PRIMARY KEY bo‘sh bo‘lmaydi va yagona, UNIQUE esa faqat yagona bo‘lishi kerak, lekin bo‘sh bo‘lishi mumkin.

-- 14. CHECK constraint: Price > 0
alter table Products
add constraint CHK_Price check (Price > 0);

-- 15. Add column Stock with NOT NULL
alter table Products
add Stock int not null default 0;

-- 16. Replace NULL in Price with 0
select ProductID, ProductName, isnull(Price, 0) as Price
from Products;

-- 17. FOREIGN KEY maqsadi
-- FOREIGN KEY boshqa jadvaldagi ma’lumotlar bilan bog‘lanish uchun ishlatiladi, ma’lumotlar izchilligini saqlaydi.

-- 18. Customers jadvali va Age >= 18 bo‘lish sharti
create table Customers (
    CustomerID int primary key,
    FullName varchar(50),
    Age int check (Age >= 18)
);

-- 19. Jadval IDENTITY bilan (100 dan boshlanadi, 10 qo‘shiladi)
create table Codes (
    CodeID int identity(100,10) primary key,
    Description varchar(100)
);

-- 20. Composite PRIMARY KEY
create table OrderDetails (
    OrderID int,
    ProductID int,
    Quantity int,
    primary key (OrderID, ProductID)
);

-- 21. COALESCE va ISNULL farqi
-- Har ikkalasi NULL qiymatlarni boshqa qiymat bilan almashtiradi.
-- ISNULL bitta qiymatga ishlaydi, COALESCE bir nechta qiymat ichidan birinchisini oladi.

-- 22. Employees jadvali: PRIMARY va UNIQUE
create table Employees (
    EmpID int primary key,
    FullName varchar(100),
    Email varchar(100) unique
);

-- 23. FOREIGN KEY with cascade
create table Orders (
    OrderID int primary key,
    CustomerID int,
    foreign key (CustomerID) references Customers(CustomerID)
    on delete cascade
    on update cascade
);
