USE RestaurantDB;
GO

-- Retrieve all reservations for a specific customer
-- this case: Customer #10

DECLARE @ReservationId INT = 10;

SELECT *
FROM Reservations
WHERE CustomerId = @ReservationId;