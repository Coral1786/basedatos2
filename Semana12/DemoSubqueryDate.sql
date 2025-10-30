USE AdventureWorksDW2022
SELECT 
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
