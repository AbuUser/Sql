-- Lesson 14 - String va Date/Time functions
-- Easy 1: Har bir xodimning familiyasini katta harflarda chiqarish
select upper(last_name) as fam_katta from employees
-- Easy 2: Mahsulot nomini kichik harflarda chiqarish
select lower(product_name) as mahsulot_kichik from products
-- Easy 3: Mijozlarning ism va familiyasini bitta ustunda, probel bilan ajratib chiqarish
select concat(first_name, ' ', last_name) as full_name from customers
-- Easy 4: Mahsulot nomining faqat birinchi 5 ta harfini ko‘rsatish
select left(product_name, 5) as qisqa_nomi from products
-- Easy 5: Mijoz telefon raqamidan bo‘sh joylarni olib tashlash
select ltrim(rtrim(phone)) as toza_phone from customers

-- Medium 1: Har bir buyurtma sanasini "YYYY-MM" formatida ko‘rsatish
select format(order_date, 'yyyy-MM') as yil_oy from orders
-- Medium 2: Mijozning tug‘ilgan kunidan faqat oy nomini chiqarish
select datename(month, birth_date) as tugilgan_oy from customers
-- Medium 3: Har bir sotuv sanasidan faqat yilni olish
select year(sale_date) as yil from sales
-- Medium 4: Xodim ismida nechta harf borligini hisoblash
select first_name, len(first_name) as ism_uzunligi from employees
-- Medium 5: Har bir buyurtma sanasiga 10 kun qo‘shib chiqarish
select dateadd(day, 10, order_date) as plus_10_days from orders

-- Difficult 1: Har bir mijozning yoshini hisoblash (yil bo‘yicha)
select first_name, last_name, datediff(year, birth_date, getdate()) as yosh from customers
-- Difficult 2: Har bir xodim ismida "a" harfi nechanchi pozitsiyada ekanligini topish
select first_name, charindex('a', lower(first_name)) as a_pozitsiya from employees
-- Difficult 3: Mahsulot nomi "Pro" bilan boshlanadiganlarni chiqarish
select product_name from products where left(product_name, 3) = 'Pro'
-- Difficult 4: Har bir sotuv sanasini hafta kuni nomi bilan chiqarish
select sale_date, datename(weekday, sale_date) as hafta_kuni from sales
-- Difficult 5: Mijozning ismi va familiyasini 20 belgilik maydonda, chapga joylashtirib chiqarish
select left(concat(first_name, ' ', last_name) + replicate(' ', 20), 20) as fixed_width_name from customers
