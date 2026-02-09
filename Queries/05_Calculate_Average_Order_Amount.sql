USE RestaurantDB;
GO

-- Calculate the average order amount made through a specific employee
DECLARE @EmployeeId INT = 10;

SELECT EmployeeId, AVG(TotalAmount) AS AverageOrderAmount
FROM Orders
WHERE EmployeeId = @EmployeeId
GROUP BY EmployeeId;