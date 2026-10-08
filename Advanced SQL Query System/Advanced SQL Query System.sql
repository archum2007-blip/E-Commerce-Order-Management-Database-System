USE inventory_db;

SELECT
    Product_Name,
    Price
FROM Products
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
);
SELECT
    p.Product_Name,
    c.Category_Name,
    p.Price
FROM Products p
JOIN Categories c
ON p.Category_ID = c.Category_ID
WHERE p.Price > (
    SELECT AVG(Price)
    FROM Products
);
SELECT
    p.Product_Name,
    c.Category_Name,
    p.Price
FROM Products p
JOIN Categories c
ON p.Category_ID = c.Category_ID
WHERE p.Price > (
    SELECT AVG(p2.Price)
    FROM Products p2
    WHERE p2.Category_ID = p.Category_ID
);
SELECT
    Product_Name,
    Price
FROM Products
WHERE Category_ID = 1
AND Price > (
    SELECT AVG(Price)
    FROM Products
    WHERE Category_ID = 1
);
SELECT
    c.Customer_Name,
    SUM(o.Total_Amount) AS Total_Spending
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
HAVING SUM(o.Total_Amount) = (
    SELECT MAX(Total_Sales)
    FROM (
        SELECT SUM(Total_Amount) AS Total_Sales
        FROM Orders
        GROUP BY Customer_ID
    ) AS Sales
);
SELECT
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
HAVING COUNT(o.Order_ID) = (
    SELECT MAX(Order_Count)
    FROM (
        SELECT COUNT(*) AS Order_Count
        FROM Orders
        GROUP BY Customer_ID
    ) AS Counts
);
SELECT
    c.Customer_Name,
    SUM(o.Total_Amount) AS Total_Spending
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
HAVING SUM(o.Total_Amount) > (
    SELECT AVG(Total_Spending)
    FROM (
        SELECT SUM(Total_Amount) AS Total_Spending
        FROM Orders
        GROUP BY Customer_ID
    ) AS Spending
);
SELECT
    c.Customer_Name,
    SUM(o.Total_Amount) AS Total_Spending
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Total_Spending DESC
LIMIT 5;
SELECT
    p.Product_Name,
    SUM(od.Quantity) AS Total_Sold,
    SUM(od.Quantity * p.Price) AS Total_Revenue
FROM Products p
JOIN Order_Details od
ON p.Product_ID = od.Product_ID
GROUP BY p.Product_ID, p.Product_Name
HAVING SUM(od.Quantity) = (
    SELECT MAX(Total_Sold)
    FROM (
        SELECT SUM(Quantity) AS Total_Sold
        FROM Order_Details
        GROUP BY Product_ID
    ) AS Sales
);
SELECT
    c.Customer_Name,
    SUM(o.Total_Amount) AS Total_Spending
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
HAVING SUM(o.Total_Amount) > (
    SELECT AVG(Total_Spending)
    FROM (
        SELECT SUM(Total_Amount) AS Total_Spending
        FROM Orders
        GROUP BY Customer_ID
    ) AS Spending
)
ORDER BY Total_Spending DESC;
SELECT
    c.Category_Name,
    SUM(od.Quantity * p.Price) AS Total_Revenue
FROM Categories c
JOIN Products p
ON c.Category_ID = p.Category_ID
JOIN Order_Details od
ON p.Product_ID = od.Product_ID
GROUP BY c.Category_ID, c.Category_Name
ORDER BY Total_Revenue DESC
LIMIT 1;
SELECT
    c.Category_Name,
    SUM(od.Quantity) AS Products_Sold
FROM Categories c
JOIN Products p
ON c.Category_ID = p.Category_ID
JOIN Order_Details od
ON p.Product_ID = od.Product_ID
GROUP BY c.Category_ID, c.Category_Name;
SELECT
    c.Category_Name,
    AVG(p.Price) AS Average_Price
FROM Categories c
JOIN Products p
ON c.Category_ID = p.Category_ID
GROUP BY c.Category_ID, c.Category_Name;
SELECT
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Total_Amount) AS Total_Purchase,
    (
        SELECT p.Product_Name
        FROM Products p
        JOIN Order_Details od ON p.Product_ID = od.Product_ID
        JOIN Orders o2 ON od.Order_ID = o2.Order_ID
        WHERE o2.Customer_ID = c.Customer_ID
        GROUP BY p.Product_ID, p.Product_Name
        ORDER BY SUM(od.Quantity) DESC
        LIMIT 1
    ) AS Most_Purchased_Product
FROM Customers c
LEFT JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name;
DESCRIBE Inventory;
SELECT
    p.Product_Name,
    c.Category_Name,
    p.Price,
    i.Stock_Quantity AS Stock_Availability
FROM Products p
JOIN Categories c
ON p.Category_ID = c.Category_ID
LEFT JOIN Inventory i
ON p.Product_Name = i.Item_Name
WHERE p.Price > (
    SELECT AVG(Price)
    FROM Products
);
SELECT
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Total_Amount) AS Total_Spending,
    CASE
        WHEN SUM(o.Total_Amount) > (
            SELECT AVG(Total_Spending)
            FROM (
                SELECT SUM(Total_Amount) AS Total_Spending
                FROM Orders
                GROUP BY Customer_ID
            ) AS Spending
        )
        THEN 'Premium'
        ELSE 'Regular'
    END AS Customer_Category
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name;
SELECT p.Product_Name,c.Category_Name,
SUM(od.Quantity) AS Quantity_Sold,
SUM(od.Quantity*p.Price) AS Revenue
FROM Products p
JOIN Categories c ON p.Category_ID=c.Category_ID
JOIN Order_Details od ON p.Product_ID=od.Product_ID
GROUP BY p.Product_ID,p.Product_Name,c.Category_ID,c.Category_Name
ORDER BY Revenue DESC;
SELECT p.Product_Name,SUM(od.Quantity) AS Total_Sold
FROM Products p
JOIN Order_Details od ON p.Product_ID=od.Product_ID
GROUP BY p.Product_ID,p.Product_Name
ORDER BY Total_Sold DESC
LIMIT 5;
SELECT c.Category_Name,
SUM(od.Quantity*p.Price) AS Total_Revenue
FROM Categories c
JOIN Products p ON c.Category_ID=p.Category_ID
JOIN Order_Details od ON p.Product_ID=od.Product_ID
GROUP BY c.Category_ID,c.Category_Name
ORDER BY Total_Revenue DESC;
SELECT p.Product_Name,
SUM(od.Quantity) AS Quantity_Sold,
SUM(od.Quantity*p.Price) AS Revenue
FROM Products p
JOIN Order_Details od ON p.Product_ID=od.Product_ID
GROUP BY p.Product_ID,p.Product_Name
HAVING SUM(od.Quantity*p.Price) > (
    SELECT AVG(Product_Revenue)
    FROM (
        SELECT SUM(od2.Quantity*p2.Price) AS Product_Revenue
        FROM Products p2
        JOIN Order_Details od2 ON p2.Product_ID=od2.Product_ID
        GROUP BY p2.Product_ID
    ) AS RevenueData
)
ORDER BY Revenue DESC;
SELECT p.Product_Name,
SUM(od.Quantity) AS Quantity_Sold,
SUM(od.Quantity*p.Price) AS Revenue
FROM Products p
JOIN Order_Details od ON p.Product_ID=od.Product_ID
GROUP BY p.Product_ID,p.Product_Name
HAVING SUM(od.Quantity*p.Price) < (
    SELECT AVG(Product_Revenue)
    FROM (
        SELECT SUM(od2.Quantity*p2.Price) AS Product_Revenue
        FROM Products p2
        JOIN Order_Details od2 ON p2.Product_ID=od2.Product_ID
        GROUP BY p2.Product_ID
    ) AS RevenueData
)
ORDER BY Revenue ASC;
SELECT c.Customer_Name,
SUM(o.Total_Amount) AS Total_Spending
FROM Customers c
JOIN Orders o ON c.Customer_ID=o.Customer_ID
GROUP BY c.Customer_ID,c.Customer_Name
HAVING SUM(o.Total_Amount) > (
    SELECT AVG(Total_Spending)
    FROM (
        SELECT SUM(Total_Amount) AS Total_Spending
        FROM Orders
        GROUP BY Customer_ID
    ) AS Spending
)
ORDER BY Total_Spending DESC;
SELECT YEAR(Order_Date) AS Year,
MONTH(Order_Date) AS Month,
SUM(Total_Amount) AS Monthly_Revenue
FROM Orders
GROUP BY YEAR(Order_Date),MONTH(Order_Date)
ORDER BY Year,Month;