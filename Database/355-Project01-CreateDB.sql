# ------------------ Drop all tables if they exist ------------------ #
DROP TABLE IF EXISTS Visit_Service;
DROP TABLE IF EXISTS Pet_Owner;
DROP TABLE IF EXISTS Owner_PhoneNumber;
DROP TABLE IF EXISTS Visit;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Service;
DROP TABLE IF EXISTS Pet;
DROP TABLE IF EXISTS Owner;


# ---------------------------- Create all tables ---------------------------- #
CREATE TABLE Owner (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	dob Date,
	f_name varchar(30),
	l_name varchar(30),
	street varchar(40),
	city varchar(20),
	state char(2),
	zip char(5)
);

CREATE TABLE Pet (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name varchar(35),
	dob DATE,
	species  ENUM ('dog', 'cat', 'bird', 'snake', 'hamster', 'guinea pig', 'fish', 'turtle') NOT NULL,
	breed varchar(20),
	sex ENUM ('male', 'female', 'other')
);

CREATE TABLE Service (
	name varchar(30) PRIMARY KEY,
	cost numeric (8, 2) CHECK (cost >= 0)
);

CREATE TABLE Employee (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	ssn varchar(9) UNIQUE NOT NULL,
	dob DATE,
	f_name varchar(30),
	l_name varchar(30),
	start_date DATE,
	salary numeric (12, 2) CHECK (salary > 0),
	position varchar(20)
);

CREATE TABLE Visit (
	pet_id INT UNSIGNED,
	date DATE,
	paid BOOL DEFAULT false,
	primary_vet INT UNSIGNED,
	PRIMARY KEY (pet_id, date),
	FOREIGN KEY (pet_id) REFERENCES Pet(id)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
	FOREIGN KEY (primary_vet) REFERENCES Employee(id)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
);

CREATE TABLE Owner_PhoneNumber (
	owner_id INT UNSIGNED,
	ph_number VARCHAR(13),
	PRIMARY KEY (owner_id, ph_number),
	FOREIGN KEY (owner_id) REFERENCES Owner(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE Pet_Owner (
	owner_id INT UNSIGNED,
	pet_id INT UNSIGNED,
	PRIMARY KEY (owner_id, pet_id),
	FOREIGN KEY (owner_id) REFERENCES Owner(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (pet_id) REFERENCES Pet(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE Visit_Service (
	pet_id INT UNSIGNED,
	date DATE,
	service VARCHAR(30),
	PRIMARY KEY (pet_id, date, service),
	FOREIGN KEY (pet_id, date) REFERENCES Visit(pet_id, date)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (service) REFERENCES Service(name)
		ON DELETE NO ACTION 
		ON UPDATE CASCADE
);


# ---------------------------- Populate all tables ---------------------------- #
INSERT INTO Owner (dob, f_name, l_name, street, city, state, zip)
VALUES
	('1946-02-14', 'Selena', 'Gomez', '1234 Example St.', 'Los Angeles', 'CA', '94928'),
	('1897-12-24', 'Hailey', 'Beiber', '4321 Other St.', 'Santa Rosa', 'CA', '94928'),
	('2001-01-01', 'Mr.', 'Worldwide', '1 Main St.', 'Miami', 'FL', '33101'),
	('1990-02-02', 'Jonathon', 'Thompson', '32 West St', 'San Francisco', 'CA', '12345'),
	('1984-05-15', 'Charles E', 'Cheese', '3165 Heavens Way', 'Boca Grande', 'FL', '33921'),
	('1973-03-24', 'Tobey', 'Maguire', '2953 Jett Lane', 'Pomona', 'CA', '91766'),
	('2002-09-12', 'Olzoneth', 'Rilore', '2040 Romrog Way', 'Grand Island', 'NE', '68801'),
	('1999-10-31', 'Jack', 'Skellington', '1 Halloween Way', 'Halloween Town', 'ND', '43215'),
	('1986-09-30', 'Barbara', 'Matel', '1959 Malibu Way', 'Malibu', 'CA', '90263'),
	('1997-04-01', 'Winnie', 'The Pooh', '916 Gateway Avenue', 'Bakersfield', 'CA', '93301'),
	('1989-12-01', 'Phillip', 'Fry', '3230 Alexander Avenue', 'San Jose', 'CA', '95131'),
	('1974-11-11', 'Scooby', 'Doo', '4898 Thunder Road', 'Millbrae', 'CA', '94030'),
	('1973-08-08', 'Darkwing', 'Duck', '2111 Carson Street', 'La Mesa', 'CA', '91941'),
	('1990-04-10', 'Lizzie', 'McGuire', '3003 Rosemont Avenue', 'Los Angeles', 'CA', '90017'),
	('1984-06-17', 'Allister', 'Shinigami', '1 Main St.', 'Miami', 'FL', '33101');

INSERT INTO Pet (name, dob, species, breed, sex)
VALUES
	('Barksley', '2012-01-01', 'dog', 'mastiff', 'male'),
	('Captain Waffles', '2017-09-03', 'cat', 'siamese', 'male'),
	('Car Seat French Fry', '2011-11-21', 'cat', 'ragdoll', 'male'),
	('Dad', '2007-07-17', 'hamster', 'BREED', 'male'),
	('Scissor Bill', '2008-10-25', 'dog', 'bulldog', 'other'),
	('Special Agent Dale Cooper FBI', '2008-07-20', 'cat', 'tabby', 'other'),
	('Mr. Ugly', '2019-12-06', 'dog', 'pitbull', 'female'),
	('Lotion', '2016-01-09', 'fish', 'goldfish', 'male'),
	('Lorde', '2013-03-27', 'snake', 'python', 'male'),
	('HOME DEPOT', '2020-07-10', 'guinea pig', 'american', 'male'),
	('Bratwurst', '2002-04-26', 'hamster', 'syrian', 'male'),
	('McRib', '2018-11-11', 'dog', 'german shepard', 'other'),
	('Milk', '2018-09-07', 'cat', 'tabby', 'other'),
	('Old Cat', '2008-05-29', 'cat', 'tabby', 'male'),
	('Sour Cream', '2017-07-07', 'dog', 'husky', 'female'),
	('Cher', '2007-12-14', 'cat', 'tabby', 'male'),
	('Mr Tumnus', '2003-01-21', 'cat', 'short hair', 'female'),
	('Potato', '2008-02-07', 'fish', 'koi', 'other'),
	('Pound Cake', '2009-04-17', 'bird', 'parrot', 'other'),
	('King Gary', '2008-11-29', 'hamster', 'chinese', 'other'),
	('Dorito', '2004-09-12', 'fish', 'koi', 'other'),
	('Aunt Bethany', '2007-10-20', 'snake', 'copperhead', 'male'),
	('Soup', '2014-06-15', 'dog', 'mutt', 'other'),
	('Leondardo DogVinci', '2015-11-12', 'dog', 'border collie', 'female'),
	('Feet', '2002-12-08', 'dog', 'pomeranian', 'other'),
	('Dracula', '2019-07-27', 'cat', 'shorthair', 'other'),
	('Stinky Chunky', '2018-12-01', 'cat', 'tabby', 'female'),
	('Tom', '2020-01-01', 'turtle', 'spotted', 'male');

INSERT INTO Service VALUES
	('Routine checkup', 100.00),
	('Nail Trim', 15.00),
	('Spay/neuter', 180.00),
	('Single Vaccine', 50.00),
	('Physical exam', 50.00),
	('Fecal exam', 35.00),
	('Heartworm test', 55.00),
	('Dental cleaning', 250.00),
	('Allergy testing', 225.00),
	('Geriatric screening', 105.00),
	('Bloodwork', 115.00),
	('X-ray', 165.00),
	('Ultrasound', 400.00),
	('Short hospitalization', 1200.00),
	('Long hospitalization', 2750.00),
	('Wound treatment', 1150.00),
	('Emergency surgery', 3500.00),
	('Oxygen therapy', 2500.00);

INSERT INTO Employee (ssn, dob, f_name, l_name, start_date, salary, position) 
VALUES 
	('663403032', '1984-06-13', 'Ashley', 'Katchadorian', '2016-06-28', 113863.00, 'Vet Assistant'),
	('114806854', '1992-12-07', 'Eren', 'Yaegar', '2007-05-17', 128416.00, 'Veterinarian'),
	('426744790', '1980-07-27', 'Britney', 'Mathews', '2013-10-10', 40133.00, 'Intern'),
	('166181536', '1983-12-06', 'Mackenzie', 'Zales', '2002-07-04', 176559.00, 'Veterinarian'),
	('558712500', '1987-03-20', 'Trisha', 'Cappalletti', '2016-04-23', 98758.00, 'Vet Assistant'),
	('933687702', '1965-05-01', 'Clifford', 'Walsh', '1993-04-02', 71903.00, 'Vet Tech'),
	('775191066', '1973-08-26', 'Patsy', 'Hawkins', '2013-03-23', 64633.00, 'Janitor'),
	('851865416', '1975-09-25', 'Eulau', 'Choi', '1988-10-09', 65211.00, 'Receptionist'),
	('261385255', '1963-05-16', 'Ernest', 'Huang', '1997-07-14', 75268.00, 'Vet Assistant'),
	('796972898', '1971-11-14', 'Elisa', 'Capps', '1995-02-01', 63000.00, 'Receptionist');

INSERT INTO Visit VALUES
	(10, '2002-11-30', FALSE,  2),
	(19, '1990-05-10', TRUE,  4),
	(15, '2015-08-10', FALSE, 2),
	(5,  '1994-05-06', TRUE,  4),
	(4,  '2018-08-27', FALSE, 2),
	(3,  '2018-01-15', FALSE, 2),
	(17, '2016-01-19', TRUE,  2),
	(6,  '1989-02-28', TRUE,  2),
	(8,  '1998-08-29', FALSE, 2),
	(18, '2005-03-07', FALSE, 2),
	(20, '2010-08-24', FALSE, 2),
	(20, '2009-09-23', TRUE,  2),
	(27, '2002-12-27', TRUE,  2),
	(12, '2014-01-08', FALSE, 2),
	(6,  '2008-05-12', FALSE, 4),
	(23, '1997-08-04', FALSE, 4),
	(22, '2019-10-01', TRUE,  2),
	(22, '1997-04-27', TRUE,  4),
	(6,  '1990-05-02', FALSE, 4),
	(26, '2000-12-15', TRUE,  4),
	(20, '1991-09-03', FALSE, 4),
	(1,  '2000-12-16', FALSE, 4),
	(16, '1988-04-22', TRUE,  2),
	(13, '1986-08-22', TRUE,  4),
	(9,  '2012-01-19', FALSE, 4),
	(9, '2012-01-20', FALSE, NULL),
	(28, '2020-10-10', FALSE, NULL);
	
INSERT INTO Owner_PhoneNumber VALUES
	(11, '424-665-7388'),
	(7,  '765-948-1670'),
	(13, '843-725-8977'),
	(14, '530-347-5007'),
	(2,  '918-385-8325'),
	(14, '971-537-4588'),
	(6,  '417-623-8127'),
	(1,  '207-924-3726'),
	(7,  '585-644-6193'),
	(8,  '209-476-3130'),
	(3,  '209-594-2906'),
	(7,  '209-838-8587'),
	(3,  '209-799-4298'),
	(10, '209-265-7087'),
	(8,  '209-933-3435'),
	(11, '209-695-7156'),
	(3,  '209-663-8222'),
	(14, '209-942-1040'),
	(1,  '209-988-1027'),
	(8,  '209-825-8254'),
	(14, '209-239-6584'),
	(4,  '209-873-1643'),
	(5,  '209-654-7912'),
	(4,  '209-258-1543'),
	(11, '209-674-8765'),
	(4,  '209-839-9649'),
	(5,  '209-874-3600'),
	(2,  '209-853-6329'),
	(9,  '209-948-2245'),
	(14, '209-563-4150'),
	(10, '209-659-5897'),
	(11, '209-756-2675'),
	(8,  '209-679-6425'),
	(1,  '310-568-1308'),
	(14, '310-489-2015'),
	(10, '310-765-1917'),
	(2,  '310-432-8940'),
	(6,  '310-627-6664'),
	(1,  '310-897-1484'),
	(7,  '310-926-6780'),
	(12, '310-376-6925'),
	(12, '310-665-5830'),
	(12, '310-338-8778'),
	(6,  '310-547-6301'),
	(12, '310-379-6565'),
	(7,  '310-555-9467'),
	(10, '310-496-7239'),
	(11, '310-884-7242'),
	(3,  '918-282-6842'),
	(1,  '949-763-7785');

INSERT INTO Pet_Owner VALUES
	(1,  1),
	(5,  1),
	(2,  2),
	(3,  3),
	(4,  4),
	(5,  5),
	(6,  6),
	(7,  6),
	(6,  7),
	(7,  7),
	(8,  8),
	(9,  9),
	(14, 9),
	(10, 10),
	(11, 11),
	(12, 12),
	(13, 13),
	(14, 14),
	(1,  15),
	(2,  16),
	(3,  17),
	(4,  18),
	(5,  19),
	(6,  20),
	(7,  21),
	(8,  22),
	(9,  23),
	(10, 24),
	(11, 25),
	(12, 26),
	(9,  27),
	(15, 28);
	
INSERT INTO Visit_Service VALUES
	(10, '2002-11-30', 'Routine checkup'),
	(10, '2002-11-30', 'Nail Trim'),
	(19, '1990-05-10', 'Routine checkup'),
	(15, '2015-08-10', 'Spay/neuter'),
	(15, '2015-08-10', 'Physical exam'),
	(5,  '1994-05-06', 'Physical exam'),
	(5,  '1994-05-06', 'Routine checkup'),
	(5,  '1994-05-06', 'Fecal exam'),
	(4,  '2018-08-27', 'Heartworm test'),
	(4,  '2018-08-27', 'X-ray'),
	(3,  '2018-01-15', 'Routine checkup'),
	(17, '2016-01-19', 'Geriatric screening'),
	(6,  '1989-02-28', 'Ultrasound'),
	(8,  '1998-08-29', 'Oxygen therapy'),
	(18, '2005-03-07', 'Spay/neuter'),
	(20, '2010-08-24', 'Emergency surgery'),
	(20, '2009-09-23', 'Wound treatment'),
	(27, '2002-12-27', 'Routine checkup'),
	(12, '2014-01-08', 'Dental cleaning'),
	(6,  '2008-05-12', 'Long hospitalization'),
	(23, '1997-08-04', 'Allergy testing'),
	(22, '2019-10-01', 'Spay/neuter'),
	(22, '1997-04-27', 'Physical exam'),
	(6,  '1990-05-02', 'Routine checkup'),
	(26, '2000-12-15', 'Short hospitalization'),
	(20, '1991-09-03', 'Single Vaccine'),
	(1,  '2000-12-16', 'Dental cleaning'),
	(16, '1988-04-22', 'Allergy testing'),
	(13, '1986-08-22', 'Routine checkup'),
	(9,  '2012-01-19', 'Physical exam'),
	(28, '2020-10-10', 'Physical exam');



# ---------------------- Create Views, Functions, and Procedures ---------------------- #

# --------------- VIEW -- Get all owners with outstanding payments --------------- #
CREATE OR REPLACE VIEW vw_OwnersOutstandingPayments AS 
(
	SELECT
		owner_id AS 'Owner ID',
		pet_id AS 'Pet ID',
		f_name AS 'Owner First Name',
		l_name AS 'Owner Last Name'
	FROM Pet_Owner po JOIN Owner o ON po.owner_id = o.id
	WHERE EXISTS (
		SELECT *
		FROM Visit v 
		WHERE v.pet_id = po.pet_id AND v.paid = FALSE
	)
)


# --------------- PROCEDURE -- Adds a service to a pets visit --------------- #
DELIMITER $$

CREATE OR REPLACE PROCEDURE sp_AddVisitService
(
	IN petID_in INT UNSIGNED,
	IN date_in DATE,
	IN serviceName_in varchar(30)
)
BEGIN 
	# Declare variables
	DECLARE CUSTOM_ERROR CONDITION FOR SQLSTATE '46000';
	DECLARE petExists BOOL DEFAULT FALSE;
	DECLARE visitExists BOOL DEFAULT FALSE;
	DECLARE visitHasNewService BOOL DEFAULT FALSE;

	# Make sure that the pet exists
	SET petExists = ( EXISTS (
		SELECT *
		FROM Pet p
		WHERE p.id = petID_in )
	);
	
	IF NOT petExists THEN
		SIGNAL CUSTOM_ERROR
			SET MESSAGE_TEXT = 'No pet found with that petID!';
	END IF;

	# Make sure that the visit exists
	SET visitExists = ( EXISTS (
		SELECT *
		FROM Visit v
		WHERE v.pet_id = petID_in AND v.`date` = date_in )
	);
	
	IF NOT visitExists THEN
		SIGNAL CUSTOM_ERROR
			SET MESSAGE_TEXT = 'This pet does not have an existing visit on this date!';
	END IF;

	# Make sure that this visit does not already have this service
	SET visitHasNewService = ( EXISTS (
		SELECT *
		FROM Visit_Service vs 
		WHERE vs.pet_id = petID_in
		  AND vs.`date` = date_in
		  AND vs.service = serviceName_in
		)
	);
	
	IF visitHasNewService THEN
		SIGNAL CUSTOM_ERROR
			SET MESSAGE_TEXT = 'Cannot add an duplicate service to a visit!';
	END IF;

	# Add the service to the visit
	INSERT INTO Visit_Service VALUES (petID_in, date_in, serviceName_in);
	
END $$

DELIMITER ;


# --------------- Procedure -- Give an employee a raise/decrease --------------- #
DELIMITER $$

CREATE OR REPLACE PROCEDURE sp_ApplySalaryChange
(
	IN employeeID_in INT UNSIGNED,
	IN newSalary numeric (12, 2)
)
BEGIN 
	# Declare variables
	DECLARE CUSTOM_ERROR CONDITION FOR SQLSTATE '45000';
	DECLARE employeeExists BOOL DEFAULT FALSE;
	
	# Make sure the employee EXISTS 
	SET employeeExists = ( EXISTS (
		SELECT *
		FROM Employee e 
		WHERE e.id = employeeID_in )
	);

	IF NOT employeeExists THEN
		SIGNAL CUSTOM_ERROR
			SET MESSAGE_TEXT = 'No employee exists with this ID!';
	END IF;
	
	# Make sure salary is greater than 0
	IF newSalary <= 0 THEN
		SIGNAL CUSTOM_ERROR
			SET MESSAGE_TEXT = 'The new salary is invalid -- New Salary must be > 0!';
	END IF;
	
	# Apply the salary change
	UPDATE Employee
		SET salary = newSalary
		WHERE id = employeeID_in;
	
END $$

DELIMITER ;


# --------------- Function -- Get the remaining cost of a visit --------------- #
DELIMITER $$ 

CREATE OR REPLACE FUNCTION fn_VisitCostRemaining
(
	petID_in INT UNSIGNED,
	date_in Date
)
RETURNS NUMERIC(8, 2)
BEGIN 
	# Declare variables
	DECLARE CUSTOM_ERROR CONDITION FOR SQLSTATE '45000';
	DECLARE petExists BOOL DEFAULT FALSE;
	DECLARE petVisitExists BOOL DEFAULT FALSE;
	DECLARE alreadyPaid BOOL DEFAULT FALSE;
	DECLARE costRem NUMERIC(8, 2);
	
	# Make sure that the pet exists
	SET petExists = ( EXISTS (
		SELECT *
		FROM Pet p
		WHERE p.id = petID_in )
	);

	IF NOT petExists THEN
		SIGNAL CUSTOM_ERROR
			SET MESSAGE_TEXT = 'No pet found with that petID!';
	END IF;

	# Make sure that the pet had a visit on that date
	SET petVisitExists = ( EXISTS (
		SELECT *
		FROM Visit v 
		WHERE v.pet_id = pet_id AND v.`date` = date_in )
	);
	
	IF NOT petVisitExists THEN
		SIGNAL CUSTOM_ERROR
			SET MESSAGE_TEXT = 'Pet with this ID does not have a visit for that date!';
	END IF;

 	# Check that the visit has not already been paid for
	SET alreadyPaid = ( EXISTS (
		SELECT *
		FROM Visit v 
		WHERE v.pet_id = petID_in
		  AND v.`date` = date_in
		  AND v.paid = TRUE ) 
	);

	IF alreadyPaid THEN
		SIGNAL CUSTOM_ERROR
			SET MESSAGE_TEXT = 'This visit has already been paid for!';
	END IF;

	# Calculate the cost of the visit
	SELECT SUM(s.cost)
	INTO costRem
	FROM Visit_Service vs JOIN Service s ON vs.service = s.name
	WHERE vs.pet_id = petID_in AND vs.`date` = date_in;

	RETURN costRem;
	
END; $$

DELIMITER ;



