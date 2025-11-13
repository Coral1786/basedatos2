USE AdventureWorksDW2022;
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'SalesBonusLog')
BEGIN
    CREATE TABLE SalesBonusLog (
        LogID INT IDENTITY(1,1) PRIMARY KEY,
        TerritoryName NVARCHAR(100),
        BonusAmount DECIMAL(10,2),
        LogDate DATETIME
    );
    PRINT 'Table SalesBonusLog created successfully.';
END
ELSE
    PRINT 'Table SalesBonusLog already exists.';
GO

-------------------------------------------------------------------------------------------------

BEGIN TRANSACTION;

BEGIN TRY
    INSERT INTO SalesBonusLog (TerritoryName, BonusAmount, LogDate)
    SELECT 
        t.SalesTerritoryRegion AS TerritoryName,
        CAST(SUM(f.SalesAmount) * 0.05 AS DECIMAL(10,2)) AS BonusAmount,
        GETDATE() AS LogDate
    FROM FactResellerSales AS f
    INNER JOIN DimSalesTerritory AS t
        ON f.SalesTerritoryKey = t.SalesTerritoryKey
    INNER JOIN DimDate AS d
        ON f.OrderDateKey = d.DateKey
    WHERE d.CalendarYear = (
        SELECT MAX(d2.CalendarYear)
        FROM FactResellerSales AS f2
        INNER JOIN DimDate AS d2
            ON f2.OrderDateKey = d2.DateKey
    )
    GROUP BY t.SalesTerritoryRegion;

    COMMIT TRANSACTION;
    PRINT 'Transaction committed successfully. Sales bonuses recorded.';

END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error occurred. Transaction rolled back.';
   
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO

-------------------------------------------------------------------------------------------------

SELECT * FROM SalesBonusLog ORDER BY LogDate DESC;
GO
