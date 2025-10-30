USE AdventureWorksDW2022
SELECT 
    SalesOrderNumber,
    OrderDate,
    SalesAmount
FROM FactInternetSales
WHERE YEAR(OrderDate) = (
    SELECT MAX(YEAR(CAST(OrderDate AS DATE)))
    FROM FactInternetSales
);
