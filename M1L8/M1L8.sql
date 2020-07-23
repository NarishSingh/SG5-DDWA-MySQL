-- //only a few columns
USE ConsumerComplaints;

SELECT DateReceived, Product, Company, State
FROM Complaint;

-- //all cols
USE ConsumerComplaints;

SELECT *
FROM complaint;

-- //filter by state
use ConsumerComplaints;

select DateReceived, Product, Issue, Company
from Complaint
where State = 'LA';

-- //filter with conditional expressions, use parentheses for precedence
use ConsumerComplaints;

select *
from Complaint
where State = 'LA'
and (Product = 'Mortage' or Product = 'Debt collection');

-- //filtering numbers
use ConsumerComplaints;

select Product, Issue, Company, ResponseToConsumer
from Complaint
where ConsumerDisputed = 1
and ConsumerConsent = 1
and Product not in ('Mortage', 'Debt Collection');

-- //filter by date  
use ConsumerComplaints;

select *
from Complaint
where DateReceived > '2019-01-01';

-- //match text
use ConsumerComplaints;

select *
from Complaint 
where Company like 'Z%';

-- //null
USE ConsumerComplaints;

SELECT *
FROM Complaint
WHERE SubProduct IS NULL;

SELECT * 
FROM Complaint 
WHERE SubProduct IS NOT NULL;

SELECT *
FROM Complaint
WHERE ComplaintId > 15000 OR ComplaintId IS NULL;

SELECT *
FROM Complaint
WHERE SubIssue = 'Account status'
OR SubIssue IS NULL;

-- All Complaints with a value for ComplaintNarrative. 
-- Exclude null values.
SELECT *
FROM Complaint
WHERE ComplaintNarrative IS NOT NULL; 