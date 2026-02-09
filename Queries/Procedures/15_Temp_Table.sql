USE RestaurantDB;
GO

-- SQL Stored Procedure with Temp Table:
-- Design a stored procedure that retrieves all tables which have future reservations.
-- Store these tables in a temporary table, then join this temp table with the Restaurants table
-- to list out the specific information about the associated restaurants.
CREATE PROCEDURE sp_FutureReservedTables
AS
BEGIN
    CREATE TABLE #FutureTables (TableId INT, RestaurantId INT);
    INSERT INTO #FutureTables
    SELECT DISTINCT TableId, RestaurantId
    FROM Reservations
    WHERE ReservationDate > GETDATE();

    SELECT rest.Name AS RestaurantName, t.TableId
    FROM #FutureTables ft
    JOIN Tables t ON ft.TableId = t.TableId
    JOIN Restaurants rest ON ft.RestaurantId = rest.RestaurantId;

    DROP TABLE #FutureTables;
END;