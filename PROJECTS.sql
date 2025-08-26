CREATE DATABASE projects;
USE projects;
CREATE TABLE customers(
	customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    city VARCHAR(50),
    signup_date DATE
);
INSERT INTO customers VALUES
(1, 'Ali Khan', 'ali.khan@email.com', 'Lahore', '2025-01-15'),
(2, 'Sara Ahmed', 'sara.ahmed@email.com', 'Karachi', '2025-02-20'),
(3, 'Fahad Mehmood', 'fahad.m@email.com', 'Islamabad', '2025-03-10'),
(4, 'Ayesha Noor', 'ayesha.noor@email.com', 'Lahore', '2025-04-05'),
(5, 'Bilal Saeed', 'bilal.s@email.com', 'Rawalpindi', '2025-05-01');
CREATE TABLE products(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(50),
    category VARCHAR(50),
    price INT,
    stock_quantity INT
);
INSERT INTO products VALUES
(101, 'Wireless Mouse', 'Electronics', 1200, 15),
(102, 'Bluetooth Headphones', 'Electronics', 3500, 8),
(103, 'Water Bottle', 'Home', 500, 25),
(104, 'Notebook', 'Stationery', 200, 100),
(105, 'Smartwatch', 'Electronics', 9500, 5);
CREATE TABLE orders(
	order_id INT PRIMARY KEY,
    order_date DATE,
    total_amount INT,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO orders VALUES
(1001, '2025-06-01', 4700,1),
(1002, '2025-06-05', 1200,2),
(1003, '2025-07-10', 3700,3),
(1004, '2025-08-02', 200,1),
(1005, '2025-08-10', 9500,5);
CREATE TABLE order_item(
	order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price_per_unit INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO order_item VALUES
(1, 1001, 101, 1, 1200),
(2, 1001, 102, 1, 3500),
(3, 1002, 101, 1, 1200),
(4, 1003, 103, 2, 500),
(5, 1003, 104, 5, 200),
(6, 1004, 104, 1, 200),
(7, 1005, 105, 1, 9500);
CREATE TABLE payment(
	payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
INSERT INTO payment VALUES
(5001, 1001, '2025-06-01', 'Credit Card', 'Completed'),
(5002, 1002, '2025-06-06', 'Cash on Delivery', 'Completed'),
(5003, 1003, '2025-07-11', 'Bank Transfer', 'Completed'),
(5004, 1004, '2025-08-03', 'Credit Card', 'Completed'),
(5005, 1005, '2025-08-11', 'Credit Card', 'Pending');
-- TOP SELLING PRODUCT
SELECT p.product_name, SUM(oi.quantity) AS total_sold FROM order_item oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;
-- PENDING PAYMENT
SELECT p.payment_id, o.order_id, c.name, p.payment_status
FROM payment p
JOIN orders o ON p.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE p.payment_status = 'Pending';
-- PAYMENT COMPLETED
SELECT p.payment_id, o.order_id, c.name, p.payment_status
FROM payment p
JOIN orders o ON p.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE p.payment_status = 'Completed';