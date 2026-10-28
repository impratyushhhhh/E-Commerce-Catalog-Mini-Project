-- =============================================================================
-- Amazon-Style E-Commerce Database Schema (MySQL 8.0)
-- Strategy: Hibernate InheritanceType.JOINED for Product catalog
-- Includes Customer, Orders (Cash on Delivery), and Admin tables
-- =============================================================================

CREATE DATABASE IF NOT EXISTS ecommerce_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE ecommerce_db;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Laptop;
DROP TABLE IF EXISTS TShirt;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS AdminUser;
SET FOREIGN_KEY_CHECKS = 1;

-- =============================================================================
-- Table 1: Product (Root Base Table - JOINED Inheritance)
-- =============================================================================
CREATE TABLE Product (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT,
    category VARCHAR(50) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_product PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================================================
-- Table 2: Laptop (Subclass Table)
-- Primary key 'id' references Product(id)
-- =============================================================================
CREATE TABLE Laptop (
    id BIGINT NOT NULL,
    brand VARCHAR(100) NOT NULL,
    processor VARCHAR(100) NOT NULL,
    ram_gb INT NOT NULL,
    storage_gb INT NOT NULL,
    CONSTRAINT pk_laptop PRIMARY KEY (id),
    CONSTRAINT fk_laptop_product FOREIGN KEY (id)
        REFERENCES Product (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================================================
-- Table 3: TShirt (Subclass Table)
-- Primary key 'id' references Product(id)
-- =============================================================================
CREATE TABLE TShirt (
    id BIGINT NOT NULL,
    size VARCHAR(10) NOT NULL,
    color VARCHAR(50) NOT NULL,
    material VARCHAR(100) DEFAULT '100% Cotton',
    CONSTRAINT pk_tshirt PRIMARY KEY (id),
    CONSTRAINT fk_tshirt_product FOREIGN KEY (id)
        REFERENCES Product (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================================================
-- Table 4: Customer (Checkout Profile)
-- Stores Name, Age, Phone, Email, and Delivery Address
-- =============================================================================
CREATE TABLE Customer (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    address TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_customer PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================================================
-- Table 5: Orders (Purchase Record with Cash on Delivery)
-- =============================================================================
CREATE TABLE Orders (
    id BIGINT NOT NULL AUTO_INCREMENT,
    order_number VARCHAR(50) NOT NULL UNIQUE,
    customer_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    total_amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL DEFAULT 'Cash on Delivery (COD)',
    order_status VARCHAR(50) NOT NULL DEFAULT 'PLACED',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_orders PRIMARY KEY (id),
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id)
        REFERENCES Customer (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_orders_product FOREIGN KEY (product_id)
        REFERENCES Product (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================================================
-- Table 6: AdminUser (Protected Admin Portal)
-- =============================================================================
CREATE TABLE AdminUser (
    id BIGINT NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_adminuser PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================================================
-- Seed Data
-- =============================================================================

-- 1. Insert Products
INSERT INTO Product (id, name, price, description, category, stock) VALUES
(1, 'ThinkPad X1 Carbon Gen 11', 1499.99, 'Ultra-lightweight flagship business laptop powered by Intel 13th Gen.', 'Laptop', 25),
(2, 'MacBook Pro 14" M3', 1999.00, 'Apple silicon M3 Pro chip, Liquid Retina XDR display, up to 18 hrs battery.', 'Laptop', 15),
(3, 'Dell XPS 15 OLED', 1749.50, 'Precision crafted laptop with InfinityEdge 3.5K OLED touchscreen display.', 'Laptop', 18),
(4, 'Amazon Essentials Vintage Crewneck', 29.99, '100% combed ring-spun cotton everyday vintage crewneck t-shirt.', 'TShirt', 150),
(5, 'Athletic Dry-Fit Performance Tee', 34.50, 'Moisture-wicking activewear training t-shirt with 4-way stretch fabric.', 'TShirt', 200),
(6, 'Classic Heavyweight Streetwear Tee', 39.00, 'Relaxed fit heavyweight organic cotton streetwear tee.', 'TShirt', 85);

ALTER TABLE Product AUTO_INCREMENT = 7;

-- 2. Insert Laptop Specific Attributes
INSERT INTO Laptop (id, brand, processor, ram_gb, storage_gb) VALUES
(1, 'Lenovo', 'Intel Core i7-1365U', 16, 512),
(2, 'Apple', 'Apple M3 Pro', 18, 512),
(3, 'Dell', 'Intel Core i7-13700H', 32, 1024);

-- 3. Insert TShirt Specific Attributes
INSERT INTO TShirt (id, size, color, material) VALUES
(4, 'L', 'Charcoal Gray', '100% Organic Cotton'),
(5, 'M', 'Navy Blue', '85% Polyester, 15% Spandex'),
(6, 'XL', 'Off-White', '100% Ring-Spun Cotton');

-- 4. Insert Default Admin User (admin / admin123)
INSERT INTO AdminUser (username, password, full_name) VALUES
('admin', 'admin123', 'Amazon Store Administrator');

-- 5. Insert Sample Seed Customer & Order (for immediate Admin Dashboard demo)
INSERT INTO Customer (id, name, age, phone, email, address) VALUES
(1, 'Pratyush Sharma', 24, '+91 98765 43210', 'pratyush@example.com', 'Flat 402, Highrise Tower, Bangalore, Karnataka - 560001');

INSERT INTO Orders (id, order_number, customer_id, product_id, quantity, total_amount, payment_method, order_status) VALUES
(1, 'AMZ-1084291', 1, 1, 1, 1499.99, 'Cash on Delivery (COD)', 'PLACED');

ALTER TABLE Customer AUTO_INCREMENT = 2;
ALTER TABLE Orders AUTO_INCREMENT = 2;
