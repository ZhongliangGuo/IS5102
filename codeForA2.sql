-- this section is to create the database which corresponds to the database schema from Task 1
.mode colum
.header ON
-- enforce foreign key constraints and create tables
PRAGMA foreign_keys = TRUE;

CREATE TABLE Staff (
	staff_id CHAR (9),
	first_name VARCHAR (10) NOT NULL,
	middle_name VARCHAR (10),
	family_name VARCHAR (10) NOT NULL,
	email VARCHAR (50),
	street VARCHAR (50),
	city VARCHAR (20),
	postcode VARCHAR (10),
	PRIMARY KEY (staff_id)
);

CREATE TABLE Phone (
	staff_id CHAR (9),
	phone_number CHAR (10),
	type VARCHAR (10),
	PRIMARY KEY (staff_id, phone_number),
	FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Manager (
	staff_id CHAR (9),
	annual_salary NUMERIC (8, 2) NOT NULL,
	PRIMARY KEY (staff_id),
	FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Driver (
	staff_id CHAR (9),
	hourly_salary DOUBLE NOT NULL,
	PRIMARY KEY (staff_id),
	FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Station (
	station_name VARCHAR (50),
	town VARCHAR (20) NOT NULL,
	manager_id CHAR (9),
	PRIMARY KEY (station_name),
	FOREIGN KEY (manager_id) REFERENCES Manager(staff_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Service (
	service_number VARCHAR(3),
	origin_station_name VARCHAR (50),
	destination_station_name VARCHAR (50),
	PRIMARY KEY (service_number),
	FOREIGN KEY (origin_station_name) REFERENCES Station(station_name) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (destination_station_name) REFERENCES Station(station_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ServiceTime (
	service_number VARCHAR(3),
	start_time TIME,
	PRIMARY KEY (service_number, start_time),
	FOREIGN KEY (service_number) REFERENCES Service(service_number) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Stop (
	stop_name VARCHAR(50),
	PRIMARY KEY (stop_name)
);

CREATE TABLE TimeOfServiceOnStop (
	service_number VARCHAR(3),
	start_time TIME,
	stop_name VARCHAR(50),
	arrival_time TIME NOT NULL,
	fare_from_origin DOUBLE NOT NULL,
	PRIMARY KEY (service_number, start_time, stop_name),
	FOREIGN KEY (service_number, start_time) REFERENCES ServiceTime(service_number, start_time) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (stop_name) REFERENCES Stop(stop_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Drives (
	staff_id CHAR (9),
	service_number VARCHAR(3),
	hours_driven INT NOT NULL,
	PRIMARY KEY (staff_id, service_number),
	FOREIGN KEY (staff_id) REFERENCES Driver(staff_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (service_number) REFERENCES Service(service_number) ON DELETE CASCADE ON UPDATE CASCADE
);

-- insert tuples for table Staff
INSERT INTO
	Staff
VALUES
	(
		'210901001',
		'Andy',
		'A',
		'Torpy',
		'at1@bus.co.uk',
		'North Haugh',
		'Fife',
		'KY16 9XW'
	);

INSERT INTO
	Staff
VALUES
	(
		'210901002',
		'Ben',
		'B',
		'Young',
		'by1@bus.co.uk',
		'Buchanan Gardens',
		'Fife',
		'KY16 9LY'
	);

INSERT INTO
	Staff
VALUES
	(
		'210913001',
		'Cindy',
		NULL,
		'Russell',
		'cr1@bus.co.uk',
		'South Bridge',
		'Edinburgh',
		'EH8 9YL'
	);

INSERT INTO
	Staff
VALUES
	(
		'210913002',
		'Kiki',
		NULL,
		'Chapel',
		'kc1@bus.co.uk',
		'Fountainbridge',
		'Edinburgh',
		'EH3 9QA'
	);

INSERT INTO
	Staff
VALUES
	(
		'211002001',
		'Tammy',
		NULL,
		'Lee',
		'tl1@bus.co.uk',
		'Annfield Rd',
		'Inverness',
		'IV2 3HX'
	);

INSERT INTO
	Staff
VALUES
	(
		'211002002',
		'Mendoza',
		'K',
		'Henderson',
		'mh1@bus.co.uk',
		'Howard St',
		'Glasgow',
		'G1 4EE'
	);

INSERT INTO
	Staff
VALUES
	(
		'211002003',
		'Ammy',
		NULL,
		'Taylor',
		'at2@bus.co.uk',
		'Maizey Rd',
		'Swindon',
		'SN25 2RP'
	);

INSERT INTO
	Staff
VALUES
	(
		'211002004',
		'Edvin',
		NULL,
		'Brown',
		'eb1@bus.co.uk',
		'Pall Mall E',
		'London',
		'SW1Y 5AU'
	);

INSERT INTO
	Staff
VALUES
	(
		'211002005',
		'Tessa',
		NULL,
		'Timber',
		'tt1@bus.co.uk',
		'Wapping Ln',
		'London',
		'E1W 2RL'
	);

INSERT INTO
	Staff
VALUES
	(
		'210003001',
		'Judy',
		'Q',
		'Kernel',
		'jk1@bus.co.uk',
		'Redriff Rd',
		'London',
		'SE16 7LL'
	);

-- insert tuples for table Phone
INSERT INTO
	Phone
VALUES
	('210901001', '7579012049', 'family');

INSERT INTO
	Phone
VALUES
	('210901001', '7578112323', 'work');

INSERT INTO
	Phone
VALUES
	('210901002', '7655434335', NULL);

INSERT INTO
	Phone
VALUES
	('210913001', '7654565370', NULL);

INSERT INTO
	Phone
VALUES
	('210913002', '7334537312', NULL);

INSERT INTO
	Phone
VALUES
	('211002001', '7124645543', NULL);

INSERT INTO
	Phone
VALUES
	('211002002', '7154546743', NULL);

INSERT INTO
	Phone
VALUES
	('211002003', '7176844454', NULL);

INSERT INTO
	Phone
VALUES
	('211002004', '7756558713', NULL);

INSERT INTO
	Phone
VALUES
	('211002005', '7543761173', NULL);

INSERT INTO
	Phone
VALUES
	('210003001', '7175788813', NULL);

-- insert tuples for table Manager
INSERT INTO
	Manager
VALUES
	('210901001', 34500.50);

INSERT INTO
	Manager
VALUES
	('210901002', 76550);

INSERT INTO
	Manager
VALUES
	('210913001', 41230);

INSERT INTO
	Manager
VALUES
	('210913002', 35000);

INSERT INTO
	Manager
VALUES
	('211002001', 35050);

-- insert tuples for table Driver
INSERT INTO
	Driver
VALUES
	('211002002', 40);

INSERT INTO
	Driver
VALUES
	('211002003', 50);

INSERT INTO
	Driver
VALUES
	('211002004', 45);

INSERT INTO
	Driver
VALUES
	('211002005', 70);

INSERT INTO
	Driver
VALUES
	('210003001', 60);

-- insert tuples for table Station
INSERT INTO
	Station
VALUES
	('St Andrews Bus Station', 'St Andrews', '210901001');

INSERT INTO
	Station
VALUES
	('Bogward', 'St Andrews', '210901002');

INSERT INTO
	Station
VALUES
	('Seagate', 'Dundee', '210913001');

INSERT INTO
	Station
VALUES
	('Edinburgh Bus Station', 'Edinburgh', '210913002');

INSERT INTO
	Station
VALUES
	('Union Square', 'Aberdeen', '211002001');

-- insert tuples for table Service
INSERT INTO
	Service
VALUES
	('99A', 'St Andrews Bus Station', 'Bogward');

INSERT INTO
	Service
VALUES
	('92B', 'St Andrews Bus Station', 'Seagate');

INSERT INTO
	Service
VALUES
	('62', 'St Andrews Bus Station', 'Edinburgh Bus Station');

INSERT INTO
	Service
VALUES
	('97A', 'Union Square', 'St Andrews Bus Station');

INSERT INTO
	Service
VALUES
	('32R', 'Union Square', 'Seagate');

-- insert tuples for table ServiceTime
INSERT INTO
	ServiceTime
VALUES
	('99A', '09:00:00');

INSERT INTO
	ServiceTime
VALUES
	('99A', '15:00:00');

INSERT INTO
	ServiceTime
VALUES
	('99A', '21:00:00');

INSERT INTO
	ServiceTime
VALUES
	('92B', '09:30:00');

INSERT INTO
	ServiceTime
VALUES
	('92B', '21:30:00');

INSERT INTO
	ServiceTime
VALUES
	('62', '10:30:00');

INSERT INTO
	ServiceTime
VALUES
	('62', '22:30:00');

INSERT INTO
	ServiceTime
VALUES
	('97A', '11:00:00');

INSERT INTO
	ServiceTime
VALUES
	('97A', '23:00:00');

INSERT INTO
	ServiceTime
VALUES
	('32R', '09:15:00');

INSERT INTO
	ServiceTime
VALUES
	('32R', '16:00:00');

-- insert tuples for table Stop
INSERT INTO
	Stop
VALUES
	('Church Square');

INSERT INTO
	Stop
VALUES
	('South Street');

INSERT INTO
	Stop
VALUES
	('James Robb');

INSERT INTO
	Stop
VALUES
	('Horseleys Park');

INSERT INTO
	Stop
VALUES
	('Queens Hotel');

INSERT INTO
	Stop
VALUES
	('Airlie Place');

INSERT INTO
	Stop
VALUES
	('Mcvicars Lane');

INSERT INTO
	Stop
VALUES
	('Patons Lane');

-- insert tuples for table TimeOfServiceOnStop
INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'99A',
		'09:00:00',
		'Church Square',
		'09:30:00',
		1.10
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'99A',
		'09:00:00',
		'South Street',
		'10:00:00',
		1.30
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'99A',
		'09:00:00',
		'James Robb',
		'11:00:00',
		1.50
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'99A',
		'15:00:00',
		'Church Square',
		'15:30:00',
		1.10
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'99A',
		'15:00:00',
		'South Street',
		'16:00:00',
		1.30
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'99A',
		'15:00:00',
		'James Robb',
		'17:00:00',
		1.50
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'99A',
		'21:00:00',
		'Church Square',
		'21:30:00',
		1.10
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'99A',
		'21:00:00',
		'South Street',
		'22:00:00',
		1.30
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'99A',
		'21:00:00',
		'James Robb',
		'23:00:00',
		1.50
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'92B',
		'09:30:00',
		'South Street',
		'09:50:00',
		2.30
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'92B',
		'09:30:00',
		'Horseleys Park',
		'10:30:00',
		2.80
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'92B',
		'21:30:00',
		'South Street',
		'21:50:00',
		2.30
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'92B',
		'21:30:00',
		'Horseleys Park',
		'22:30:00',
		2.80
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'62',
		'10:30:00',
		'Queens Hotel',
		'10:50:00',
		1.70
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'62',
		'10:30:00',
		'Airlie Place',
		'11:30:00',
		1.90
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'62',
		'22:30:00',
		'Queens Hotel',
		'22:50:00',
		1.70
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'62',
		'22:30:00',
		'Airlie Place',
		'23:30:00',
		1.90
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'97A',
		'11:00:00',
		'South Street',
		'11:25:00',
		2.70
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'97A',
		'11:00:00',
		'Mcvicars Lane',
		'12:00:00',
		3.00
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'97A',
		'23:00:00',
		'South Street',
		'23:25:00',
		2.70
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'97A',
		'23:00:00',
		'Mcvicars Lane',
		'23:59:00',
		3.00
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'32R',
		'09:15:00',
		'South Street',
		'10:00:00',
		3.70
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'32R',
		'09:15:00',
		'Patons Lane',
		'10:15:00',
		4.00
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'32R',
		'16:00:00',
		'South Street',
		'16:45:00',
		3.70
	);

INSERT INTO
	TimeOfServiceOnStop
VALUES
	(
		'32R',
		'16:00:00',
		'Patons Lane',
		'17:00:00',
		4.00
	);

-- insert tuples for table Drives
INSERT INTO
	Drives
VALUES
	('211002002', '99A', 6);

INSERT INTO
	Drives
VALUES
	('211002003', '92B', 2);

INSERT INTO
	Drives
VALUES
	('211002004', '62', 2);

INSERT INTO
	Drives
VALUES
	('211002002', '97A', 2);

INSERT INTO
	Drives
VALUES
	('211002005', '32R', 2);

-- Task 3
-- query
-- 1. List all services which have Seagate Bus Station in Dundee as their destination
SELECT
	service_number
FROM
	Service
WHERE
	destination_station_name = 'Seagate';

-- 2.  List the names of all drivers of services which have St Andrews Bus Station in St Andrews as their origin or destination,
-- in decreasing order of total hours driven
SELECT
	a.first_name,
	a.middle_name,
	a.family_name
FROM
	Staff a
	LEFT JOIN Drives d ON d.staff_id = a.staff_id
	LEFT JOIN Service s ON s.service_number = d.service_number
WHERE
	origin_station_name = 'St Andrews Bus Station'
	or destination_station_name = 'St Andrews Bus Station'
GROUP BY
	a.first_name,
	a.middle_name,
	a.family_name
ORDER BY
	SUM(d.hours_driven) DESC;

-- 3. List the manager of the most connected station, 
--    measured by the number of services which have that station as their origin or destination.
SELECT
	s2.first_name,
	s2.middle_name,
	s2.family_name
FROM
	(
		SELECT
			origin_station_name station_name,
			COUNT(origin_station_name) AS connected_num
		FROM
			Service
		GROUP BY
			origin_station_name
		UNION
		all
		SELECT
			destination_station_name station_name,
			COUNT(destination_station_name) AS connected_num
		FROM
			Service
		GROUP BY
			origin_station_name
	) a
	LEFT JOIN Station s ON s.station_name = a.station_name
	LEFT JOIN Staff s2 ON s2.staff_id = s.manager_id
GROUP BY
	s2.first_name,
	s2.middle_name,
	s2.family_name
ORDER BY
	sum(a.connected_num) DESC
LIMIT
	1;

-- 4. For the bus stop ”South Street, St Andrews” list in the chronological order arrival times at this
-- stop, origins, destinations, and service numbers of all bus services passing this stop between 8 am
-- and 6 pm.
SELECT
	t.arrival_time,
	s.origin_station_name,
	s.destination_station_name,
	t.service_number
FROM
	TimeOfServiceOnStop t
	LEFT JOIN Service s ON s.service_number = t.service_number
WHERE
	t.arrival_time BETWEEN '08:00:00'
	AND '18:00:00'
	AND t.stop_name = 'South Street'
ORDER BY
	t.arrival_time;

-- 5. List the contact details of all drivers of services which have St Andrews Bus Station in St Andrews as their origin or destination.
SELECT
	DISTINCT s.staff_id,
	s.first_name,
	s.middle_name,
	s.family_name,
	s.email,
	s.type,
	s.phone_number,
	s.street,
	s.city,
	s.postcode
FROM
	(
		Driver
		LEFT JOIN Staff ON Driver.staff_id = Staff.staff_id
		LEFT JOIN Phone ON Driver.staff_id = Phone.staff_id
	) s,
	(
		Drives
		LEFT JOIN Service ON Drives.service_number = Service.service_number
	) d
WHERE
	s.staff_id = d.staff_id
	and (
		d.origin_station_name = 'St Andrews Bus Station'
		or destination_station_name = 'St Andrews Bus Station'
	);

-- 6. List the name, station and annual salary of managers, in decreasing order of annual salary
SELECT
	first_name,
	middle_name,
	family_name,
	station_name,
	annual_salary
FROM
	Manager
	NATURAL JOIN Staff
	LEFT JOIN Station ON Manager.staff_id = Station.manager_id
ORDER BY
	annual_salary DESC;

-- 7. List the name, daily salary of drivers, in decreasing order of daily salary
SELECT
	first_name,
	middle_name,
	family_name,
	(sum(d.hours_driven) * d.hourly_salary) AS daily_salary
FROM
	(
		Driver
		LEFT JOIN Staff ON Driver.staff_id = Staff.staff_id
		LEFT JOIN Drives ON Drives.staff_id = Driver.staff_id
		LEFT JOIN Service ON Service.service_number = Drives.service_number
	) d
GROUP BY
	first_name,
	middle_name,
	family_name
ORDER BY
	daily_salary DESC;

-- view
-- 1. Create a view which contains the station name, the service number of buses which this station is origin or destination, full name and contact details of its manager.
CREATE VIEW station_manager_service AS
SELECT
	station_name,
	service_numbers,
	manager_name,
	email,
	group_concat(type_number) AS phone_numbers,
	street,
	city,
	postcode
FROM
	(
		SELECT
			*,
			group_concat(service_number) AS service_numbers,
			first_name || ' ' || ifnull(middle_name, '') || ' ' || family_name AS manager_name,
			ifnull(type, 'general') || ':' || phone_number AS type_number
		FROM
			Station
			LEFT JOIN Manager ON Station.manager_id = Manager.staff_id
			LEFT JOIN Staff ON Station.manager_id = Staff.staff_id
			LEFT JOIN Phone ON Staff.staff_id = Phone.staff_id
			LEFT JOIN Service ON Station.station_name = Service.origin_station_name
			or Station.station_name = Service.destination_station_name
		GROUP BY
			Phone.phone_number
	)
GROUP BY
	station_name;

-- 2. Create a view which contains the name of driver, stops this driver passed.
CREATE VIEW stop_service_time AS
SELECT
	first_name || ' ' || ifnull(middle_name, '') || ' ' || family_name AS driver_name,
	group_concat(stop_name) AS stops
FROM
(
		SELECT DISTINCT
			first_name,
			middle_name,
			family_name,
			stop_name
		FROM
			Driver
			NATURAL JOIN Drives
			NATURAL JOIN TimeOfServiceOnStop
			NATURAL JOIN Staff
	)
GROUP BY
	driver_name;
