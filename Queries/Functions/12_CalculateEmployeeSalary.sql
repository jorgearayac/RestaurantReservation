USE RestaurantDB;
GO

-- Database Function - Calculate Employees Salary:
-- Function Name: fn_CalculateEmployeeSalary
-- Purpose: Compute the salary for a given employee
-- Parameter: EmployeeId
-- Implementation: Salary is defined as: # number of orders made by specific employee * employee rank
    -- Employee’s rank based on position: Position = VIPOrdersWaiter = 5, StandardWaiter = 4, AssistantWaiter  = 3
-- Return: salary for the EmployeeId. 
CREATE FUNCTION fn_CalculateEmployeeSalary (@EmployeeId INT)
RETURNS INT
BEGIN
    DECLARE @rank INT;
    DECLARE @orders INT;
    DECLARE @salary INT;

    SELECT @rank =
        CASE Position
            WHEN 'VIPOrdersWaiter' THEN 5
            WHEN 'StandardWaiter' THEN 4
            WHEN 'AssistantWaiter' THEN 3
            ELSE 0
        END
    FROM Employees
    WHERE EmployeeId = @EmployeeId;

    SELECT @orders = COUNT(*)
    FROM Orders
    WHERE EmployeeId = @EmployeeId;

    SET @salary = ISNULL(@orders,0) * ISNULL(@rank,0);

    RETURN @salary;
END;