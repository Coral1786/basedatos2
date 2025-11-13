USE AdventureWorksDW2022;
GO

CREATE TABLE dbo.ResellerBonusHistory
(
    BonusID INT IDENTITY(1,1) PRIMARY KEY,
    ResellerKey INT NOT NULL,
    BonusYear INT NOT NULL,
    BonusAmount MONEY NOT NULL,
    CreatedDate DATETIME NOT NULL
);
GO

-------------------------------------------------------------------------------------------------

BEGIN TRY
    BEGIN TRANSACTION;

    INSERT INTO ResellerBonusHistory (ResellerKey, BonusYear, BonusAmount, CreatedDate)
    SELECT 
        f.ResellerKey,
        d.CalendarYear AS BonusYear,
        CAST(SUM(f.SalesAmount) * 0.05 AS MONEY) AS BonusAmount,  
        GETDATE() AS CreatedDate
    FROM FactResellerSales AS f
    INNER JOIN DimDate AS d
        ON f.OrderDateKey = d.DateKey
    WHERE d.CalendarYear = (
        SELECT MAX(CalendarYear) FROM DimDate
    )
    GROUP BY f.ResellerKey, d.CalendarYear
    HAVING SUM(f.SalesAmount) > 500000;  

    COMMIT TRANSACTION;
    PRINT 'Bonus records successfully inserted.';
END TRY

BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error occurred. Transaction rolled back.';
    PRINT ERROR_MESSAGE();
END CATCH;
GO

-------------------------------------------------------------------------------------------------

SELECT * FROM dbo.ResellerBonusHistory ORDER BY BonusAmount DESC;
