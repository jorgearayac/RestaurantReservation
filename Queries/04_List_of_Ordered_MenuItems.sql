USE RestaurantDB;
GO

-- Lists the menu items ordered by a specific reservation
DECLARE @ReservationId INT = 10;

SELECT mi.Name, SUM(oi.Quantity) AS TotalQuantity
FROM Orders o
JOIN OrderItems oi ON o.OrderId = oi.OrderId
JOIN MenuItems mi ON oi.ItemId = mi.ItemId
WHERE o.ReservationId = @ReservationId
GROUP BY mi.Name;