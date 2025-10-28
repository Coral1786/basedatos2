SELECT 
    c.CustomerKey,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    SUM(f.SalesAmount) AS TotalSpent
FROM DimCustomer AS c
INNER JOIN FactInternetSales AS f
    ON c.CustomerKey = f.CustomerKey
GROUP BY c.CustomerKey, c.FirstName, c.LastName
HAVING SUM(f.SalesAmount) > (
    SELECT AVG(SalesAmount)
    FROM FactInternetSales
);
