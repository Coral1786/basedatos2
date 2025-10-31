USE AdventureWorksDW2022;
GO

SELECT 
    (SELECT 'Q' + CAST(DATEPART(QUARTER, CAST(d.FullDateAlternateKey AS DATETIME)) AS VARCHAR(1))
            + ' - ' + CAST(d.CalendarYear AS VARCHAR(4))
    ) AS QuarterLabel,
    SUM(f.SalesAmount) AS TotalSales
FROM FactInternetSales AS f
INNER JOIN DimDate AS d
    ON f.OrderDateKey = d.DateKey
WHERE d.CalendarYear BETWEEN 2012 AND 2013
GROUP BY DATEPART(QUARTER, d.FullDateAlternateKey), d.CalendarYear
ORDER BY d.CalendarYear, DATEPART(QUARTER, d.FullDateAlternateKey);
