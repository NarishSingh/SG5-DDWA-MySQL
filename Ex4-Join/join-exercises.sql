USE PersonalTrainer;

-- Select all columns from ExerciseCategory and Exercise.
-- The tables should be joined on ExerciseCategoryId.
-- This query returns all Exercises and their associated ExerciseCategory.
-- 64 rows
--------------------
SELECT *
FROM Exercise e
INNER JOIN ExerciseCategory ec ON e.ExerciseCategoryId = ec.ExerciseCategoryId;


-- Select ExerciseCategory.Name and Exercise.Name
-- where the ExerciseCategory does not have a ParentCategoryId (it is null).
-- Again, join the tables on their shared key (ExerciseCategoryId).
-- 9 rows
--------------------
SELECT
	ec.Name,
	e.Name
FROM Exercise e
INNER JOIN ExerciseCategory ec ON e.ExerciseCategoryId = ec.ExerciseCategoryId
WHERE ec.ParentCategoryId IS NULL;


-- The query above is a little confusing. At first glance, it's hard to tell
-- which Name belongs to ExerciseCategory and which belongs to Exercise.
-- Rewrite the query using an aliases. 
-- Alias ExerciseCategory.Name as 'CategoryName'.
-- Alias Exercise.Name as 'ExerciseName'.
-- 9 rows
--------------------
SELECT
	ec.Name CategoryName,
	e.Name ExerciseName
FROM Exercise e
INNER JOIN ExerciseCategory ec ON e.ExerciseCategoryId = ec.ExerciseCategoryId
WHERE ec.ParentCategoryId IS NULL;


-- Select FirstName, LastName, and BirthDate from Client
-- and EmailAddress from Login 
-- where Client.BirthDate is in the 1990s.
-- Join the tables by their key relationship. 
-- What is the primary-foreign key relationship?
-- 35 rows
--------------------
SELECT
	c.FirstName,
    c.LastName,
    c.BirthDate,
    l.EmailAddress
FROM Client c
INNER JOIN Login l ON c.ClientId = l.ClientId
WHERE c.BirthDate > '1990-01-01'
	AND c.BirthDate < ' 1999-12-31';


-- Select Workout.Name, Client.FirstName, and Client.LastName
-- for Clients with LastNames starting with 'C'?
-- How are Clients and Workouts related?
-- 25 rows
--------------------
SELECT
	w.Name,
    c.FirstName,
    c.LastName
FROM Client c
INNER JOIN ClientWorkout cw ON cw.ClientId = c.ClientId
INNER JOIN Workout w ON w.WorkoutId = cw.WorkoutId
WHERE c.LastName LIKE 'C%';


-- Select Names from Workouts and their Goals.
-- This is a many-to-many relationship with a bridge table.
-- Use aliases appropriately to avoid ambiguous columns in the result.
--------------------
SELECT
	w.Name WorkoutName,
    g.Name WorkoutGoal
FROM Workout w
INNER JOIN WorkoutGoal wg ON wg.WorkoutId = w. WorkoutId
INNER JOIN Goal g ON g.GoalId = wg.GoalId;


-- Select FirstName and LastName from Client.
-- Select ClientId and EmailAddress from Login.
-- Join the tables, but make Login optional.
-- 500 rows
--------------------
SELECT
	c.FirstName,
    c.LastName,
    l.ClientId,
    l.EmailAddress
FROM Client c
LEFT OUTER JOIN Login l ON c.ClientId = l.ClientId;


-- Using the query above as a foundation, select Clients
-- who do _not_ have a Login.
-- 200 rows
--------------------
SELECT
	c.FirstName,
    c.LastName,
    l.ClientId,
    l.EmailAddress
FROM Client c
LEFT OUTER JOIN Login l ON c.ClientId = l.ClientId
WHERE l.ClientId IS NULL
	AND l.EmailAddress IS NULL;


-- Does the Client, Romeo Seaward, have a Login?
-- Decide using a single query.
-- nope :(
--------------------
SELECT
	c.FirstName,
    c.LastName,
    l.EmailAddress
FROM Client c
INNER JOIN Login l ON c.ClientId = l.ClientId
WHERE c.FirstName = 'Romeo' 
	AND c.LastName = 'Seaward';


-- Select ExerciseCategory.Name and its parent ExerciseCategory's Name.
-- This requires a self-join.
-- 12 rows
--------------------
SELECT
	parent.Name ParentExerciseCategory,
    child.Name ChildExerciseCategory
FROM ExerciseCategory parent
INNER JOIN ExerciseCategory child ON parent.ExerciseCategoryId = child.ParentCategoryId;

    
-- Rewrite the query above so that every ExerciseCategory.Name is
-- included, even if it doesn't have a parent.
-- 16 rows
--------------------
SELECT
	parent.Name ParentExerciseCategory,
    child.Name ChildExerciseCategory
FROM ExerciseCategory parent
RIGHT OUTER JOIN ExerciseCategory child ON parent.ExerciseCategoryId = child.ParentCategoryId;


-- Are there Clients who are not signed up for a Workout?
-- 50 rows
--------------------
SELECT
	c.ClientId,
    w.WorkoutId
FROM Client c
LEFT OUTER JOIN ClientWorkout cw ON c.ClientId = cw.ClientId
LEFT OUTER JOIN Workout w ON w.WorkoutId = cw.WorkoutId
WHERE w.WorkoutId IS NULL;
-- ClientWorkout will lack the 50 ClientId's, so left joins to pull all clients
-- then left join again to match the blank workouts


-- Which Beginner-Level Workouts (lvl 1) satisfy at least one of Shell Creane's Goals?
-- Goals are associated to Clients through ClientGoal.
-- Goals are associated to Workouts through WorkoutGoal.
-- 6 rows, 4 unique rows
-- Name (client) -> (clientgoal) clientId -> (goal) goalid -> (workoutgoal) goalid -> (workout) workoutid 
--------------------
SELECT
	c.FirstName,
    c.LastName,
    cg.GoalId,
    wg.WorkoutId,
    g.Name GoalCategory,
    w.Name WorkoutName
FROM Client c
INNER JOIN ClientGoal cg ON cg.ClientId = c.ClientId
INNER JOIN Goal g ON g.GoalId = cg.GoalId
INNER JOIN WorkoutGoal wg ON wg.GoalId = g.GoalId
INNER JOIN Workout w ON w.WorkoutId = wg.WorkoutId
WHERE c.FirstName = 'Shell'
	AND c.LastName = 'Creane'
    and w.LevelId = 1;


-- Select all Workouts. 
-- Join to the Goal, 'Core Strength', but make it optional.
-- You may have to look up the GoalId before writing the main query.
-- If you filter on Goal.Name in a WHERE clause, Workouts will be excluded.
-- Why?
-- 26 Workouts, 3 Goals
--------------------
SELECT * FROM Goal;
SELECT * FROM WorkoutGoal;

SELECT * 
FROM Workout w
LEFT OUTER JOIN WorkoutGoal wg ON wg.WorkoutId = w.WorkoutId
LEFT OUTER JOIN Goal g ON g.GoalId = wg.GoalId
-- WHERE g.Name = 'Core Strength';
-- TODO CONTINUE HERE


-- The relationship between Workouts and Exercises is... complicated.
-- Workout links to WorkoutDay (one day in a Workout routine)
-- which links to WorkoutDayExerciseInstance 
-- (Exercises can be repeated in a day so a bridge table is required) 
-- which links to ExerciseInstance 
-- (Exercises can be done with different weights, repetions,
-- laps, etc...) 
-- which finally links to Exercise.
-- Select Workout.Name and Exercise.Name for related Workouts and Exercises.
--------------------
   
-- An ExerciseInstance is configured with ExerciseInstanceUnitValue.
-- It contains a Value and UnitId that links to Unit.
-- Example Unit/Value combos include 10 laps, 15 minutes, 200 pounds.
-- Select Exercise.Name, ExerciseInstanceUnitValue.Value, and Unit.Name
-- for the 'Plank' exercise. 
-- How many Planks are configured, which Units apply, and what 
-- are the configured Values?
-- 4 rows, 1 Unit, and 4 distinct Values
--------------------