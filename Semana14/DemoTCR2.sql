USE AdventureWorksDW2022;
GO

CREATE OR ALTER FUNCTION dbo.fnGetSalesCategory (@SalesAmount DECIMAL(18,2))
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @Category VARCHAR(20);

    IF @SalesAmount < 1000
        SET @Category = 'Low';
    ELSE IF @SalesAmount < 10000
        SET @Category = 'Medium';
    ELSE
        SET @Category = 'High';

    RETURN @Category;
END;
GO