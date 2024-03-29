SELECT * FROM MOCK_DATA; --Select All from table mock_data

SELECT DISTINCT country FROM MOCK_DATA; --Select unique values 

SELECT country FROM MOCK_DATA ORDER BY country ASC; --Sort by Column ASC ascending / DESC descending

SELECT country, COUNT(*) FROM MOCK_DATA GROUP BY country; --Select

SELECT gender, COUNT(*) FROM MOCK_DATA GROUP BY gender; --Groups columns

SELECT country, COUNT(*) FROM MOCK_DATA GROUP BY country ORDER BY country ASC LIMIT 5 OFFSET 1; -- Selects top 5 leaving 1st record

SELECT country, COUNT(*) FROM MOCK_DATA GROUP BY country HAVING COUNT(*)>10 ORDER BY country;

SELECT * FROM car_data;

SELECT MIN(car_price) FROM car_data;

SELECT MAX(car_price) FROM car_data;

SELECT AVG(car_price) FROM car_data;

SELECT * FROM car_data WHERE car_make='Ford';

SELECT car_make,AVG(car_price) FROM car_data GROUP BY car_make;

SELECT car_make,car_model,ROUND(MIN(car_price),2) AS Average FROM car_data WHERE car_make='Ford' GROUP BY car_make,car_model ;

SELECT car_make, SUM(car_price) AS Sum_price FROM car_data GROUP BY car_make; -- AS alias names/renames column

SELECT car_make,COUNT(car_make) FROM car_data GROUP BY car_make;

INSERT INTO MOCK_DATA (id,first_name,last_name,gender,dob,country) VALUES(1001,'munavar','hussain','Male','1998-01-04','India');

SELECT *,COALESCE(email,'No Email') AS email FROM MOCK_DATA; --Coalesce if 1st parameter is NULL, replaces those records with 2nd parameter

SELECT COALESCE(10/NULLIF(0,0),0) AS DivideByZero; -- NULLIF Returns NULL if both arguments are same 

SELECT NOW(); -- Current timestamp

SELECT NOW()::DATE AS TimesNow;

SELECT NOW()::TIME AS TimesNow;

SELECT NOW()::DAY AS TimesNow; --ERROR

SELECT NOW() - INTERVAL '10 YEARS'; -- Subtract 10 years from present

SELECT (NOW() + INTERVAL '10 DAYS')::DATE;

SELECT EXTRACT(DAY FROM NOW());

SELECT EXTRACT(DOW FROM NOW()); -- Extract day of week from current time

SELECT EXTRACT(HOUR FROM NOW()::TIME);

SELECT EXTRACT(HOUR FROM NOW()::DATE); --ERROR

SELECT EXTRACT(SECOND FROM NOW()::TIME);

SELECT AGE(NOW(),'1998-01-04'); -- Calc age (from , to)

-- Primary key is a unique constraint i.e it won't let us create duplicate id
INSERT INTO MOCK_DATA (id,first_name,last_name,gender,dob,country) VALUES(1001,'munavar','hussain','Male','1998-01-04','India');
-- Trying to add id which is already in our table

ALTER TABLE MOCK_DATA DROP CONSTRAINT primary_key_pkey; --let's drop the primary key constraint

INSERT INTO MOCK_DATA (id,first_name,last_name,gender,dob,country) VALUES(1001,'munavar','hussain','Male','1998-01-04','India');
--Duplicate id can be inserted
SELECT * FROM MOCK_DATA WHERE id=1001; --Check

ALTER TABLE MOCK_DATA ADD CONSTRAINT primary_key_pkey PRIMARY KEY (id); -- Trying to Add primary key constraint

DELETE FROM MOCK_DATA; -- DANGER!!!! Deletes all records

DELETE FROM MOCK_DATA WHERE id=1001;  -- Delete all duplicate

SELECT * FROM MOCK_DATA WHERE id=1001; --Check
--Add again 
INSERT INTO MOCK_DATA (id,first_name,last_name,gender,dob,country) VALUES(1001,'munavar','hussain','Male','1998-01-04','India');

ALTER TABLE MOCK_DATA ADD CONSTRAINT primary_key_pkey PRIMARY KEY (id); -- Trying to Add primary key constraint

ALTER TABLE MOCK_DATA ADD CONSTRAINT unique_email UNIQUE (email); -- Add unique constraint
-- Try to add new id with same email
INSERT INTO MOCK_DATA (id,first_name,last_name,gender,dob,country,email) VALUES(1002,'munavar','hussain','Male','1998-01-04','India','daxup0@pcworld.com');

ALTER TABLE MOCK_DATA DROP CONSTRAINT unique_email; -- Delete unique constraint

UPDATE MOCK_DATA SET email = 'armunavarhussain.be@gmail.com' WHERE id = '1001'; -- Update record use comma for multiple column values. Remember to include where clause.
--Error below
INSERT INTO MOCK_DATA (id,first_name,last_name,gender,dob,country) VALUES(1001,'munavar','hussain','Male','1998-01-04','India');

INSERT INTO MOCK_DATA (id,first_name,last_name,gender,dob,country)
VALUES(1001,'munavar','hussain','Male','1998-01-04','India')
ON CONFLICT (id) DO NOTHING; -- No Error also no changes on db.
--Conflict can only be applied on constraints such as PRIMARY KEY or UNIQUE

--For what so ever if we need to update the latest value,
INSERT INTO MOCK_DATA (id,first_name,last_name,gender,dob,country,email)
VALUES(1001,'munavar','hussain','Male','1998-01-04','India','armh@gmail.com')
ON CONFLICT (id) DO UPDATE SET email=EXCLUDED.email; 

-- create new tables
CREATE TABLE c_table(
c_id BIGSERIAL NOT NULL PRIMARY KEY,
car_make varchar(10) NOT NULL,
car_model varchar(10) NOT NULL
);
CREATE TABLE p_table( -- person table
p_id BIGSERIAL NOT NULL PRIMARY KEY,
fname varchar(10) NOT NULL,
lname varchar(10) NOT NULL,
country varchar(20) NOT NULL,
car_id BIGINT REFERENCES c_table (c_id), -- Same datatype must be used, multiple foreign key can be provided(just in case needed)
UNIQUE(car_id)
);
INSERT INTO c_table(car_make,car_model) VALUES ('ford','a'),('maruthi','b');

SELECT * FROM c_table;

INSERT INTO p_table (fname,lname,country,car_id) VALUES ('munavar','hussain','india',2),('ashraf','kutbudeen','india',NULL),('corey','schrafer','us',1);

SELECT * FROM p_table;

DROP TABLE c_table; -- cannot drop table c_table because other objects depend on it

DROP TABLE p_table;

SELECT * FROM c_table,p_table; -- Table with records duplicated for each record of table 1 with table 2.

-- Inner joins (Records from tables a and b thats shares a same column)
SELECT * FROM p_table
JOIN c_table ON p_table.car_id = c_table.c_id;

SELECT * FROM p_table
JOIN c_table ON car_id = c_id; -- same result but not recommended

SELECT * FROM p_table
LEFT JOIN c_table ON p_table.car_id = c_table.c_id;

SELECT car_id,fname,car_make,car_model FROM p_table
LEFT JOIN c_table ON p_table.car_id = c_table.c_id;

-- Export to csv
--  \copy (SELECT fname,car_make,car_model FROM p_table JOIN c_table ON p_table.car_id = c_table.c_id) TO 'C:/users/AKMH/Desktop/results.csv' DELIMITER ',' CSV HEADER;

SELECT * FROM pg_available_extensions;
