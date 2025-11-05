USE AdventureWorksDW2022;
GO

-- Drop the function first if it already exists
IF OBJECT_ID('dbo.fn_GetYearlySalesByProduct', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_GetYearlySalesByProduct;
GO

CREATE FUNCTION dbo.fn_GetYearlySalesByProduct
(
    @ProductKey INT,
    @Year INT
)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalSales DECIMAL(18,2);

    SELECT @TotalSales = SUM(f.SalesAmount)
    FROM FactResellerSales AS f
    INNER JOIN DimDate AS d
        ON f.OrderDateKey = d.DateKey
    WHERE f.ProductKey = @ProductKey
      AND d.CalendarYear = @Year;

    -- If there are no sales, return 0 instead of NULL
    RETURN ISNULL(@TotalSales, 0);
END;
GO

-----------------------------------------------------------------------
-- Add query to use the function
    
USE AdventureWorksDW2022;
GO

SELECT 
    p.EnglishProductName,
    dbo.fn_GetYearlySalesByProduct(p.ProductKey, 2013) AS Sales2013
FROM DimProduct AS p
ORDER BY Sales2013 DESC;

