USE TrackIT;

-- sort by LastName desending
SELECT *
FROM Worker
ORDER BY LastName DESC;

-- ascending, but ASC isn't really required
SELECT *
FROM Worker
ORDER BY LastName ASC;

-- aliasing
SELECT
	w.FirstName,
    w.LastName,
    p.Name ProjectName
FROM Worker w
INNER JOIN ProjectWorker pw ON w.WorkerId = pw.WorkerId
INNER JOIN Project p ON pw.ProjectId = p.ProjectId
ORDER BY w.LastName asc;

-- multiple col sorting
SELECT
	w.FirstName,
    w.LastName,
    p.Name ProjectName
FROM Worker w
INNER JOIN ProjectWorker pw ON w.WorkerId = pw.WorkerId
INNER JOIN Project p ON pw.ProjectId = p.ProjectId
ORDER BY w.LastName ASC, p.Name ASC;

SELECT
	w.FirstName,
    w.LastName,
    p.Name ProjectName
FROM Worker w
INNER JOIN ProjectWorker pw ON w.WorkerId = pw.WorkerId
INNER JOIN Project p ON pw.ProjectId = p.ProjectId
ORDER BY w.LastName DESC, p.Name ASC;

-- sort null values to appear at the bottom of results
SELECT
	t.Title,
    s.Name StatusName
FROM Task t
LEFT OUTER JOIN TaskStatus s ON t.TaskStatusId = s.TaskStatusId
ORDER BY ISNULL(s.Name), s.Name ASC;

-- LIMIT
-- first 10 
SELECT *
FROM Worker
ORDER BY LastName DESC
LIMIT 0, 10;

-- 10 after 10th row
SELECT *
FROM Worker
ORDER BY LastName DESC
LIMIT 10, 10;

-- offset past legal rows - no returns
SELECT *
FROM Worker
ORDER BY LastName DESC
LIMIT 200, 10;

--  25 past 100th row in a complex query
SELECT
	w.FirstName,
    w.LastName,
    p.Name ProjectName
FROM Worker w
INNER JOIN ProjectWorker pw ON w.WorkerId = pw.WorkerId
INNER JOIN Project p ON pw.ProjectId = p.ProjectId
ORDER BY w.LastName DESC, p.Name ASC
LIMIT 100, 25;