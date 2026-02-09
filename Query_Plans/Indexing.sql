USE RestaurantDB;
GO

-- Reservations
CREATE NONCLUSTERED INDEX IX_Reservations_CustomerId
ON Reservations(CustomerId);

CREATE NONCLUSTERED INDEX IX_Reservations_RestaurantId
ON Reservations(RestaurantId);

CREATE NONCLUSTERED INDEX IX_Reservations_ReservationDate
ON Reservations(ReservationDate);

-- Orders
CREATE NONCLUSTERED INDEX IX_Orders_ReservationId
ON Orders(ReservationId);

CREATE NONCLUSTERED INDEX IX_Orders_EmployeeId
ON Orders(EmployeeId);

-- OrderItems
CREATE NONCLUSTERED INDEX IX_OrderItems_OrderId
ON OrderItems(OrderId);

CREATE NONCLUSTERED INDEX IX_OrderItems_ItemId
ON OrderItems(ItemId);

-- MenuItems
CREATE NONCLUSTERED INDEX IX_MenuItems_RestaurantId
ON MenuItems(RestaurantId);
