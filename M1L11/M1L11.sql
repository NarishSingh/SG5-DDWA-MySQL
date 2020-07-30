USE Trackit;

-- Inner join, only returns results that are present in both tables
SELECT
	Task.TaskId,
    Task.Title,
    TaskStatus.Name
FROM TaskStatus
INNER JOIN Task ON TaskStatus.TaskStatusId = Task.TaskStatusId
WHERE TaskStatus.IsResolved = 1;

-- multiple inner joins for bridge table
SELECT
	Project.Name,
    Worker.FirstName,
    Worker.LastName,
    Task.Title
FROM Project
INNER JOIN ProjectWorker ON Project.ProjectId = ProjectWorker.ProjectId
INNER JOIN Worker ON ProjectWorker.WorkerId = Worker.WorkerId
INNER JOIN Task ON ProjectWorker.ProjectId = Task.ProjectId
WHERE Project.ProjectId = 'game-goodboy';

--  left outer join, all of A + matching only from B
SELECT *
FROM Task
LEFT OUTER JOIN TaskStatus
	ON Task.TaskStatusId = TaskStatus.TaskStatusId;

-- if null
SELECT
	Task.TaskId,
    Task.Title,
    IFNULL(Task.TaskStatusId, 0) AS TaskStatusId,
    IFNULL(TaskStatus.Name, '[None]') AS StatusName
FROM Task
LEFT OUTER JOIN TaskStatus
	ON Task.TaskStatusId = TaskStatus.TaskStatusId;

-- Workerless projects - aliasing + filters out projects with workers
SELECT
	Project.Name ProjectName,
	Worker.FirstName,
    Worker.LastName
FROM Project
LEFT OUTER JOIN ProjectWorker ON Project.ProjectId = ProjectWorker.ProjectId
LEFT OUTER JOIN Worker ON ProjectWorker.WorkerId = ProjectWorker.WorkerId
WHERE ProjectWorker.WorkerId IS NULL;

-- Projectless Workers, full to simpler
SELECT
	Project.Name ProjectName,
	Worker.FirstName,
    Worker.LastName
FROM Project
RIGHT OUTER JOIN ProjectWorker ON Project.ProjectId = ProjectWorker.WorkerId
RIGHT OUTER JOIN Worker ON ProjectWorker.WorkerId = Worker.WorkerId
WHERE ProjectWorker.ProjectId IS NULL;
-- WHERE ProjectWorker.WorkerId IS NULL; -- also works 

SELECT
	Worker.FirstName,
    Worker.LastName
FROM ProjectWorker
RIGHT OUTER JOIN Worker ON ProjectWorker.WorkerId = Worker.WorkerId
WHERE ProjectWorker.ProjectId IS NULL;

SELECT
	Worker.FirstName,
    Worker.LastName
FROM Worker
LEFT OUTER JOIN ProjectWorker ON Worker.WorkerId = ProjectWorker.WorkerId
WHERE ProjectWorker.ProjectId IS NULL;
-- every left join can be made into right joins essentially

-- self-join, aliases the parent and child, uses concentation between parent and child task title 
SELECT
	parent.TaskId ParentTaskId,
    child.TaskId ChildTaskId,
    CONCAT(parent.Title, ': ', child.Title) Title
FROM Task parent
INNER JOIN Task child ON parent.TaskId = child.ParentTaskId;

-- a less verbose way of aliasing
SELECT
	p.Name ProjectName,
    w.FirstName,
    w.LastName,
    t.Title
FROM Project p
INNER JOIN ProjectWorker pw ON  p.ProjectId = pw.ProjectId
INNER JOIN Worker w ON pw.WorkerId = w.WorkerId
INNER JOIN Task t ON pw.ProjectId = t.ProjectId
	AND pw.WorkerId = t.WorkerId
WHERE p.ProjectId = 'game-goodboy';

-- cross join - creates every possible combo of a joined table
SELECT
	CONCAT(w.FirstName, ' ', w.LastName) WorkerName,
    p.Name ProjectName
FROM Worker w
CROSS JOIN Project p
WHERE w.WorkerId = 1
	AND p.ProjectId NOT LIKE 'game-%';