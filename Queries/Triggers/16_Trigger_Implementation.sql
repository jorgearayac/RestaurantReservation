USE RestaurantDB;
GO

-- Design a trigger to log an entry into a separate AuditLog table whenever a table get reserved. 
-- The AuditLog should capture ResturantId, TableId, ReservationDate and ChangeDate
CREATE TABLE AuditLog (
    AuditId INT IDENTITY(1,1) PRIMARY KEY,
    RestaurantId INT,
    TableId INT,
    ReservationDate DATE,
    ChangeDate DATETIME DEFAULT GETDATE(),
);
GO

CREATE TRIGGER trg_AuditReservation
ON Reservations
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO AuditLog (RestaurantId, TableId, ReservationDate, ChangeDate)
    SELECT RestaurantId, TableId, ReservationDate, GETDATE()
    FROM inserted;
END;
GO