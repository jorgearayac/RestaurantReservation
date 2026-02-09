USE RestaurantDB;
GO

SELECT DB_NAME() AS CurrentDatabase;


USE RestaurantDB;
GO

SELECT * FROM Restaurants;

SET NOCOUNT ON;

DECLARE @n_restaurants INT = 50;
DECLARE @n_customers INT = 400;
DECLARE @n_tables INT = 100;
DECLARE @n_employees INT = 100;
DECLARE @n_menuitems INT = 1000;
DECLARE @n_reservations INT = 500;
DECLARE @n_orders INT = 500;
DECLARE @n_order_items INT = 1500;

DECLARE @counter INT;

-- Restaurants
SET @counter = 1;
WHILE @counter <= @n_restaurants
BEGIN
    INSERT INTO Restaurants (Name, Address, PhoneNumber, OpeningHours)
    VALUES (
        CONCAT('Restaurant', @counter),
        CONCAT('Address', @counter),
        CONCAT('111-1', FORMAT(@counter, '000')),
        '09:00 - 22:00'
    );
    SET @counter += 1;
END

-- Customers
SET @counter = 1;
WHILE @counter <= @n_customers
BEGIN
    INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber)
    VALUES (
        CONCAT('Customer', @counter),
        CONCAT('Last', @counter),
        CONCAT('customer', @counter, '@email.com'),
        CONCAT('111-2', FORMAT(@counter, '000'))
    );
    SET @counter += 1;
END

-- Tables
SET @counter = 1;
WHILE @counter <= @n_tables
BEGIN
    INSERT INTO Tables (RestaurantId, Capacity)
    SELECT TOP 1 RestaurantId, 2 + ABS(CHECKSUM(NEWID())) % 7
    FROM Restaurants
    ORDER BY NEWID();

    SET @counter += 1;
END;

-- Employees
SET @counter = 1;
WHILE @counter <= @n_employees
BEGIN
    INSERT INTO Employees (RestaurantId, FirstName, LastName, Position)
    SELECT TOP 1
        RestaurantId,
        CONCAT('Employee', @counter),
        'Generated',
        CASE ABS(CHECKSUM(NEWID())) % 5
            WHEN 0 THEN 'VIPOrdersWaiter'
            WHEN 1 THEN 'StandardWaiter'
            WHEN 2 THEN 'AssistantWaiter'
            WHEN 3 THEN 'Cook'
            ELSE 'Manager'
        END
    FROM Restaurants
    ORDER BY NEWID();

    SET @counter += 1;
END;

-- MenuItems
SET @counter = 1;
WHILE @counter <= @n_menuitems
BEGIN
    INSERT INTO MenuItems (RestaurantId, Name, Description, Price)
    SELECT TOP 1
        RestaurantId,
        CONCAT('Item ', @counter),
        CONCAT('Description ', @counter),
        5 + ABS(CHECKSUM(NEWID())) % 35
    FROM Restaurants
    ORDER BY NEWID();

    SET @counter += 1;
END;

-- Reservations
SET @counter = 1;
WHILE @counter <= @n_reservations
BEGIN
    DECLARE @TableId INT, @Capacity INT, @RestaurantId INT;

    SELECT TOP 1 
        @TableId = TableId,
        @Capacity = Capacity,
        @RestaurantId = RestaurantId
    FROM Tables
    ORDER BY NEWID();

    INSERT INTO Reservations (
        CustomerId, RestaurantId, TableId, ReservationDate, PartySize
    )
    VALUES (
        (SELECT TOP 1 CustomerId FROM Customers ORDER BY NEWID()),
        @RestaurantId,
        @TableId,
        DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 60 - 30, GETDATE()),
        CASE 
            WHEN ABS(CHECKSUM(NEWID())) % 8 + 1 > @Capacity THEN @Capacity
            ELSE ABS(CHECKSUM(NEWID())) % 8 + 1
        END
    );

    SET @counter += 1;
END;

-- Orders
SET @counter = 1;
WHILE @counter <= @n_orders
BEGIN
    INSERT INTO Orders (ReservationId, EmployeeId, OrderDate, TotalAmount)
    VALUES (
        (SELECT TOP 1 ReservationId FROM Reservations ORDER BY NEWID()),
        (SELECT TOP 1 EmployeeId FROM Employees ORDER BY NEWID()),
        DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 60 - 30, GETDATE()),
        15 + ABS(CHECKSUM(NEWID())) % 150
    );
    SET @counter += 1;
END;

-- OrderItems
SET @counter = 1;
WHILE @counter <= @n_order_items
BEGIN
    DECLARE @OrderId INT, @ResRestaurantId INT;

    SELECT TOP 1 
        @OrderId = o.OrderId,
        @ResRestaurantId = r.RestaurantId
    FROM Orders o
    JOIN Reservations r ON o.ReservationId = r.ReservationId
    ORDER BY NEWID();

    INSERT INTO OrderItems (OrderId, ItemId, Quantity)
    VALUES (
        @OrderId,
        (SELECT TOP 1 ItemId FROM MenuItems WHERE RestaurantId = @ResRestaurantId ORDER BY NEWID()),
        1 + ABS(CHECKSUM(NEWID())) % 5
    );

    SET @counter += 1;
END;