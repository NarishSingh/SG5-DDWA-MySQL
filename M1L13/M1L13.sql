USE TrackIt;

-- count TaskId's - 543
SELECT COUNT(TaskId)
FROM Task;

-- count all - 543
SELECT COUNT(*)
FROM Task;

-- count TaskStatusId, will omit null for - 532
SELECT COUNT(TaskStatusId)
FROM Task;

-- can count from joined tables, even with filters - 276
SELECT COUNT(t.TaskId)
FROM Task t
INNER JOIN TaskStatus s ON t.TaskStatusId = s.TaskStatusId
WHERE s.IsResolved = 1;

-- count tasks per status -> couple w GROUP BY
SELECT
	IFNULL(s.Name, '[none]') StatusName,
    COUNT(t.TaskId) TaskCount
FROM Task t
LEFT OUTER JOIN TaskStatus s ON t.TaskStatusId = s.TaskStatusId
GROUP BY s.Name
ORDER BY s.Name;

-- should fail, but MySQL will allow it
SELECT
	IFNULL(s.Name, '[none]') StatusName,
    s.IsResolved,
    COUNT(t.TaskId) TaskCount
FROM Task t
LEFT OUTER JOIN TaskStatus s ON t.TaskStatusId = s.TaskStatusID
GROUP BY s.Name
ORDER BY s.Name;

-- ^ previous except with proper group, will work 
SELECT
	IFNULL(s.Name, '[none]') StatusName,
    IFNULL(s.IsResolved, 0) IsResolved,
    COUNT(t.TaskId) TaskCount
FROM Task t
LEFT OUTER JOIN TaskStatus s ON t.TaskStatusId = s.TaskStatusId
GROUP BY s.Name, s.IsResolved
ORDER BY s.Name;

-- HAVING to group agg's
--  group and sort by hours
SELECT
	CONCAT(w.FirstName, ' ', w.LastName) WorkerName,
    SUM(t.EstimatedHours) TotalHours
FROM Worker w
INNER JOIN ProjectWorker pw ON w.WorkerId = pw.WorkerId
INNER JOIN Task t ON pw.WorkerID = t.WorkerId
	AND pw.ProjectId = t.ProjectId
GROUP BY w.WorkerId, w.FirstName, w.LastName
HAVING SUM(t.EstimatedHours) >= 100
ORDER BY SUM(t.EstimatedHours) DESC;

-- finding earliest due dates for game related projects
SELECT
	p.Name ProjectName,
    MIN(t.DueDate) MinTaskDueDate
FROM Project p
INNER JOIN Task t ON p.ProjectId = t.ProjectId
WHERE p.ProjectId LIKE 'game-%'
	AND t.ParentTaskId IS NOT NULL
GROUP BY p.ProjectId, p.Name
ORDER BY p.Name;

-- overview of major (10+ task) projects
SELECT
	p.Name ProjectName,
    MIN(t.DueDate) MinTaskDueDate,
    MAX(t.DueDate) MaxTaskDueDate,
    SUM(t.EstimatedHours) TotalHours,
    AVG(t.EstimatedHours) AverageTaskHours,
    COUNT(t.TaskId) TaskCount
FROM Project p
INNER JOIN Task t ON p.ProjectId = t.ProjectId
WHERE t.ParentTaskId IS NOT NULL
GROUP BY p.ProjectId, p.Name
HAVING COUNT(t.TaskId) >= 10
ORDER BY COUNT(t.TaskId) DESC, p.Name;

-- DISTINCT
SELECT DISTINCT
	p.ProjectId,
    p.Name ProjectName
FROM Project p
INNER JOIN Task t ON p.ProjectId = t.ProjectId