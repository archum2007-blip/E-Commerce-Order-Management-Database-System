USE inventory_db;

SELECT COUNT(*) AS Total_Orders
FROM Orders;
SELECT SUM(Total_Amount) AS Total_Revenue
FROM Orders;
SELECT AVG(Total_Amount) AS Average_Order_Value
FROM Orders;
SELECT
    MAX(Total_Amount) AS Highest_Order,
    MIN(Total_Amount) AS Lowest_Order
FROM Orders;
SELECT SUM(Total_Amount) AS Total_Sales
FROM Orders
WHERE Order_Date BETWEEN '2025-01-01' AND '2025-12-31';
SELECT
    Customer_ID,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY Customer_ID;
SELECT
    c.Customer_Name,
    SUM(o.Total_Amount) AS Total_Spending
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name;
SELECT
    c.Customer_Name,
    AVG(o.Total_Amount) AS Average_Spending
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name;
SELECT
    c.Customer_Name,
    SUM(o.Total_Amount) AS Total_Spending
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Total_Spending DESC
LIMIT 1;
SELECT
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders
FROM Customers c
LEFT JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
HAVING COUNT(o.Order_ID) < 2;
SELECT
    c.Customer_Name,
    SUM(o.Total_Amount) AS Spending
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Spending DESC
LIMIT 5;
SELECT
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Total_Orders DESC
LIMIT 1;
SELECT
    p.Product_Name,
    SUM(od.Quantity) AS Total_Sold
FROM Products p
JOIN Order_Details od
ON p.Product_ID = od.Product_ID
GROUP BY p.Product_ID, p.Product_Name
ORDER BY Total_Sold DESC;
SELECT 
    p.Product_Name, SUM(od.Quantity * p.Price) AS Total_Revenue
FROM
    Products p
        JOIN
    Order_Details od ON p.Product_ID = od.Product_ID
GROUP BY p.Product_ID , p.Product_Name
ORDER BY Total_Revenue DESC;
SELECT
    p.Product_Name,
    SUM(od.Quantity) AS Total_Sold
FROM Products p
JOIN Order_Details od
ON p.Product_ID = od.Product_ID
GROUP BY p.Product_ID, p.Product_Name
ORDER BY Total_Sold ASC;
SELECT
    c.Category_Name,
    SUM(od.Quantity * p.Price) AS Category_Sales
FROM Categories c
JOIN Products p
ON c.Category_ID = p.Category_ID
JOIN Order_Details od
ON p.Product_ID = od.Product_ID
GROUP BY c.Category_ID, c.Category_Name
ORDER BY Category_Sales DESC;
SELECT
    c.Category_Name,
    SUM(od.Quantity) AS Total_Products_Sold
FROM Categories c
JOIN Products p
ON c.Category_ID = p.Category_ID
JOIN Order_Details od
ON p.Product_ID = od.Product_ID
GROUP BY c.Category_ID, c.Category_Name;
SELECT
    c.Category_Name,
    AVG(od.Quantity * p.Price) AS Average_Sales
FROM Categories c
JOIN Products p
ON c.Category_ID = p.Category_ID
JOIN Order_Details od
ON p.Product_ID = od.Product_ID
GROUP BY c.Category_ID, c.Category_Name;
SELECT
    SUM(Total_Amount) AS Total_Sales,
    COUNT(*) AS Total_Orders,
    AVG(Total_Amount) AS Average_Order_Value,
    MAX(Total_Amount) AS Highest_Order_Value
FROM Orders;
SELECT
    c.Customer_Name,
    COUNT(o.Order_ID) AS Number_of_Orders,
    SUM(o.Total_Amount) AS Total_Spending,
    AVG(o.Total_Amount) AS Average_Spending
FROM Customers c
LEFT JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name;
USE inventory_db;

SELECT
    p.Product_Name,
    SUM(od.Quantity) AS Quantity_Sold,
    SUM(od.Quantity * p.Price) AS Revenue
FROM Products p
JOIN Order_Details od
ON p.Product_ID = od.Product_ID
GROUP BY p.Product_ID, p.Product_Name
ORDER BY Revenue DESC;
SELECT
    p.Product_Name,
    SUM(od.Quantity) AS Quantity_Sold,
    SUM(od.Quantity * p.Price) AS Revenue
FROM Products p
JOIN Order_Details od
ON p.Product_ID = od.Product_ID
GROUP BY p.Product_ID, p.Product_Name
ORDER BY Revenue DESC;
USE inventory_db;

SELECT
    c.Category_Name,
    SUM(od.Quantity) AS Total_Products_Sold,
    SUM(od.Quantity * p.Price) AS Total_Revenue
FROM Categories c
JOIN Products p
ON c.Category_ID = p.Category_ID
JOIN Order_Details od
ON p.Product_ID = od.Product_ID
GROUP BY c.Category_ID, c.Category_Name
ORDER BY Total_Revenue DESC;

