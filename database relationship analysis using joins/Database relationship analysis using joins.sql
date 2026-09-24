USE inventory_db;

SELECT
    c.Customer_Name,
    o.Order_ID,
    o.Order_Date,
    o.Total_Amount,
    o.Order_Status
FROM Customers c
INNER JOIN Orders o
ON c.Customer_ID = o.Customer_ID;
SELECT
    o.Order_ID,
    o.Order_Date,
    o.Total_Amount,
    p.Payment_Mode,
    p.Payment_Status
FROM Orders o
INNER JOIN Payment p
ON o.Order_ID = p.Order_ID;
SELECT
    c.Customer_Name,
    p.Product_Name,
    od.Quantity
FROM Customers c
INNER JOIN Orders o
ON c.Customer_ID = o.Customer_ID
INNER JOIN Order_Details od
ON o.Order_ID = od.Order_ID
INNER JOIN Products p
ON od.Product_ID = p.Product_ID;
SELECT
    c.Customer_Name,
    o.Order_ID
FROM Customers c
LEFT JOIN Orders o
ON c.Customer_ID = o.Customer_ID;
SELECT
    c.Customer_Name
FROM Customers c
LEFT JOIN Orders o
ON c.Customer_ID = o.Customer_ID
WHERE o.Order_ID IS NULL;
SELECT
    p.Product_Name,
    od.Order_ID
FROM Products p
LEFT JOIN Order_Details od
ON p.Product_ID = od.Product_ID;
SELECT
    o.Order_ID,
    o.Order_Date,
    c.Customer_Name
FROM Customers c
RIGHT JOIN Orders o
ON c.Customer_ID = o.Customer_ID;
SELECT 
    o.Order_ID, c.Customer_Name
FROM
    Customers c
        RIGHT JOIN
    Orders o ON c.Customer_ID = o.Customer_ID
WHERE
    c.Customer_ID IS NULL;
    SELECT
    p.Payment_ID,
    p.Payment_Mode,
    p.Payment_Status,
    o.Order_ID,
    o.Order_Date
FROM Orders o
RIGHT JOIN Payment p
ON o.Order_ID = p.Order_ID;
SELECT
    c.Customer_Name,
    p.Product_Name,
    od.Quantity,
    o.Order_Date,
    o.Total_Amount,
    py.Payment_Status
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
JOIN Order_Details od
ON o.Order_ID = od.Order_ID
JOIN Products p
ON od.Product_ID = p.Product_ID
JOIN Payment py
ON o.Order_ID = py.Order_ID;
SELECT
    c.Customer_Name,
    p.Product_Name,
    od.Quantity
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
JOIN Order_Details od
ON o.Order_ID = od.Order_ID
JOIN Products p
ON od.Product_ID = p.Product_ID
WHERE c.Customer_ID = 1;
SELECT
    c.Customer_Name,
    SUM(o.Total_Amount) AS Total_Spent
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name;
SELECT
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders
FROM Customers c
LEFT JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name;
SELECT
    c.Customer_Name,
    p.Product_Name,
    o.Order_Date,
    o.Total_Amount
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
JOIN Order_Details od
ON o.Order_ID = od.Order_ID
JOIN Products p
ON od.Product_ID = p.Product_ID
WHERE o.Order_Date = (
    SELECT MAX(o2.Order_Date)
    FROM Orders o2
    WHERE o2.Customer_ID = c.Customer_ID
);
SELECT
    c.Customer_Name,
    o.Order_ID,
    o.Order_Date,
    o.Order_Status
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID;
SELECT
    p.Product_Name,
    SUM(od.Quantity) AS Quantity_Sold,
    SUM(od.Quantity * p.Price) AS Total_Revenue
FROM Products p
JOIN Order_Details od
ON p.Product_ID = od.Product_ID
GROUP BY p.Product_ID, p.Product_Name
ORDER BY Total_Revenue DESC;
SELECT
    Payment_Mode,
    COUNT(*) AS Transactions,
    SUM(
        CASE
            WHEN LOWER(Payment_Status) IN ('successful', 'successfull')
            THEN 1 ELSE 0
        END
    ) AS Successful_Payments
FROM Payment
GROUP BY Payment_Mode;
SELECT
    c.Customer_Name,
    SUM(o.Total_Amount) AS Total_Spent,
    COUNT(o.Order_ID) AS Total_Orders
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Total_Spent DESC;