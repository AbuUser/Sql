-- Simple iPhone Price DB for SQL Server

CREATE DATABASE SimpleIphonePriceDB;
GO

USE SimpleIphonePriceDB;
GO

CREATE TABLE Brands (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Models (
    id INT IDENTITY(1,1) PRIMARY KEY,
    brand_id INT,
    model_name VARCHAR(100),
    release_year INT
);

CREATE TABLE Storage (
    id INT IDENTITY(1,1) PRIMARY KEY,
    model_name VARCHAR(100),
    capacity_gb INT
);

CREATE TABLE Colors (
    id INT IDENTITY(1,1) PRIMARY KEY,
    model_name VARCHAR(100),
    color VARCHAR(30)
);

CREATE TABLE Prices (
    id INT IDENTITY(1,1) PRIMARY KEY,
    model_name VARCHAR(100),
    storage_gb INT,
    color VARCHAR(30),
    price_usd DECIMAL(10,2)
);

INSERT INTO Brands (name) VALUES
('Apple'),
('Samsung'),
('Xiaomi'),
('Huawei'),
('Nokia'),
('OnePlus'),
('Google'),
('Sony'),
('HTC'),
('Motorola');

INSERT INTO Models (brand_id, model_name, release_year) VALUES
(1, 'iPhone 15 Pro Max', 2023),
(1, 'iPhone 15', 2023),
(1, 'iPhone 14 Pro', 2022),
(1, 'iPhone 13', 2021),
(1, 'iPhone 12', 2020),
(1, 'iPhone 11', 2019),
(1, 'iPhone XR', 2018),
(1, 'iPhone X', 2017),
(1, 'iPhone 8 Plus', 2017),
(1, 'iPhone SE 2022', 2022);

INSERT INTO Storage (model_name, capacity_gb) VALUES
('iPhone 15 Pro Max', 128),
('iPhone 15 Pro Max', 256),
('iPhone 15', 128),
('iPhone 14 Pro', 256),
('iPhone 13', 128),
('iPhone 12', 64),
('iPhone 11', 64),
('iPhone XR', 128),
('iPhone X', 64),
('iPhone SE 2022', 64);

INSERT INTO Colors (model_name, color) VALUES
('iPhone 15 Pro Max', 'Black'),
('iPhone 15 Pro Max', 'White'),
('iPhone 15', 'Blue'),
('iPhone 14 Pro', 'Gold'),
('iPhone 13', 'Red'),
('iPhone 12', 'Green'),
('iPhone 11', 'Purple'),
('iPhone XR', 'Black'),
('iPhone X', 'Silver'),
('iPhone SE 2022', 'White');

INSERT INTO Prices (model_name, storage_gb, color, price_usd) VALUES
('iPhone 15 Pro Max', 128, 'Black', 1299.99),
('iPhone 15 Pro Max', 256, 'White', 1399.99),
('iPhone 15', 128, 'Blue', 899.99),
('iPhone 14 Pro', 256, 'Gold', 1099.99),
('iPhone 13', 128, 'Red', 799.99),
('iPhone 12', 64, 'Green', 599.99),
('iPhone 11', 64, 'Purple', 499.99),
('iPhone XR', 128, 'Black', 399.99),
('iPhone X', 64, 'Silver', 349.99),
('iPhone SE 2022', 64, 'White', 429.99);
