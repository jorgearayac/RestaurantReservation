USE RestaurantDB;
GO

-- Stored Procedure - Add New Order
-- Procedure Name: sp_AddNewOrder
-- Purpose: Streamline the process of adding a new order
-- Parameters: ReservationId, EmployeeId, OrderDate, and TotalAmount
-- Implementation: Check if the specified reservation and employee exist, if not, return an error message, if existing, add new order
-- Return: The new BorrowerID or an error message.
CREATE OR ALTER PROCEDURE sp_AddNewOrder (@ReservationId INT, @EmployeeId INT, @OrderDate DATE, @TotalAmount DECIMAL(10,2))
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Reservations WHERE ReservationId = @ReservationId)
        THROW 50000, 'Reservation does not exists', 1;
    IF NOT EXISTS (SELECT 1 FROM Employees WHERE EmployeeId = @EmployeeId)
        THROW 50001, 'Employee does not exists', 1;
    
    INSERT INTO Orders (ReservationId, EmployeeId, OrderDate, TotalAmount)
    VALUES (@ReservationId, @EmployeeId, @OrderDate, @TotalAmount);

    SELECT SCOPE_IDENTITY() AS BorrowerId;
END;