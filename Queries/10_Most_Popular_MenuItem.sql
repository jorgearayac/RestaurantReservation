USE RestaurantDB;
GO

-- Popular Menu Item Analysis using Joins and Window Functions: 
-- Identify the most popular menu item for each restaurant for a given month
-- Month and Year for a more precise given month
DECLARE @month INT = 2; -- February
DECLARE @year INT = 2026;

WITH ItemPopularity AS (
    SELECT mi.RestaurantId, mi.Name,
        COUNT(oi.OrderItemId) AS OrderCount,
        ROW_NUMBER() OVER (
            PARTITION BY mi.RestaurantId
            ORDER BY COUNT(oi.OrderItemId) DESC
        ) AS rank
    FROM MenuItems mi
    JOIN OrderItems oi ON mi.ItemId = oi.ItemId
    JOIN Orders o ON oi.OrderId = o.OrderId
    WHERE MONTH(o.OrderDate) = @month AND YEAR(o.OrderDate) = @year
    GROUP BY mi.RestaurantId, mi.Name
)
SELECT *
FROM ItemPopularity
WHERE rank = 1;