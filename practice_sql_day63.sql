CREATE DATABASE database_02_nguyenmanhdung;

-- Tạo bảng products
CREATE TABLE IF NOT EXISTS products (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name CHARACTER VARYING(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL
);
DROP TABLE IF EXISTS products;

-- Tạo bảng customers
CREATE TABLE IF NOT EXISTS customers (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name CHARACTER VARYING(255) NOT NULL,
    email CHARACTER VARYING(255) NOT NULL,
    phone CHARACTER VARYING(20) NOT NULL
);
DROP TABLE IF EXISTS customers;

-- Tạo bảng orders
CREATE TABLE IF NOT EXISTS orders (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    total_quantity INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status CHARACTER VARYING(50) NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE
);
DROP TABLE IF EXISTS orders;

-- Tạo bảng order_items
CREATE TABLE IF NOT EXISTS order_items (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
);
DROP TABLE IF EXISTS order_items;

-- Thêm dữ liệu mẫu cho bảng products
INSERT INTO products (name, price, quantity) VALUES ('Product 1', 100, 10);
INSERT INTO products (name, price, quantity) VALUES ('Product 2', 200, 20);
INSERT INTO products (name, price, quantity) VALUES ('Product 3', 300, 30);
INSERT INTO products (name, price, quantity) VALUES ('Product 4', 400, 40);
INSERT INTO products (name, price, quantity) VALUES ('Product 5', 500, 50);

-- Thêm dữ liệu mẫu cho bảng customers
INSERT INTO customers (name, email, phone) VALUES ('Customer 1', 'user1@gmail.com', '0987654321');
INSERT INTO customers (name, email, phone) VALUES ('Customer 2', 'user2gmail.com', '0123456789');
INSERT INTO customers (name, email, phone) VALUES ('Customer 3', 'user3@gmail.com', '0909090909');
INSERT INTO customers (name, email, phone) VALUES ('Customer 4', 'user4@gmail.com', '0912345678');
INSERT INTO customers (name, email, phone) VALUES ('Customer 5', 'user5@gmail.com', '0987654321');

-- Thêm dữ liệu mẫu cho bảng orders
INSERT INTO orders (customer_id, total_quantity, total_amount, status) VALUES (1, 5, 1500, 'Pending');
INSERT INTO orders (customer_id, total_quantity, total_amount, status) VALUES (2, 10, 3000, 'Processing');
INSERT INTO orders (customer_id, total_quantity, total_amount, status) VALUES (3, 15, 4500, 'Completed');
INSERT INTO orders (customer_id, total_quantity, total_amount, status) VALUES (4, 20, 6000, 'Cancelled');
INSERT INTO orders (customer_id, total_quantity, total_amount, status) VALUES (5, 25, 7500, 'Pending');

-- Thêm dữ liệu mẫu cho bảng order_items
INSERT INTO order_items (order_id, product_id, price, quantity, total_amount) VALUES (1, 1, 100, 5, 500);
INSERT INTO order_items (order_id, product_id, price, quantity, total_amount) VALUES (2, 2, 200, 10, 2000);
INSERT INTO order_items (order_id, product_id, price, quantity, total_amount) VALUES (3, 3, 300, 15, 4500);
INSERT INTO order_items (order_id, product_id, price, quantity, total_amount) VALUES (4, 4, 400, 20, 8000);
INSERT INTO order_items (order_id, product_id, price, quantity, total_amount) VALUES (5, 5, 500, 25, 12500);

-- Hiển thị danh sách đơn hàng
SELECT customers.name AS customer_name,
       customers.email AS customer_email,
       customers.phone AS customer_phone,
       orders.total_quantity,
       orders.total_amount,
       orders.status,
       orders.created_at
FROM orders
JOIN customers ON orders.customer_id = customers.id;

-- Hiển thị chi tiết đơn hàng
SELECT customers.name AS customer_name,
       customers.email AS customer_email,
       customers.phone AS customer_phone,
       products.name AS product_name,
       products.id AS product_id,
       order_items.price,
       order_items.quantity,
       order_items.total_amount,
       orders.status,
       orders.created_at,
       orders.updated_at
FROM order_items 
JOIN products ON order_items.product_id = products.id
JOIN orders ON order_items.order_id = orders.id
JOIN customers ON orders.customer_id = customers.id;