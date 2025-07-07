
-- DATABASE: iphone_prices_db

-- TABLE: models
CREATE TABLE models (
    id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    release_year INTEGER,
    base_storage_gb INTEGER
);

INSERT INTO models VALUES
(1, 'iPhone 11', 2019, 64),
(2, 'iPhone 12', 2020, 64),
(3, 'iPhone 13', 2021, 128),
(4, 'iPhone 14', 2022, 128),
(5, 'iPhone 15', 2023, 128),
(6, 'iPhone 11 Pro', 2019, 64),
(7, 'iPhone 12 Pro', 2020, 128),
(8, 'iPhone 13 Pro', 2021, 128),
(9, 'iPhone 14 Pro', 2022, 128),
(10, 'iPhone 15 Pro', 2023, 128);

-- TABLE: storages
CREATE TABLE storages (
    id INTEGER PRIMARY KEY,
    storage_gb INTEGER,
    price_multiplier REAL
);

INSERT INTO storages VALUES
(1, 64, 1.00),
(2, 128, 1.10),
(3, 256, 1.20),
(4, 512, 1.35),
(5, 1024, 1.50),
(6, 32, 0.90),
(7, 16, 0.75),
(8, 2000, 1.70),
(9, 3000, 2.00),
(10, 4000, 2.50);

-- TABLE: stores
CREATE TABLE stores (
    id INTEGER PRIMARY KEY,
    store_name TEXT,
    location TEXT
);

INSERT INTO stores VALUES
(1, 'iStore Tashkent', 'Tashkent City'),
(2, 'Apple Center', 'Tashkent City'),
(3, 'Media Park', 'Samarkand'),
(4, 'GoodZone', 'Tashkent City'),
(5, 'Texnomart', 'Bukhara'),
(6, 'iGadget', 'Namangan'),
(7, 'GMobile', 'Fergana'),
(8, 'ElectroMarket', 'Andijan'),
(9, 'TechnoLife', 'Nukus'),
(10, 'Phone World', 'Qarshi');

-- TABLE: prices
CREATE TABLE prices (
    id INTEGER PRIMARY KEY,
    model_id INTEGER,
    storage_id INTEGER,
    store_id INTEGER,
    price_usd REAL,
    date DATE,
    FOREIGN KEY(model_id) REFERENCES models(id),
    FOREIGN KEY(storage_id) REFERENCES storages(id),
    FOREIGN KEY(store_id) REFERENCES stores(id)
);

INSERT INTO prices VALUES
(1, 1, 1, 1, 499, '2025-07-06'),
(2, 1, 2, 1, 549, '2025-07-06'),
(3, 2, 2, 2, 599, '2025-07-06'),
(4, 3, 3, 3, 749, '2025-07-06'),
(5, 4, 3, 4, 799, '2025-07-06'),
(6, 5, 4, 5, 949, '2025-07-06'),
(7, 6, 2, 6, 599, '2025-07-06'),
(8, 7, 3, 7, 799, '2025-07-06'),
(9, 9, 5, 8, 1199, '2025-07-06'),
(10, 10, 5, 9, 1399, '2025-07-06');

-- TABLE: regions
CREATE TABLE regions (
    id INTEGER PRIMARY KEY,
    region_name TEXT,
    store_count INTEGER
);

INSERT INTO regions VALUES
(1, 'Tashkent', 3),
(2, 'Samarkand', 1),
(3, 'Bukhara', 1),
(4, 'Namangan', 1),
(5, 'Fergana', 1),
(6, 'Andijan', 1),
(7, 'Nukus', 1),
(8, 'Qarshi', 1),
(9, 'Jizzakh', 0),
(10, 'Termez', 0);
