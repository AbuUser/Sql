
-- Database: tech_store_db

-- Drop tables if they exist
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS order_items;

-- Create tables
CREATE TABLE customers (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    address TEXT
);

CREATE TABLE categories (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE products (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    category_id INTEGER,
    price DECIMAL(10,2),
    stock INTEGER,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE orders (
    id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_items (
    id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert into customers
INSERT INTO customers (id, name, email, address) VALUES
(1,'Ali Akbarov','ali.akb@example.com','Toshkent, Chilonzor'),
(2,'Vali Ergashev','vali.erg@example.com','Toshkent, Yunusobod'),
(3,'Gulnora Sobirova','gulnora.s@example.com','Toshkent, Mirzo Ulug‘bek'),
(4,'Dilshod Davronov','dilshod.d@example.com','Toshkent, Shayxontohur'),
(5,'Malika Isroilova','malika.i@example.com','Toshkent, Sergeli'),
(6,'Jasur Qodirov','jasur.q@example.com','Toshkent, Yashnobod'),
(7,'Nigora Tursunova','nigora.t@example.com','Toshkent, Uchtepa'),
(8,'Zafar Norboyev','zafar.n@example.com','Toshkent, Yunusobod'),
(9,'Shahnoza Karimova','shahnoza.k@example.com','Toshkent, Chilonzor'),
(10,'Kamron Rustamov','kamron.r@example.com','Toshkent, Mirobod');

-- Insert into categories
INSERT INTO categories (id, name) VALUES
(1,'Smartfon'),
(2,'Noutbuk'),
(3,'Planshet'),
(4,'Televizor'),
(5,'Quloqchin'),
(6,'Smart soat'),
(7,'Foto kamera'),
(8,'Printer'),
(9,'Router'),
(10,'Power bank');

-- Insert into products
INSERT INTO products (id,name,category_id,price,stock) VALUES
(1,'iPhone 14 Pro',1,999.00,15),
(2,'Samsung Galaxy S23',1,899.00,20),
(3,'Xiaomi Redmi Note 13',1,279.00,30),
(4,'MacBook Pro 14"',2,1999.00,10),
(5,'Dell XPS 13',2,1299.00,12),
(6,'iPad Air',3,599.00,18),
(7,'Samsung Galaxy Tab S9',3,649.00,14),
(8,'LG OLED TV 55"',4,1299.00,8),
(9,'Sony Bravia 50"',4,999.00,10),
(10,'AirPods Pro 2',5,249.00,25);

-- Insert into orders
INSERT INTO orders (id,customer_id,order_date,total_amount) VALUES
(1,1,'2025-06-20',1248.00),
(2,2,'2025-06-22',899.00),
(3,3,'2025-06-23',1999.00),
(4,4,'2025-06-24',2848.00),
(5,5,'2025-06-25',849.00),
(6,6,'2025-06-26',1248.00),
(7,7,'2025-06-27',279.00),
(8,8,'2025-06-28',1848.00),
(9,9,'2025-06-29',2548.00),
(10,10,'2025-06-30',999.00);

-- Insert into order_items
INSERT INTO order_items (id,order_id,product_id,quantity,unit_price) VALUES
(1,1,1,1,999.00),
(2,1,10,1,249.00),
(3,2,2,1,899.00),
(4,3,4,1,1999.00),
(5,4,4,1,1999.00),
(6,4,6,1,599.00),
(7,5,7,1,649.00),
(8,6,10,5,249.00),
(9,7,3,1,279.00),
(10,8,5,1,1299.00),
(11,8,10,1,249.00),
(12,9,8,1,1299.00),
(13,9,2,1,899.00),
(14,10,9,1,999.00);
