-- 1. 'students' nomli jadval yarating
create table students (
    id int primary key,
    full_name nvarchar(100),
    birth_year int,
    course int
);

-- 2. 'students' jadvaliga 5 ta yozuv qo‘shing
insert into students (id, full_name, birth_year, course) values
(1, 'Ali Karimov', 2002, 2),
(2, 'Laylo Rasulova', 2001, 3),
(3, 'Sanjar Qodirov', 2003, 1),
(4, 'Dilorom Abdullayeva', 2002, 2),
(5, 'Sherzod Mahkamov', 2000, 4);

-- 3. Tug‘ilgan yili 2002 bo‘lgan talabalarni tanlang
select * from students
where birth_year = 2002;

-- 4. Kursi 3 dan katta bo‘lganlarni tanlang
select * from students
where course > 3;

-- 5. Tug‘ilgan yili 2001 yoki 2003 bo‘lgan talabalarni chiqarish
select * from students
where birth_year in (2001, 2003);

-- 6. Faqat 2-kursdagi talabalarni chiqaring
select * from students
where course = 2;

-- 7. 2001-yilda tug‘ilgan va 3-kursda o‘qiyotganlar
select * from students
where birth_year = 2001 and course = 3;

-- 8. Familiyasi 'ov' bilan tugaydigan talabalarni tanlang
select * from students
where full_name like '%ov';

-- 9. Familiyasi 'A' harfi bilan boshlanadiganlar
select * from students
where full_name like 'A%';

-- 10. Tug‘ilgan yili 2001 yildan katta bo‘lganlar
select * from students
where birth_year > 2001;

-- 11. 'students' jadvalidagi barcha yozuvlarni tug‘ilgan yili bo‘yicha o‘sish tartibida chiqarish
select * from students
order by birth_year asc;

-- 12. Talabalarni kurs bo‘yicha kamayish tartibida chiqarish
select * from students
order by course desc;

-- 13. Familiya bo‘yicha alifbo tartibida chiqaring
select * from students
order by full_name asc;

-- 14. Faqat ismi 'Sanjar' bo‘lgan talabani toping
select * from students
where full_name like 'Sanjar%';

-- 15. 2 va 3-kursdagi talabalarni chiqaring
select * from students
where course in (2, 3);

-- 16. Tug‘ilgan yili 2001 va 2003 oralig‘ida bo‘lganlar
select * from students
where birth_year between 2001 and 2003;

-- 17. Familiyasida 'or' bo‘lgan talabalarni chiqaring
select * from students
where full_name like '%or%';

-- 18. Tug‘ilgan yili 2000 emas bo‘lganlar
select * from students
where birth_year != 2000;

-- 19. 1-kursdan tashqari barcha talabalarni tanlang
select * from students
where course <> 1;

-- 20. Faqat eng yoshi katta talabani chiqarish (minimal tug‘ilgan yili)
select top 1 * from students
order by birth_year asc;

-- 21. Eng yoshi kichik talaba (eng katta tug‘ilgan yili)
select top 1 * from students
order by birth_year desc;

-- 22. Talabalarni kurs va tug‘ilgan yili bo‘yicha tartiblash
select * from students
order by course asc, birth_year desc;

-- 23. 2001-yilda tug‘ilgan, lekin 2-kursda bo‘lmagan talabalar
select * from students
where birth_year = 2001 and course != 2;

-- 24. Familiyasida 'm' harfi bor va 4-kursda o‘qiydiganlar
select * from students
where full_name like '%m%' and course = 4;

-- 25. Familiyasi 'ov' bilan tugamaydigan talabalarni chiqaring
select * from students
where full_name not like '%ov';
