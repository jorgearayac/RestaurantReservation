USE RestaurantDB;
GO

-- Rank restaurants by the reservation frequency
SELECT rest.RestaurantId, rest.Name,
    COUNT(r.ReservationId) AS ReservationCount
FROM Restaurants rest
JOIN Reservations r ON rest.RestaurantId = r.RestaurantId
GROUP BY rest.RestaurantId, rest.Name
ORDER BY ReservationCount DESC;