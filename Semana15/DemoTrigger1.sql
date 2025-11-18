USE AdventureWorksDW2022;
GO

CREATE OR ALTER FUNCTION dbo.fnFormatMonthYear (@DateValue DATE)
RETURNS VARCHAR(25)
AS
BEGIN
    RETURN DATENAME(MONTH, @DateValue) + ' ' + CAST(YEAR(@DateValue) AS VARCHAR(4));
END;
GO
------------------------------------------------------------------------------------
CREATE TABLE dbo.SalesLog (
    SalesLogID INT IDENTITY(1,1) PRIMARY KEY,
    SalesAmount DECIMAL(18,2),
    OrderDate DATE
);
GO
------------------------------------------------------------------------------------
CREATE TABLE dbo.SalesLogAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    SalesLogID INT,
    FormattedOrderMonth VARCHAR(25),
    AuditDate DATETIME DEFAULT GETDATE()
);
GO
------------------------------------------------------------------------------------
CREATE OR ALTER TRIGGER dbo.trg_AuditSalesLog
ON dbo.SalesLog
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.SalesLogAudit (SalesLogID, FormattedOrderMonth)
    SELECT
        i.SalesLogID,
        dbo.fnFormatMonthYear(i.OrderDate)
    FROM inserted AS i;
END;
GO
