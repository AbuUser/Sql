-- Module-2, Lesson-13
-- Math Functions va String Functions
create database Lesson13_MathString
use Lesson13_MathString

-- Jadval yaratamiz
create table Employees (
    EmployeeID int primary key,
    FirstName nvarchar(50),
    LastName nvarchar(50),
    Salary money,
    BonusPercent decimal(5,2)
)
insert into Employees values
(1, 'John', 'Doe', 50000, 10.5),
(2, 'Jane', 'Smith', 60000, 8.25),
(3, 'Michael', 'Johnson', 75000, 12.75),
(4, 'Emily', 'Davis', 45000, 9.00),
(5, 'Daniel', 'Brown', 70000, 11.50)

create table Products (
    ProductID int primary key,
    ProductName nvarchar(50),
    Price decimal(10,2),
    DiscountPercent decimal(5,2)
)
insert into Products values
(101, 'Laptop', 1200.50, 10.0),
(102, 'Phone', 850.00, 5.5),
(103, 'Tablet', 600.75, 8.25),
(104, 'Monitor', 300.40, 12.0),
(105, 'Keyboard', 50.99, 7.5)

-- =========================
-- EASY
-- =========================

-- 1. Pi sonini chiqarish
select pi() as PiValue

-- 2. Har bir mahsulot narxini eng yaqin butun songa yaxlitlash
select ProductName, round(Price, 0) as RoundedPrice from Products

-- 3. Xodim bonus foizini tepaga yaxlitlash
select FirstName, ceil(BonusPercent) as BonusCeil from Employees

-- 4. Xodim bonus foizini pastga yaxlitlash
select FirstName, floor(BonusPercent) as BonusFloor from Employees

-- 5. Har bir mahsulotning chegirmadan keyingi narxi
select ProductName, Price, DiscountPercent,
Price - (Price * DiscountPercent / 100) as PriceAfterDiscount from Products

-- 6. Kvadrat ildiz topish
select sqrt(144) as SqrtExample

-- 7. Tasodifiy son olish
select rand() as RandomValue

-- 8. Ma'lumot uzunligi (ism uzunligi)
select FirstName, len(FirstName) as NameLength from Employees

-- 9. Ismni katta harflarga o‘tkazish
select FirstName, upper(FirstName) as UpperName from Employees

-- 10. Familiyani kichik harflarga o‘tkazish
select LastName, lower(LastName) as LowerName from Employees

-- =========================
-- MEDIUM
-- =========================

-- 1. Har bir xodimning bonus summasini hisoblash
select FirstName, Salary, BonusPercent,
round(Salary * BonusPercent / 100, 2) as BonusAmount from Employees

-- 2. Mahsulot narxini 2 decimalgacha yaxlitlash
select ProductName, round(Price, 2) as RoundedPrice from Products

-- 3. Musbat va manfiy qiymatning absolyut qiymati
select abs(-250) as AbsExample1, abs(350) as AbsExample2

-- 4. Har bir mahsulot narxining kvadrat ildizi
select ProductName, sqrt(Price) as PriceSqrt from Products

-- 5. Tasodifiy sonni 1 dan 100 gacha olish
select cast(rand() * 100 as int) + 1 as Random1to100

-- 6. Ismning birinchi 3 harfini olish
select FirstName, left(FirstName, 3) as First3Letters from Employees

-- 7. Familiyaning oxirgi 2 harfini olish
select LastName, right(LastName, 2) as Last2Letters from Employees

-- 8. Ism va familiyani bitta ustunda chiqarish
select FirstName + ' ' + LastName as FullName from Employees

-- 9. Mahsulot nomidan bo‘sh joylarni olib tashlash
select rtrim(ltrim(ProductName)) as TrimmedName from Products

-- 10. Mahsulot narxini valyuta formatida chiqarish
select ProductName, format(Price, 'C', 'en-US') as PriceCurrency from Products

-- =========================
-- DIFFICULT
-- =========================

-- 1. Xodimning bonusdan keyingi umumiy maoshi (yaxlitlab)
select FirstName, round(Salary + (Salary * BonusPercent / 100), 2) as TotalWithBonus from Employees

-- 2. Har bir mahsulot narxini 15% oshirib, eng yaqin butunga yaxlitlash
select ProductName, ceil(Price * 1.15) as IncreasedPrice from Products

-- 3. Tasodifiy mahsulot tanlash
select top 1 ProductName from Products order by newid()

-- 4. Mahsulot nomini teskari yozish
select ProductName, reverse(ProductName) as ReversedName from Products

-- 5. Familiyadagi 'o' harfini '0' bilan almashtirish
select LastName, replace(LastName, 'o', '0') as ReplacedName from Employees

-- 6. Xodim familiyasi uzunligi bo‘yicha saralash
select FirstName, LastName, len(LastName) as LastNameLength from Employees order by len(LastName) desc

-- 7. Har bir xodimning ismi va familiyasi uzunligining yig‘indisi
select FirstName, LastName, len(FirstName) + len(LastName) as TotalLength from Employees

-- 8. Mahsulot narxini butun va kasr qismiga ajratish
select ProductName, floor(Price) as IntegerPart, Price - floor(Price) as FractionPart from Products

-- 9. Xodim ism-familiyasini bosh harflar bilan chiqarish (John Doe -> J.D.)
select FirstName, LastName, left(FirstName, 1) + '.' + left(LastName, 1) + '.' as Initials from Employees

-- 10. Har bir mahsulot narxini kvadrat va kubini hisoblash
select ProductName, power(Price, 2) as PriceSquare, power(Price, 3) as PriceCube from Products
