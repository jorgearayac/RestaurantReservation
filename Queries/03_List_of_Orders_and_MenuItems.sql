USE RestaurantDB;
GO

-- Lists the orders placed on a specific given reservation along with the associated menu items
-- In this case, for Reservation #10
DECLARE @ReservationId INT = 10;

SELECT o.OrderId, o.OrderDate, mi.Name AS MenuItem, oi.Quantity, mi.Price
FROM Orders o
JOIN OrderItems oi ON o.OrderId = oi.OrderId
JOIN MenuItems mi ON oi.ItemId = mi.ItemId
WHERE o.ReservationId = @ReservationId;