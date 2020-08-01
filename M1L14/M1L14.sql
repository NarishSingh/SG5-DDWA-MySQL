USE TrackIt;

-- grab all WorkerId's from ProjectWorker, no duplicates
SELECT *
FROM Worker
WHERE WorkerId IN (
	SELECT WorkerId FROM ProjectWorker
);

-- Table subquery
-- we want to grab the 1st task with its fields from each project
-- fail attempt without subquery - engine won't know which task we are talking about
-- t.Title not part of a group nor is there an agg to pull it
SELECT
	p.Name ProjectName,
    MIN(t.TaskId) MinTaskId
FROM Project p
INNER JOIN Task t ON p.ProjectId = t.ProjectId
GROUP BY p.ProjectId, p.Name;

-- successful attempt with subquery
-- embed a query into the inner join, aliased g, can then use that for the outer query
SELECT
	g.ProjectName,
    g.MinTaskId,
    t.Title MinTaskTitle
FROM Task t
INNER JOIN (
	SELECT
		p.Name ProjectName,
        MIN(t.TaskId) MinTaskId
	FROM Project p
    INNER JOIN Task t ON p.ProjectId = t.ProjectId
    GROUP BY p.ProjectId, p.Name) g ON t.TaskId = g.MinTaskId;

-- Value subquery
-- count worker projects
SELECT
	w.FirstName,
    w.LastName,
    (SELECT COUNT(*) FROM ProjectWorker
		WHERE WorkerId = w.WorkerId) ProjectCount
FROM Worker w;

-- views let you store queries in the database, can be used as a datasource
-- same as table subq
CREATE VIEW ProjectNameWithMinTaskId
AS
SELECT
	p.Name ProjectName,
	MIN(t.TaskId) MinTaskId
FROM Project p
INNER JOIN Task t ON p.ProjectId = t.ProjectId
GROUP BY p.ProjectId, p.Name;

SELECT * FROM ProjectNameWithMinTaskId;

-- joining with a view
SELECT
	pt.ProjectName,
    pt.MinTaskId TaskId,
    t.Title
FROM Task t
INNER JOIN ProjectNameWithMinTaskId pt ON t.TaskId = pt.MinTaskId;

