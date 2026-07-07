USE pizza_db;
SELECT *FROM order_details Limit 5;
SELECT *FROM orders Limit 10;
SELECT *FROM pizza_types Limit 7;
SELECT *FROM pizzas Limit 4;
SELECT COUNT (*) FROM order_details;
SELECT COUNT(order_id) AS total_orders
FROM orders;
SELECT
 ROUND(SUM(order_details.quantity * CAST(pizzas.price AS Decimal(10,2))) , 2) AS total_revenue
 FROM order_details
 JOIN 
 pizzas ON order_details.pizza_id = pizzas.pizza_id;
SELECT 
    pizza_types.name, 
    SUM(order_details.quantity) AS total_quantity
FROM 
    order_details
JOIN 
    pizzas ON order_details.pizza_id = pizzas.pizza_id
JOIN 
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY 
    pizza_types.name
ORDER BY 
    total_quantity DESC
LIMIT 5;
SELECT 
    HOUR(time) AS order_hour, 
    COUNT(order_id) AS total_orders
FROM 
    orders
GROUP BY 
    HOUR(time)
ORDER BY 
    total_orders DESC;
SELECT 
    ROUND(
        SUM(order_details.quantity * CAST(pizzas.price AS DECIMAL(10,2))) / 
        COUNT(DISTINCT order_details.order_id), 
        2
    ) AS average_order_value
FROM 
    order_details
JOIN 
    pizzas ON order_details.pizza_id = pizzas.pizza_id;
