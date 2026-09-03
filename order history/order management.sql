USE inventory_db;
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    City VARCHAR(50)
);
INSERT INTO Customers
(Customer_Name, Email, Phone, City)
VALUES
('Vignesh R', 'vignesh@gmail.com', '9876501234', 'Chennai'),
('Sneha K', 'sneha@gmail.com', '9876501235', 'Madurai'),
('Aditya P', 'aditya@gmail.com', '9876501236', 'Coimbatore'),
('Meena S', 'meena@gmail.com', '9876501237', 'Chennai'),
('Naveen T', 'naveen@gmail.com', '9876501238', 'Salem');
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT NOT NULL,
    Order_Date DATE NOT NULL,
    Total_Amount DECIMAL(10,2) NOT NULL CHECK (Total_Amount >= 0),
    Order_Status VARCHAR(30) NOT NULL
        CHECK (Order_Status IN
        ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
    FOREIGN KEY (Customer_ID)
        REFERENCES Customers(Customer_ID)
);
INSERT INTO Orders
(Customer_ID, Order_Date, Total_Amount, Order_Status)
VALUES
(2, '2026-08-18', 2800.00, 'Delivered'),
(4, '2026-08-19', 3500.00, 'Shipped'),
(1, '2026-08-20', 1950.00, 'Pending'),
(5, '2026-08-21', 4200.00, 'Delivered'),
(3, '2026-08-22', 2750.00, 'Processing'),
(2, '2026-08-23', 5100.00, 'Delivered');
SELECT * FROM Orders;
CREATE TABLE Order_Details (
    Order_Detail_ID INT PRIMARY KEY AUTO_INCREMENT,
    Order_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID)
        REFERENCES Products(Product_ID)
);
INSERT INTO Order_Details
(Order_ID, Product_ID, Quantity, Price)
VALUES
(1, 1, 1, 1800.00),
(1, 2, 2, 500.00),
(2, 3, 1, 1500.00),
(2, 4, 2, 1000.00),
(3, 2, 3, 650.00),
(4, 5, 2, 1200.00),
(4, 1, 1, 1800.00),
(5, 3, 2, 1375.00),
(6, 4, 1, 2100.00),
(6, 2, 2, 1500.00);
SELECT
    c.Customer_Name,
    o.Order_ID,
    o.Order_Date,
    o.Total_Amount,
    o.Order_Status AS Status
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
ORDER BY o.Order_Date;
SELECT
    p.Product_Name,
    COUNT(od.Order_ID) AS Times_Ordered,
    SUM(od.Quantity) AS Total_Quantity_Sold
FROM Products p
JOIN Order_Details od
    ON p.Product_ID = od.Product_ID
GROUP BY p.Product_ID, p.Product_Name
ORDER BY Total_Quantity_Sold DESC;
SELECT
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Total_Amount) AS Total_Spending,
    ROUND(AVG(o.Total_Amount), 2) AS Average_Order_Value
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Total_Spending DESC;