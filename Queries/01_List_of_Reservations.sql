USE RestaurantDB;
GO

-- Retrieve all reservations for a specific customer
-- this case: Customer #10
SELECT *
FROM Reservations
WHERE CustomerId = 10;