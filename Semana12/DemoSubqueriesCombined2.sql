USE AdventureWorksDW2022;
GO

SELECT 
    p.EnglishProductName,
    DATENAME(MONTH, CAST(d.FullDateAlternateKey AS DATETIME)) AS OrderMonth,
    SUM(f.OrderQuantity) AS TotalQuantity
FROM FactResellerSales AS f
INNER JOIN DimProduct AS p
    ON f.ProductKey = p.ProductKey
INNER JOIN DimDate AS d
    ON f.OrderDateKey = d.DateKey
WHERE DATEPART(QUARTER, d.FullDateAlternateKey) = 1
  AND d.CalendarYear = 2013
  AND p.ProductKey IN (
        SELECT ProductKey
        FROM FactResellerSales AS sub
        INNER JOIN DimDate AS d2
            ON sub.OrderDateKey = d2.DateKey
        WHERE d2.CalendarYear = 2013
        GROUP BY ProductKey
        HAVING AVG(CAST(sub.OrderQuantity AS DECIMAL(10,2))) > 50
    )
GROUP BY p.EnglishProductName, DATENAME(MONTH, CAST(d.FullDateAlternateKey AS DATETIME))
ORDER BY TotalQuantity DESC;