USE SalesAnalysis;

SELECT
    SUM(Quantity * Price) AS TotalRevenue
FROM Sales;

-- Category Wise Sales

SELECT
    Category,
    SUM(Quantity * Price) AS CategoryRevenue
FROM Sales
GROUP BY Category
ORDER BY CategoryRevenue DESC;

-- Best Selling Products

SELECT
    ProductName,
    SUM(Quantity) AS TotalQuantitySold
FROM Sales
GROUP BY ProductName
ORDER BY TotalQuantitySold DESC;

-- Customer Wise Spending

SELECT
    Customers.CustomerName,
    SUM(Sales.Quantity * Sales.Price) AS TotalSpending
FROM Customers
INNER JOIN Sales
    ON Customers.CustomerID = Sales.CustomerID
GROUP BY Customers.CustomerName
ORDER BY TotalSpending DESC;

-- Monthly Sales Analysis

SELECT
    MONTH(SaleDate) AS SaleMonth,
    SUM(Quantity * Price) AS MonthlyRevenue
FROM Sales
GROUP BY MONTH(SaleDate)
ORDER BY SaleMonth;

-- Average Order Value

SELECT
    AVG(Quantity * Price) AS AverageOrderValue
FROM Sales;

-- High Value Sales

SELECT
    SaleID,
    ProductName,
    Quantity,
    Price,
    Quantity * Price AS TotalAmount
FROM Sales
WHERE Quantity * Price > 50000
ORDER BY TotalAmount DESC;

-- Sales Performance Classification

SELECT
    SaleID,
    ProductName,
    Quantity * Price AS TotalAmount,
    CASE
        WHEN Quantity * Price > 50000 THEN 'High'
        WHEN Quantity * Price > 20000 THEN 'Medium'
        ELSE 'Low'
    END AS SalesPerformance
FROM Sales;

-- Customer Purchase Details

SELECT
    Customers.CustomerName,
    Sales.ProductName,
    Sales.Quantity,
    Sales.Price,
    Sales.Quantity * Sales.Price AS TotalAmount,
    Sales.SaleDate
FROM Customers
INNER JOIN Sales
    ON Customers.CustomerID = Sales.CustomerID
ORDER BY Sales.SaleDate;

-- Top 3 Customers

SELECT TOP 3
    Customers.CustomerName,
    SUM(Sales.Quantity * Sales.Price) AS TotalSpending
FROM Customers
INNER JOIN Sales
    ON Customers.CustomerID = Sales.CustomerID
GROUP BY Customers.CustomerName
ORDER BY TotalSpending DESC;

-- Category Wise Quantity Sold

SELECT
    Category,
    SUM(Quantity) AS TotalQuantity
FROM Sales
GROUP BY Category
ORDER BY TotalQuantity DESC;

-- Product Wise Revenue

SELECT
    ProductName,
    SUM(Quantity * Price) AS TotalRevenue
FROM Sales
GROUP BY ProductName
ORDER BY TotalRevenue DESC;

-- Daily Sales Analysis

SELECT
    SaleDate,
    SUM(Quantity * Price) AS DailyRevenue
FROM Sales
GROUP BY SaleDate
ORDER BY SaleDate;

-- Customers with Multiple Purchases

SELECT
    Customers.CustomerName,
    COUNT(Sales.SaleID) AS TotalPurchases
FROM Customers
INNER JOIN Sales
    ON Customers.CustomerID = Sales.CustomerID
GROUP BY Customers.CustomerName
HAVING COUNT(Sales.SaleID) > 1
ORDER BY TotalPurchases DESC;

-- Low Sales Products

SELECT
    ProductName,
    SUM(Quantity) AS TotalQuantitySold
FROM Sales
GROUP BY ProductName
HAVING SUM(Quantity) <= 2
ORDER BY TotalQuantitySold ASC;

-- Category Revenue Percentage

SELECT
    Category,
    SUM(Quantity * Price) AS CategoryRevenue,
    CAST(
        SUM(Quantity * Price) * 100.0 /
        (SELECT SUM(Quantity * Price) FROM Sales)
        AS DECIMAL(10,2)
    ) AS RevenuePercentage
FROM Sales
GROUP BY Category
ORDER BY RevenuePercentage DESC;

-- Product Revenue Ranking

SELECT
    ProductName,
    SUM(Quantity * Price) AS TotalRevenue,
    RANK() OVER (
        ORDER BY SUM(Quantity * Price) DESC
    ) AS RevenueRank
FROM Sales
GROUP BY ProductName;

-- Cumulative Sales Revenue

SELECT
    SaleDate,
    ProductName,
    Quantity * Price AS DailySale,
    SUM(Quantity * Price) OVER (
        ORDER BY SaleDate
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS CumulativeRevenue
FROM Sales
ORDER BY SaleDate;

-- Customer Spending Ranking

SELECT
    Customers.CustomerName,
    SUM(Sales.Quantity * Sales.Price) AS TotalSpending,
    RANK() OVER (
        ORDER BY SUM(Sales.Quantity * Sales.Price) DESC
    ) AS CustomerRank
FROM Customers
INNER JOIN Sales
    ON Customers.CustomerID = Sales.CustomerID
GROUP BY Customers.CustomerName;

-- Overall Sales Summary

SELECT
    COUNT(SaleID) AS TotalTransactions,
    SUM(Quantity) AS TotalProductsSold,
    SUM(Quantity * Price) AS TotalRevenue,
    AVG(Quantity * Price) AS AverageSaleValue,
    MAX(Quantity * Price) AS HighestSale,
    MIN(Quantity * Price) AS LowestSale
FROM Sales;

-- Final Project Verification

SELECT * FROM Customers;

SELECT * FROM Sales;