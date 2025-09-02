CREATE DATABASE retail;
USE retail;
CREATE TABLE superstore (
    Row_ID INT,
    Order_ID VARCHAR(50),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(50),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(100),
    Postal_Code INT,
    Region VARCHAR(50),
    Product_ID VARCHAR(50),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(255),
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2),
    Year INT,
    Month INT,
    Quarter INT,
    Profit_Margin DECIMAL(10,2),
    Processing_Days INT,
    Has_Discount TINYINT,
    Season VARCHAR(20),
    Order_Size VARCHAR(20),
    Category_Contribution DECIMAL(10,2),
    Late_Shipment_Flag TINYINT,
    Loss_Flag TINYINT
);

DROP TABLE IF EXISTS superstore;

CREATE TABLE superstore (
    Row_ID INT,
    Order_ID VARCHAR(50),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(50),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(100),
    Postal_Code VARCHAR(20),
    Region VARCHAR(50),
    Product_ID VARCHAR(50),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(255),
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2),
    Year INT,
    Month INT,
    Quarter INT,
    Profit_Margin DECIMAL(10,2),
    Processing_Days INT,
    Has_Discount TINYINT,
    Season VARCHAR(20),
    Order_Size VARCHAR(20),
    Category_Contribution DECIMAL(10,2),
    Late_Shipment_Flag TINYINT,
    Loss_Flag TINYINT
);
-- 1. Profit Margin by Category
SELECT 
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit) * 100.0 / NULLIF(SUM(Sales),0), 2) AS Profit_Margin_Percent
FROM superstore
GROUP BY Category
ORDER BY Total_Profit DESC;

-- 2. Profit Margin by Sub-Category
SELECT 
    Category,
    Sub_Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit) * 100.0 / NULLIF(SUM(Sales),0), 2) AS Profit_Margin_Percent
FROM superstore
GROUP BY Category, Sub_Category
ORDER BY Total_Profit DESC;

-- 3. Top 10 Profitable Products
SELECT 
    Product_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY Product_Name
ORDER BY Total_Profit DESC
LIMIT 10;

-- 4. Top 10 Loss-Making Products
SELECT 
    Product_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY Product_Name
ORDER BY Total_Profit ASC
LIMIT 10;

-- 5. Regional Sales & Profit
SELECT 
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY Region
ORDER BY Total_Profit DESC;

-- 6. Yearly Sales & Profit
SELECT 
    YEAR(Order_Date) AS Year,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY YEAR(Order_Date)
ORDER BY YEAR(Order_Date);

-- 7. Quarterly Sales & Profit
SELECT 
    YEAR(Order_Date) AS Year,
    QUARTER(Order_Date) AS Quarter,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY YEAR(Order_Date), QUARTER(Order_Date)
ORDER BY YEAR(Order_Date), QUARTER(Order_Date);

-- 8. Discount Impact on Profitability
SELECT 
    CASE 
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount BETWEEN 0.01 AND 0.2 THEN 'Low (0-20%)'
        WHEN Discount BETWEEN 0.21 AND 0.4 THEN 'Medium (21-40%)'
        ELSE 'High (>40%)'
    END AS Discount_Band,
    COUNT(*) AS Order_Count,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit) * 100.0 / NULLIF(SUM(Sales),0), 2) AS Profit_Margin_Percent
FROM superstore
GROUP BY Discount_Band
ORDER BY Profit_Margin_Percent DESC;

-- 9. Seasonal Sales & Profit (If Season column exists)
SELECT 
    Season,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY Season
ORDER BY Total_Sales DESC;