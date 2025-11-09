USE AdventureWorksDW2022;
GO

-- Remove existing version if present
IF OBJECT_ID('dbo.fn_GetTopResellersByYear', 'IF') IS NOT NULL
    DROP FUNCTION dbo.fn_GetTopResellersByYear;
GO

CREATE FUNCTION dbo.fn_GetTopResellersByYear
(
    @Year INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        t.SalesTerritoryRegion,
        r.ResellerName,
        SUM(f.SalesAmount) AS TotalSales,
        COUNT(f.SalesOrderNumber) AS OrdersCount
    FROM FactResellerSales AS f
    INNER JOIN DimReseller AS r
        ON f.ResellerKey = r.ResellerKey
    INNER JOIN DimSalesTerritory AS t
        ON f.SalesTerritoryKey = t.SalesTerritoryKey
    INNER JOIN DimDate AS d
        ON f.OrderDateKey = d.DateKey
    WHERE d.CalendarYear = @Year
    GROUP BY t.SalesTerritoryRegion, r.ResellerName
);
GO

-----------------------------------------------------------------------
-- Add query to use the function

USE AdventureWorksDW2022;
GO

SELECT TOP 10 *
FROM dbo.fn_GetTopResellersByYear(2013)
ORDER BY TotalSales DESC;