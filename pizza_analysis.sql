USE pizza_db;

-- ==========================================
-- STEP 1: DATABASE SCHEMA (CREATE TABLES)
-- ==========================================

CREATE TABLE IF NOT EXISTS pizza_types (
    pizza_type_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    ingredients TEXT
);

CREATE TABLE IF NOT EXISTS pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,
    pizza_type_id VARCHAR(50),
    size VARCHAR(10),
    price TEXT -- CSV fast import ke liye text rakha tha
);

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    date DATE,
    time TIME
);

CREATE TABLE IF NOT EXISTS order_details (
    order_details_id INT PRIMARY KEY,
    order_id INT,
    pizza_id VARCHAR(50),
    quantity INT
);

-- ==========================================
-- STEP 2: DATA VERIFICATION (PREVIEW)
-- ==========================================
SELECT * FROM order_details LIMIT 5;
SELECT * FROM orders LIMIT 10;
SELECT * FROM pizza_types LIMIT 7;
SELECT * FROM pizzas LIMIT 4;
SELECT COUNT(*) FROM order_details;

-- ==========================================
-- STEP 3: CORE ASSIGNMENT TASKS
-- ==========================================

-- Task 1: Retrieve the total number of orders placed
SELECT COUNT(order_id) AS total_orders
FROM orders;

-- Task 2: Calculate the total revenue generated from pizza sales
SELECT
    ROUND(SUM(order_details.quantity * CAST(pizzas.price AS DECIMAL(10,2))) , 2) AS total_revenue
FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id;

-- ==========================================
-- STEP 4: ADVANCED BUSINESS INSIGHTS
-- ==========================================

-- 3. Top 5 Most Ordered Pizzas
SELECT 
    pizza_types.name, 
    SUM(order_details.quantity) AS total_quantity
FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY total_quantity DESC
LIMIT 5;

-- 4. Busiest Hours (Rush Hour Analysis)
SELECT 
    HOUR(time) AS order_hour, 
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY HOUR(time)
ORDER BY total_orders DESC;

-- 5. Average Order Value (AOV)
SELECT 
    ROUND(
        SUM(order_details.quantity * CAST(pizzas.price AS DECIMAL(10,2))) / 
        COUNT(DISTINCT order_details.order_id), 
        2
    ) AS average_order_value
FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id;

-- 3) Identify the highest-priced pizza.
SELECT pizza_id, CAST(price AS DECIMAL(10,2)) AS highest_price
FROM pizzas
ORDER BY highest_price DESC
LIMIT 1;

-- 4) Identify the most common pizza size ordered.
SELECT pizzas.size, SUM(order_details.quantity) AS total_ordered
FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizzas.size
ORDER BY total_ordered DESC
LIMIT 1;