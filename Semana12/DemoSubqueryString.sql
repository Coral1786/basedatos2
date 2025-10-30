USE AdventureWorksDW2022
SELECT 
    p.EnglishProductName,
    ps.EnglishProductSubcategoryName
FROM DimProduct AS p
INNER JOIN DimProductSubcategory AS ps
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
WHERE p.EnglishProductName LIKE CONCAT('%', (
    SELECT TOP 1 ps2.EnglishProductSubcategoryName
    FROM DimProductSubcategory AS ps2
    WHERE ps2.ProductSubcategoryKey = p.ProductSubcategoryKey
), '%');
