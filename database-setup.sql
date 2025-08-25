-- ========================================
-- C# Web App Database Setup Script
-- ========================================
-- This script creates the database and tables needed for the C# Web App
-- Run this script in your MySQL/MariaDB database

-- Create database (if it doesn't exist)
CREATE DATABASE IF NOT EXISTS `cwebapp` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- Use the database
USE `cwebapp`;

-- Drop existing table if it exists
DROP TABLE IF EXISTS `Products`;

-- Create Products table
CREATE TABLE `Products` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Name` varchar(100) NOT NULL,
    `Description` varchar(500) NULL,
    `Price` decimal(18,2) NOT NULL,
    `StockQuantity` int NOT NULL DEFAULT 0,
    `CreatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `UpdatedAt` datetime NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert sample data
INSERT INTO `Products` (`Name`, `Description`, `Price`, `StockQuantity`, `CreatedAt`) VALUES
('Sample Product 1', 'This is a sample product description', 29.99, 100, NOW()),
('Sample Product 2', 'Another sample product description', 49.99, 50, NOW()),
('Laptop Computer', 'High-performance laptop with latest specifications', 999.99, 25, NOW()),
('Wireless Mouse', 'Ergonomic wireless mouse with precision tracking', 19.99, 200, NOW()),
('USB-C Cable', 'Fast charging USB-C cable, 3 feet long', 12.99, 150, NOW()),
('Bluetooth Headphones', 'Noise-cancelling wireless headphones', 89.99, 75, NOW()),
('Webcam HD', '1080p HD webcam for video conferencing', 59.99, 60, NOW()),
('Mechanical Keyboard', 'RGB mechanical keyboard with blue switches', 129.99, 30, NOW());

-- Create indexes for better performance
CREATE INDEX `IX_Products_Name` ON `Products` (`Name`);
CREATE INDEX `IX_Products_CreatedAt` ON `Products` (`CreatedAt`);

-- Show the created table structure
DESCRIBE `Products`;

-- Show sample data
SELECT * FROM `Products`;

-- ========================================
-- Database Setup Complete!
-- ========================================
-- Your database is now ready for the C# Web App
-- 
-- Next steps:
-- 1. Update your appsettings.json with the correct connection string
-- 2. Run the application using: .\run.ps1
-- 3. Access the web interface at: http://localhost:5001
--
-- Connection string format:
-- "Server=localhost;Database=cwebapp;User=your_username;Password=your_password;"
