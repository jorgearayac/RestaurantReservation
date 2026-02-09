USE RestaurantDB;
GO

-- Stored Procedure - Borrowed Books Report:
-- Procedure Name: sp_ResrvedTablesReport
-- Purpose: Generate a report of tables reserved within a specified date range
-- Parameters: StartDate, EndDate
-- Implementation: Retrieve all tables reserved within the given range, with details like reservation date, party size and restaurant details
-- Return: Tabulated report of reserved tables
CREATE OR ALTER PROCEDURE sp_ReservedTablesReport (@StartDate DATE, @EndDate DATE)
AS
BEGIN
    SELECT r.ReservationDate, r.PartySize, t.TableId, t.Capacity, rest.Name AS RestaurantName
    FROM Reservations r
    JOIN Tables t ON r.TableId = t.TableId
    JOIN Restaurants rest ON r.RestaurantId = rest.RestaurantId
    WHERE r.ReservationDate BETWEEN @StartDate AND @EndDate
    ORDER BY r.ReservationDate;
END;