USE AdventureWorksDW2022;
GO

-- Step 1: Create a temp table to simulate transactional operations
CREATE TABLE #TempSales (
    SalesOrderNumber NVARCHAR(20),
    SalesAmount MONEY
);

BEGIN TRANSACTION;
    PRINT 'Transaction started.';

    -- Step 2: Insert some initial rows
    INSERT INTO #TempSales VALUES ('SO001', 1000);
    INSERT INTO #TempSales VALUES ('SO002', 2000);
    PRINT 'Inserted initial sales.';

    -- Step 3: Create a SAVEPOINT before further operations
    SAVE TRANSACTION BeforeUpdate;
    PRINT 'Savepoint "BeforeUpdate" created.';

    -- Step 4: Perform more changes (maybe one has a logic error)
    UPDATE #TempSales
    SET SalesAmount = SalesAmount * 1.10
    WHERE SalesOrderNumber = 'SO002';
    PRINT 'Updated SO002 sales amount.';

    INSERT INTO #TempSales VALUES ('SO003', -500); -- <-- Bad insert (negative amount)
    PRINT 'Inserted a new (invalid) sale.';

    -- Step 5: Roll back to the SAVEPOINT (undo invalid inserts only)
    PRINT 'Rolling back to savepoint due to invalid data...';
    ROLLBACK TRANSACTION BeforeUpdate;

    -- Step 6: Continue with more valid operations
    INSERT INTO #TempSales VALUES ('SO004', 1500);
    PRINT 'Inserted new valid sale SO004.';

    -- Step 7: Commit all remaining valid work
    COMMIT TRANSACTION;
    PRINT 'Transaction committed successfully.';

-- Step 8: Check final data
SELECT * FROM #TempSales;