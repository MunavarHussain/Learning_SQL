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
