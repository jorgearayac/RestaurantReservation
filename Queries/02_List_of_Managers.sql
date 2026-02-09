USE RestaurantDB;
GO

-- Retrieve all employees holding Manager position
SELECT *
FROM Employees
WHERE Position = 'Manager';