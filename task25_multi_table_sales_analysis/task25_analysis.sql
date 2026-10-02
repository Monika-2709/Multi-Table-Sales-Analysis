-- TASK 25 | MULTI-TABLE SALES ANALYSIS
-- Dataset: Northwind-style relational sales dataset
-- Tables: customers, products, orders
-- Dialect: SQLite-compatible SQL

-- ============================================================
-- 1. BASIC DATA CHECKS
-- ============================================================
SELECT COUNT(*) AS customer_count FROM customers;
SELECT COUNT(*) AS product_count FROM products;
SELECT COUNT(*) AS order_count FROM orders;

-- Primary-key uniqueness checks
SELECT CustomerID, COUNT(*) AS cnt
FROM customers
GROUP BY CustomerID
HAVING COUNT(*) > 1;

SELECT ProductID, COUNT(*) AS cnt
FROM products
GROUP BY ProductID
HAVING COUNT(*) > 1;

SELECT OrderID, COUNT(*) AS cnt
FROM orders
GROUP BY OrderID
HAVING COUNT(*) > 1;

-- ============================================================
-- 2. FOREIGN-KEY / JOIN VALIDATION
-- ============================================================
-- Orders without a valid customer
SELECT COUNT(*) AS orphan_customer_orders
FROM orders o
LEFT JOIN customers c ON o.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;

-- Orders without a valid product
SELECT COUNT(*) AS orphan_product_orders
FROM orders o
LEFT JOIN products p ON o.ProductID = p.ProductID
WHERE p.ProductID IS NULL;

-- ============================================================
-- 3. COMBINED ANALYSIS TABLE
-- ============================================================
SELECT
    o.OrderID,
    o.OrderDate,
    c.CustomerID,
    c.CustomerName,
    c.Country,
    c.Segment,
    p.ProductID,
    p.ProductName,
    p.Category,
    p.UnitPrice,
    o.Quantity,
    o.DiscountPct,
    o.GrossSales,
    o.DiscountAmount,
    o.NetSales
FROM orders o
INNER JOIN customers c ON o.CustomerID = c.CustomerID
INNER JOIN products p ON o.ProductID = p.ProductID;

-- ============================================================
-- 4. SALES BY COUNTRY
-- ============================================================
SELECT
    c.Country,
    ROUND(SUM(o.NetSales), 2) AS total_sales,
    SUM(o.Quantity) AS units_sold,
    COUNT(DISTINCT o.OrderID) AS orders
FROM orders o
JOIN customers c ON o.CustomerID = c.CustomerID
GROUP BY c.Country
ORDER BY total_sales DESC;

-- ============================================================
-- 5. SALES BY CATEGORY
-- ============================================================
SELECT
    p.Category,
    ROUND(SUM(o.NetSales), 2) AS total_sales,
    SUM(o.Quantity) AS units_sold,
    COUNT(DISTINCT o.OrderID) AS orders
FROM orders o
JOIN products p ON o.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY total_sales DESC;

-- ============================================================
-- 6. TOP 10 PRODUCTS
-- ============================================================
SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    ROUND(SUM(o.NetSales), 2) AS total_sales,
    SUM(o.Quantity) AS units_sold
FROM orders o
JOIN products p ON o.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category
ORDER BY total_sales DESC
LIMIT 10;

-- ============================================================
-- 7. TOP 10 CUSTOMERS
-- ============================================================
SELECT
    c.CustomerID,
    c.CustomerName,
    c.Country,
    c.Segment,
    ROUND(SUM(o.NetSales), 2) AS total_sales,
    COUNT(DISTINCT o.OrderID) AS order_count
FROM orders o
JOIN customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.Country, c.Segment
ORDER BY total_sales DESC
LIMIT 10;

-- ============================================================
-- 8. MONTHLY SALES
-- ============================================================
SELECT
    substr(o.OrderDate, 1, 7) AS month,
    ROUND(SUM(o.NetSales), 2) AS total_sales,
    SUM(o.Quantity) AS units_sold
FROM orders o
GROUP BY substr(o.OrderDate, 1, 7)
ORDER BY month;

-- ============================================================
-- 9. CUSTOMER SEGMENT ANALYSIS
-- ============================================================
SELECT
    c.Segment,
    ROUND(SUM(o.NetSales), 2) AS total_sales,
    COUNT(DISTINCT c.CustomerID) AS customers,
    COUNT(DISTINCT o.OrderID) AS orders,
    ROUND(SUM(o.NetSales) / COUNT(DISTINCT o.OrderID), 2) AS avg_order_value
FROM orders o
JOIN customers c ON o.CustomerID = c.CustomerID
GROUP BY c.Segment
ORDER BY total_sales DESC;

-- ============================================================
-- 10. TOTAL VALIDATION
-- ============================================================
-- Direct total from orders
SELECT ROUND(SUM(NetSales), 2) AS order_table_total
FROM orders;

-- Total after joining all dimensions
SELECT ROUND(SUM(o.NetSales), 2) AS joined_total
FROM orders o
JOIN customers c ON o.CustomerID = c.CustomerID
JOIN products p ON o.ProductID = p.ProductID;

-- The two totals should match when joins are one-to-one from
-- each dimension key to its corresponding dimension row.
