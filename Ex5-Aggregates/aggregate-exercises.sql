use PersonalTrainer;

-- Use an aggregate to count the number of Clients.
-- 500 rows
--------------------
SELECT
	COUNT(*)
FROM Client;


-- Use an aggregate to count Client.BirthDate.
-- The number is different than total Clients. Why?
-- 463 rows
--------------------
SELECT
	COUNT(c.BirthDate)
FROM Client c;


-- Group Clients by City and count them.
-- Order by the number of Clients desc.
-- 20 rows
--------------------
SELECT
	c.City,
	COUNT(c.City)
FROM Client c
GROUP BY City
ORDER BY COUNT(c.City) DESC;


-- Calculate a total per invoice using only the InvoiceLineItem table.
-- Group by InvoiceId.
-- You'll need an expression for the line item total: Price * Quantity.
-- Aggregate per group using SUM().
-- 1000 rows
--------------------
SELECT
	i.InvoiceId,
    SUM(i.Price * i.Quantity) InvoiceTotal
FROM InvoiceLineItem i
GROUP BY InvoiceId;


-- Calculate a total per invoice using only the InvoiceLineItem table.
-- (See above.)
-- Only include totals greater than $500.00.
-- Order from lowest total to highest.
-- 234 rows
--------------------
SELECT
	i.InvoiceId,
    SUM(i.Price * i.Quantity) InvoiceTotal
FROM InvoiceLineItem i
GROUP BY InvoiceId
HAVING SUM(i.Price * i.Quantity) > 500
ORDER BY SUM(i.Price * i.Quantity);


-- Calculate the average line item total
-- grouped by InvoiceLineItem.Description.
-- 3 rows
--------------------
SELECT
	i.Description,
	AVG(i.Price * i.Quantity) InvoiceAvg
FROM InvoiceLineItem i
GROUP BY i.Description;


-- Select ClientId, FirstName, and LastName from Client
-- for clients who have *paid* over $1000 total.
-- Paid is Invoice.InvoiceStatus = 2.
-- Order by LastName, then FirstName.
-- 146 rows
--------------------
SELECT
	c.ClientId,
    c.FirstName,
    c.LastName,
    SUM(ili.Price * ili.Quantity) TotalPaid
FROM Client c
INNER JOIN Invoice i ON i.ClientId = c.ClientId
INNER JOIN InvoiceLineItem ili ON ili.InvoiceId = i.InvoiceId
WHERE i.InvoiceStatus = 2
GROUP BY c.LastName, c.FirstName
HAVING SUM(ili.Price * ili.Quantity) > 1000
ORDER BY c.LastName, c.FirstName;


-- Count exercises by category.
-- Group by ExerciseCategory.Name.
-- Order by exercise count descending.
-- 13 rows
--------------------
SELECT
	ec.Name ExerciseCategory,
    COUNT(e.Name) ExerciseCount
FROM ExerciseCategory ec
INNER JOIN Exercise e ON ec.ExerciseCategoryId = e.ExerciseCategoryId
GROUP BY ec.Name
ORDER BY COUNT(e.Name) DESC;


-- Select Exercise.Name along with the minimum, maximum,
-- and average ExerciseInstance.Sets.
-- Order by Exercise.Name.
-- 64 rows
--------------------
SELECT
	e.Name,
    e.ExerciseId,
    MIN(ei.Sets) MinimumSets,
    MAX(ei.Sets) MaximumSets,
    AVG(ei.Sets) AverageSets
FROM Exercise e
INNER JOIN ExerciseInstance ei ON ei.ExerciseId = e.ExerciseId
GROUP BY e.ExerciseId
ORDER BY e.Name;


-- Find the minimum and maximum Client.BirthDate
-- per Workout.
-- 26 rows
-- Sample: 
-- WorkoutName, EarliestBirthDate, LatestBirthDate
-- '3, 2, 1... Yoga!', '1928-04-28', '1993-02-07'
--------------------
SELECT
	w.Name,
	MIN(c.BirthDate) EarliestBirthDate,
    MAX(c.BirthDate) LatestBirthDate
FROM Client c
INNER JOIN ClientWorkout cw ON cw.ClientId = c.ClientId
INNER JOIN Workout w ON w.WorkoutId = cw.WorkoutId
GROUP BY w.WorkoutId;


-- Count client goals.
-- Be careful not to exclude rows for clients without goals.
-- 500 rows total
-- 50 rows with no goals
--------------------
SELECT
	CONCAT(c.FirstName, ' ', c.LastName) ClientName,
    COUNT(cg.GoalId) ClientGoalCount
FROM Client c
LEFT OUTER JOIN ClientGoal cg ON cg.ClientId = c.ClientId
GROUP BY CONCAT(c.FirstName, ' ', c.LastName);
-- HAVING COUNT(cg.GoalId) = 0; -- check for 50 nulls


-- Select Exercise.Name, Unit.Name, 
-- and minimum and maximum ExerciseInstanceUnitValue.Value
-- for all exercises with a configured ExerciseInstanceUnitValue.
-- Order by Exercise.Name, then Unit.Name.
-- 82 rows
--------------------
SELECT
	e.Name ExerciseName,
    u.Name UnitName,
    MIN(eiuv.Value) MinUnitValue,
    MAX(eiuv.Value) MaxUnitValue
FROM Exercise e
INNER JOIN ExerciseInstance ei ON ei.ExerciseId = e.ExerciseId
INNER JOIN ExerciseInstanceUnitValue eiuv ON eiuv.ExerciseInstanceId = ei.ExerciseInstanceId
INNER JOIN Unit u ON u.UnitId = eiuv.UnitId
GROUP BY e.ExerciseId, u.UnitId
ORDER BY e.Name, u.Name;


-- Modify the query above to include ExerciseCategory.Name.
-- Order by ExerciseCategory.Name, then Exercise.Name, then Unit.Name.
-- 82 rows
--------------------
SELECT
    e.Name ExerciseName,
    ec.Name Category,
    u.Name UnitName,
    MIN(eiuv.Value) MinUnitValue,
    MAX(eiuv.Value) MaxUnitValue
FROM Exercise e
INNER JOIN ExerciseInstance ei ON ei.ExerciseId = e.ExerciseId
INNER JOIN ExerciseInstanceUnitValue eiuv ON eiuv.ExerciseInstanceId = ei.ExerciseInstanceId
INNER JOIN Unit u ON u.UnitId = eiuv.UnitId
INNER JOIN ExerciseCategory ec ON ec.ExerciseCategoryId = e.ExerciseCategoryId -- join to exercisecategory
GROUP BY ec.ExerciseCategoryId, e.ExerciseId, u.UnitId
ORDER BY ec.Name, e.Name, u.Name;


-- Select the minimum and maximum age in years for
-- each Level.
-- To calculate age in years, use the MySQL function DATEDIFF.
-- 4 rows
--------------------
SELECT
	l.LevelId,
    l.Name Level,
    MIN(DATEDIFF(CURRENT_DATE, c.BirthDate)/365) MinAge,
    MAX(DATEDIFF(CURRENT_DATE, c.BirthDate)/365) MaxAge
FROM Client c
INNER JOIN ClientWorkout cw ON cw.ClientId = c.ClientId
INNER JOIN Workout w ON w.WorkoutId = cw.WorkoutId
INNER JOIN Level l ON l.LevelId = w.LevelId
GROUP BY l.LevelId
ORDER BY l.LevelId;


-- Stretch Goal!
-- Count logins by email extension (.com, .net, .org, etc...).
-- Research SQL functions to isolate a very specific part of a string value.
-- 27 rows (27 unique email extensions)
--------------------
SELECT EmailAddress FROM Login;

SELECT
	SUBSTRING_INDEX(l.EmailAddress, '.', -1) EmailExtension,
	COUNT(l.EmailAddress) EmailCount
FROM Login l
GROUP BY SUBSTRING_INDEX(l.EmailAddress, '.', -1);


-- Stretch Goal!
-- Match client goals to workout goals.
-- Select Client FirstName and LastName and Workout.Name for
-- all workouts that match at least 2 of a client's goals.
-- Order by the client's last name, then first name.
-- 139 rows
--------------------
SELECT
	c.FirstName,
    c.LastName,
    w.Name WorkoutName,
    w.WorkoutId,
    COUNT(cg.GoalId)
FROM Client c
INNER JOIN ClientGoal cg ON cg.ClientId = c.ClientId
INNER JOIN Goal g ON cg.GoalId = g.GoalId
INNER JOIN WorkoutGoal wg ON wg.GoalId = g.GoalId
INNER JOIN Workout w ON w.WorkoutId = wg.WorkoutId
GROUP BY c.ClientId, w.WorkoutId
HAVING COUNT(cg.GoalId) >= 2
ORDER BY c.LastName, c.FirstName;