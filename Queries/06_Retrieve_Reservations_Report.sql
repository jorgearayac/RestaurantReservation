USE RestaurantDB;
GO

-- Use a view to list all reservations information including restaurants and customers information

CREATE VIEW vw_ReservationReport AS
SELECT r.ReservationId, r.ReservationDate, r.PartySize, 
    rest.Name AS RestaurantName, rest.Address, rest.PhoneNumber AS RestaurantPhone, 
    c.FirstName, c.LastName, c.Email, c.PhoneNumber AS CustomerPhone   
FROM Reservations r
JOIN Customers c ON r.CustomerId = c.CustomerId
JOIN Restaurants rest ON r.RestaurantId = rest.RestaurantId;
GO

SELECT *
FROM vw_ReservationReport;