#USE bdale_cs355sp23;     # Not sure if this was needed here, but is here if required


# ------------------------------ QUERIES ------------------------------ #

# Query 1 - List all services that are offerred but have never been used
SELECT name AS 'Unused Services'
FROM (
	(SELECT name FROM Service s)
	EXCEPT
	(SELECT service FROM Visit_Service vs)
) AS t;


# Query 2 - List owner contact information with their pets names
SELECT
	o.f_name AS 'Owner First Name',
	o.l_name AS 'Owner Last Name',
	p.name AS 'Pet Name',
	opn.ph_number AS 'Phone Number'
FROM Pet p JOIN Pet_Owner po ON p.id = po.pet_id
	JOIN Owner o ON po.owner_id = o.id
	JOIN Owner_PhoneNumber opn ON opn.owner_id = o.id;


# Query 3 - Get all owners without phone numbers
SELECT 
	ID,
	f_name AS 'First Name',
	l_name AS 'Last Name'
FROM Owner o LEFT JOIN Owner_PhoneNumber opn ON o.id = opn.owner_id
WHERE opn.ph_number IS NULL;


# Query 4 - Pets with more than 1 owner
SELECT *
FROM Pet pout JOIN (
	SELECT
		p.id AS 'Pet ID',
		COUNT(*) AS 'Number of Owners'
	FROM Pet p JOIN Pet_Owner po ON p.id = po.pet_id
	GROUP BY p.id
	HAVING COUNT(*) > 1
) AS t ON pout.id = t.`Pet ID`;


# Query 6 - Get an ordered list of the number of visits for each species
SELECT 
	Species,
	COUNT(*) AS 'Number of Visits'
FROM Pet p 
WHERE EXISTS (
	SELECT *
	FROM Visit v
	WHERE p.id = v.pet_id
)
GROUP BY p.species
ORDER BY COUNT(*) DESC;


# Query 7 - Give anyone who makes less than $70,000 a 5% raise
UPDATE Employee 
	SET salary = salary * 1.05
	WHERE salary < 70000.00;
	

# Query 8 - Pets that have not had a single visit
SELECT *
FROM Pet p 
WHERE p.id NOT IN (
	SELECT DISTINCT v.pet_id 
	FROM Visit v 
);


# ------------------------ Examples for views, functions, and procedures ------------------------ #

# Display the vw_OwnersOutstandingPayments view
SELECT * FROM vw_OwnersOutstandingPayments;


# ----- Example use of sp_AddVisitService procedure ----- #
CALL sp_AddVisitService(28, '2020-10-10', 'Allergy testing');

SELECT *
FROM Visit_Service vs 
WHERE vs.pet_id = 28
  AND vs.`date` = '2020-10-10';


# ----- Example use of sp_ApplySalaryChange procedure ----- #
CALL sp_ApplySalaryChange(10, 75000.00);

SELECT
	f_name AS 'First Name',
	l_name AS 'Last Name',
	Salary
FROM Employee e
WHERE e.id = 10; 

# ----- Example use of fn_VisitCostRemaining function ----- #
SELECT fn_VisitCostRemaining(10, '2002-11-30');

# Testing above -- Display the names and costs of all services for the specified (above) visit
SELECT 
	vs.service AS Service, 
	s.cost AS Cost
FROM Visit_Service vs JOIN Service s ON vs.service = s.name
WHERE vs.pet_id = 10
  AND vs.`date` = '2002-11-30';














