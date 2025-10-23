SELECT 
    t.SalesTerritoryRegion AS Region,
    SUM(f.SalesAmount) AS TotalSales
FROM FactResellerSales AS f
INNER JOIN DimSalesTerritory AS t
    ON f.SalesTerritoryKey = t.SalesTerritoryKey
GROUP BY t.SalesTerritoryRegion
ORDER BY TotalSales DESC;
