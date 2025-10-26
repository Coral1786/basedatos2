SELECT 
    c.CustomerKey,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    COUNT(f.SalesOrderNumber) AS OrderCount
FROM DimCustomer AS c
INNER JOIN FactInternetSales AS f
    ON c.CustomerKey = f.CustomerKey
GROUP BY c.CustomerKey, c.FirstName, c.LastName
ORDER BY OrderCount DESC;