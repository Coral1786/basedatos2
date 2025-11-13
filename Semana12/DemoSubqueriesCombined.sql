USE AdventureWorksDW2022;
GO

SELECT TOP 5
    r.ResellerName,
    t.SalesTerritoryRegion,
    
    DATENAME(MONTH, MIN(d.FullDateAlternateKey)) + ' ' + CAST(MIN(d.CalendarYear) AS VARCHAR(4)) AS FormattedOrderMonth,
    SUM(f.SalesAmount) AS TotalSales
FROM FactResellerSales AS f
INNER JOIN DimReseller AS r
    ON f.ResellerKey = r.ResellerKey
INNER JOIN DimSalesTerritory AS t
    ON f.SalesTerritoryKey = t.SalesTerritoryKey
INNER JOIN DimDate AS d
    ON f.OrderDateKey = d.DateKey
WHERE d.CalendarYear = (
    SELECT MAX(CalendarYear)
    FROM DimDate
)
GROUP BY r.ResellerName, t.SalesTerritoryRegion
ORDER BY TotalSales DESC;