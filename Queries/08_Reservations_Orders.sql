USE RestaurantDB;
GO

-- Identify reservations which have 2 or more orders using CTEs
WITH CTE_ReservationOrders AS (
    SELECT ReservationId, COUNT(*) AS OrderCount
    FROM Orders
    GROUP BY ReservationId
)
SELECT *
FROM CTE_ReservationOrders
WHERE OrderCount >= 2;