USE AdventureWorksDW2022
---------------------------------------------------------------
SELECT --Consulta 1: Comparación de las ventas anuales
    YEAR(d.FullDateAlternateKey) AS SalesYear,
    SUM(f.SalesAmount) AS TotalSales
FROM FactInternetSales AS f
INNER JOIN DimDate AS d
    ON f.OrderDateKey = d.DateKey
GROUP BY YEAR(d.FullDateAlternateKey)
HAVING SUM(f.SalesAmount) > (
    SELECT AVG(AnnualSales)
    FROM (
        SELECT SUM(f2.SalesAmount) AS AnnualSales
        FROM FactInternetSales AS f2
        INNER JOIN DimDate AS d2
            ON f2.OrderDateKey = d2.DateKey
        GROUP BY YEAR(d2.FullDateAlternateKey)
    ) AS YearlySales
)
ORDER BY SalesYear;
---------------------------------------------------------------
SELECT --Consulta 2: Clientes que no compran desde el 2012
    c.CustomerKey,
    c.FirstName + ' ' + c.LastName AS CustomerName
FROM DimCustomer AS c
WHERE c.CustomerKey NOT IN (
    SELECT DISTINCT f.CustomerKey
    FROM FactInternetSales AS f
    INNER JOIN DimDate AS d
        ON f.OrderDateKey = d.DateKey
    WHERE d.FullDateAlternateKey >= DATEADD(YEAR, -14, GETDATE())
);
