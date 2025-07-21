-- Lesson-6: Practice Tasks
-- Author: Abdulaziz uchun
-- Platform: SQL Server

---------------------------------------------------------------
-- Puzzle 1: Finding Distinct Values (2 ta yechim)
---------------------------------------------------------------

-- Jadval yaratish va ma'lumot kiritish
create table InputTbl (
    col1 varchar(10),
    col2 varchar(10)
);

insert into InputTbl (col1, col2) values
('a', 'b'),
('a', 'b'),
('b', 'a'),
('c', 'd'),
('c', 'd'),
('m', 'n'),
('n', 'm');

-- 1-usul: iif() orqali kichik-katta tartibda ajratish
select distinct 
    iif(col1 < col2, col1, col2) as col1,
    iif(col1 < col2, col2, col1) as col2
from InputTbl;

-- 2-usul: case orqali kichik-katta tartibda ajratish
select distinct 
    case when col1 < col2 then col1 else col2 end as col1,
    case when col1 < col2 then col2 else col1 end as col2
from InputTbl;


---------------------------------------------------------------
-- Puzzle 2: Removing Rows with All Zeroes
---------------------------------------------------------------

-- Jadval yaratish va ma'lumot kiritish
create table TestMultipleZero (
    a int null,
    b int null,
    c int null,
    d int null
);

insert into TestMultipleZero (a, b, c, d) values
(0,0,0,1),
(0,0,1,0),
(0,1,0,0),
(1,0,0,0),
(0,0,0,0),
(1,1,1,0);

-- Hammasi 0 bo'lgan qatorlarni chiqarib tashlash
select * from TestMultipleZero
where a + b + c + d <> 0;


---------------------------------------------------------------
-- Puzzle 3: Find those with odd ids
---------------------------------------------------------------

-- Jadval yaratish va ma'lumot kiritish
create table section1 (
    id int,
    name varchar(20)
);

insert into section1 values
(1, 'Been'),
(2, 'Roma'),
(3, 'Steven'),
(4, 'Paulo'),
(5, 'Genryh'),
(6, 'Bruno'),
(7, 'Fred'),
(8, 'Andro');

-- Toq id egalari
select * from section1
where id % 2 = 1;


---------------------------------------------------------------
-- Puzzle 4: Person with the smallest id
---------------------------------------------------------------

select top 1 * from section1
order by id asc;


---------------------------------------------------------------
-- Puzzle 5: Person with the highest id
---------------------------------------------------------------

select top 1 * from section1
order by id desc;


---------------------------------------------------------------
-- Puzzle 6: People whose name starts with b
---------------------------------------------------------------

select * from section1
where name like 'b%';


---------------------------------------------------------------
-- Puzzle 7: Code contains underscore (_) literally
---------------------------------------------------------------

-- Jadval yaratish va ma'lumot kiritish
create table ProductCodes (
    code varchar(20)
);

insert into ProductCodes (code) values
('X-123'),
('X_456'),
('X#789'),
('X-001'),
('X%202'),
('X_ABC'),
('X#DEF'),
('X-999');

-- Underscore _ belgisi mavjud bo'lgan qatorlar
select * from ProductCodes
where code like '%\_%' escape '\';
