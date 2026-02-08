-- Reset and create the database
USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'RestaurantReservationDB')
BEGIN
    ALTER DATABASE RestaurantReservationDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE RestaurantReservationDB;
END
GO

CREATE DATABASE RestaurantReservationDB;
GO

USE RestaurantReservationDB;
GO

-- Restaurants
CREATE TABLE Restaurants (
    RestaurantId INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    OpeningHours VARCHAR(100) NOT NULL,

    CONSTRAINT UQ_Restaurant_PhoneNumber UNIQUE (PhoneNumber)
);
GO

-- Customers
CREATE TABLE Customers (
    CustomerId INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,

    CONSTRAINT UQ_CustomerEmail UNIQUE (Email),
    CONSTRAINT UQ_CustomerPhoneNumber UNIQUE (PhoneNumber)
);
GO

-- MenuItems
CREATE TABLE MenuItems (
    ItemId INT PRIMARY KEY IDENTITY(1,1),
    RestaurantId INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Description VARCHAR(500) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,

    CONSTRAINT FK_MenuItem_Restaurant FOREIGN KEY (RestaurantId) REFERENCES Restaurants(RestaurantId),
    CONSTRAINT CHK_MenuItem_Price CHECK (Price > 0)
);
GO

-- Employees
CREATE TABLE Employees (
    EmployeeId INT PRIMARY KEY IDENTITY(1,1),
    RestaurantId INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Position VARCHAR(50) NOT NULL,

    CONSTRAINT FK_Employee_Restaurant FOREIGN KEY (RestaurantId) REFERENCES Restaurants(RestaurantId)
);
GO

-- Tables
CREATE TABLE Tables (
    TableId INT PRIMARY KEY IDENTITY(1,1),
    RestaurantId INT NOT NULL,
    Capacity INT NOT NULL,

    CONSTRAINT FK_Table_Restaurant FOREIGN KEY (RestaurantId) REFERENCES Restaurants(RestaurantId),
    CONSTRAINT CHK_Capacity CHECK (Capacity > 0)
);
GO

-- Reservations
CREATE TABLE Reservations (
    ReservationId INT PRIMARY KEY IDENTITY(1,1),
    CustomerId INT NOT NULL,
    RestaurantId INT NOT NULL,
    TableId INT NOT NULL,
    ReservationDate DATETIME NOT NULL,
    PartySize INT NOT NULL,

    CONSTRAINT FK_Reservation_Customer FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId),
    CONSTRAINT FK_Reservation_Restaurant FOREIGN KEY (RestaurantId) REFERENCES Restaurants(RestaurantId),
    CONSTRAINT FK_Reservation_Table FOREIGN KEY (TableId) REFERENCES Tables(TableId),
    CONSTRAINT CHK_Reservation_PartySize CHECK (PartySize > 0)
);
GO

-- Orders
CREATE TABLE Orders (
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    ReservationId INT NOT NULL,
    EmployeeId INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
    TotalAmount DECIMAL(10, 2) NOT NULL,

    CONSTRAINT FK_Order_Reservation FOREIGN KEY (ReservationId) REFERENCES Reservations(ReservationId),
    CONSTRAINT FK_Order_Employee FOREIGN KEY (EmployeeId) REFERENCES Employees(EmployeeId),
    CONSTRAINT CHK_Order_TotalAmount CHECK (TotalAmount >= 0)
);
GO

-- OrderItems
CREATE TABLE OrderItems (
    OrderItemId INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT NOT NULL,
    ItemId INT NOT NULL,
    Quantity INT NOT NULL,

    CONSTRAINT FK_OrderItem_Order FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    CONSTRAINT FK_OrderItem_MenuItem FOREIGN KEY (ItemId) REFERENCES MenuItems(ItemId),
    CONSTRAINT CHK_OrderItem_Quantity CHECK (Quantity > 0)
);
GO