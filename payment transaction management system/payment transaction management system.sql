USE inventory_db;
CREATE TABLE payment (
    Payment_ID INT AUTO_INCREMENT,
    Order_ID INT NOT NULL,
    Payment_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Payment_Mode VARCHAR(100),
    Payment_Status VARCHAR(100),
    Transaction_Amount DECIMAL(10,2),

    CONSTRAINT pk_key PRIMARY KEY (Payment_ID),
    CONSTRAINT chk_amt CHECK (Transaction_Amount > 0),
    CONSTRAINT fk_key FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID)
);
SELECT * FROM Orders;
INSERT INTO payment
(Order_ID, Payment_Mode, Payment_Status, Transaction_Amount)
VALUES
(1, 'UPI', 'pending', 450),
(2, 'credit card', 'successfull', 450),
(3, 'debit card', 'successfull', 450),
(4, 'Cash on delivery', 'successfull', 1450),
(5, 'debit card', 'failed', 5000);
SELECT * FROM payment;
SELECT *
FROM payment
WHERE Payment_Status = 'successfull';
SELECT *
FROM payment
WHERE Payment_Status = 'failed';
SELECT
    COUNT(*) AS Number_of_Transcations,
    Payment_Mode
FROM payment
GROUP BY Payment_Mode;
SELECT
    COUNT(*) AS Number_of_Transcations,
    Payment_Status
FROM payment
GROUP BY Payment_Status;
SELECT *
FROM payment
WHERE Payment_Status = 'failed';
UPDATE payment
SET Payment_Status = 'Successful'
WHERE Payment_ID = 10;
SELECT *
FROM payment
WHERE Payment_Status = 'Pending';
SELECT
    SUM(Payment_Mode = 'UPI') AS UPI_Transactions,
    SUM(Payment_Mode = 'CREDIT CARD') AS Card_Payments,
    (
        SELECT Payment_Mode
        FROM Payment
        GROUP BY Payment_Mode
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS Most_Preferred_Payment_Method
FROM Payment;
SELECT
    SUM(Transaction_Amount) AS Total_Revenue,
    AVG(Transaction_Amount) AS Average_Transaction_Amount,
    SUM(CASE WHEN Payment_Mode = 'UPI'
             THEN Transaction_Amount ELSE 0 END) AS UPI_Revenue,
    SUM(CASE WHEN Payment_Mode = 'CREDIT CARD'
             THEN Transaction_Amount ELSE 0 END) AS Card_Revenue,
    SUM(CASE WHEN Payment_Mode IN ('COD', 'CASH ON DELIVERY')
             THEN Transaction_Amount ELSE 0 END) AS COD_Revenue
FROM Payment
WHERE Payment_Status = 'SUCCESSFUL';
SELECT
    c.Customer_Name,
    o.Order_ID,
    p.Payment_Mode,
    p.Transaction_Amount AS Amount,
    p.Payment_Status
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
JOIN Payment p
    ON o.Order_ID = p.Order_ID
ORDER BY c.Customer_Name;