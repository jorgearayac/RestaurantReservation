USE RestaurantDB;
GO

-- Use a view to list all employees information including their restaurants details
CREATE VIEW vw_EmployeesDetails AS
SELECT e.EmployeeId, e.FirstName, e.LastName, e.Position,
    rest.Name AS RestaurantName, rest.Address AS RestaurantAddress, rest.PhoneNumber AS RestaurantPhone
FROM Employees e
JOIN Restaurants rest ON e.RestaurantId = rest.RestaurantId;
GO

SELECT *
FROM vw_EmployeesDetails;