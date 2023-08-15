EXEC sp_help 'table2';
EXEC sp_help 'courses';
SELECT * FROM Customer;


EXEC sp_rename Student, student_1;

ALTER DATABASE makeenDB MODIFY NAME = makeen;

ALTER TABLE student_1 ADD phone NUMERIC(8);

ALTER TABLE student_1 ALTER COLUMN phone DECIMAL (20, 2)

ALTER TABLE student_1 DROP COLUMN phone;


CREATE TABLE employee(e_id int, e_name varchar(15) not null, constraint pk_id_emp primary key(e_id));
CREATE TABLE teacher(t_id int, t_name varchar(15) not null);


ALTER TABLE teacher ALTER COLUMN t_id INT NOT NULL; 
ALTER TABLE teacher ADD CONSTRAINT t_pk PRIMARY KEY(t_id); 


CREATE TABLE students(s_id INT CONSTRAINT S_studentid_pk primary key, s_first_name VARCHAR(30), s_last_name VARCHAR(30),s_email VARCHAR(50),
s_mobile_no CHAR(10), s_gender CHAR(1), s_fees NUMERIC(8,2), course_id CHAR(8),
CONSTRAINT student_course_fk FOREIGN KEY(course_id) REFERENCES courses(c_id));


INSERT INTO students (s_id, s_first_name, s_last_name, s_email, s_mobile_no, s_gender, s_fees, course_id)
VALUES (1, 'Ahmed', 'Saleh','ahmed@gmail.com', '91148866', 'M', 500, '1');
INSERT INTO students VALUES (2, 'Rahma', 'Abdullah','rahma@gmail.com', '99424766', 'F', 600, '2');

DELETE FROM students;


CREATE TABLE courses(c_id CHAR(8) CONSTRAINT c_courseid_pk primary key, c_name VARCHAR(20));
INSERT INTO courses (c_id, c_name) VALUES (1, 'Noor');
INSERT INTO courses VALUES (2, 'Omar');


SELECT TABLE_NAME,CONSTRAINT_TYPE,CONSTRAINT_NAME 
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME ='students';

ALTER TABLE students DROP CONSTRAINT student_course_fk;
ALTER TABLE students ADD CONSTRAINT student_course_fk FOREIGN KEY(course_id) REFERENCES courses(c_id); 

ALTER TABLE students DROP CONSTRAINT S_studentid_pk;
ALTER TABLE students ADD CONSTRAINT S_studentid_pk PRIMARY KEY(s_id); 

UPDATE students SET s_last_name = 'Naser' WHERE s_id = 1;


SELECT CONVERT (date, SYSDATETIME()), CONVERT (time, SYSDATETIME()), CONVERT (time, SYSDATETIMEOFFSET());
SELECT SYSDATETIME();
SELECT SYSDATETIME() AS Today;



CREATE TABLE table1 (col_1 INT, col_2 VARCHAR(20));
CREATE TABLE table2 (col_1 INT, col_2 VARCHAR(20));
INSERT INTO table1 VALUES(5, 'Thuraya Abdullah');
INSERT INTO table2 (col_1, col_2) SELECT col_1, col_2 FROM table1 ;



CREATE TABLE product (p_id INT CONSTRAINT PK_PRO_ID PRIMARY KEY, p_name VARCHAR(30), p_quantity INT, p_price NUMERIC(8,2));
INSERT INTO product VALUES (1, 'Water', 2, 200);
INSERT INTO product VALUES (2, 'Water2', 4, 400);
SELECT p_quantity * p_price AS total_price FROM product WHERE p_name = 'Water2'; --virtual column to calculate total price ..



CREATE TABLE student3(stu_id INT PRIMARY KEY, stu_name VARCHAR(30), stu_address VARCHAR(30));
INSERT INTO student3 VALUES(1, 'Salim', 'Muscat');
INSERT INTO student3 VALUES(2, 'Nader', 'Ibri');
UPDATE student3 SET stu_address = (SELECT stu_address FROM student3 WHERE stu_name = 'Salim') WHERE stu_name = 'Nader';


BEGIN TRANSACTION  -- must begin with this command ..
UPDATE student3 SET stu_address = 'Ibri' WHERE stu_name = 'Nader';
SAVE TRANSACTION save1;  -- if execute save commands will not active roll back commands...
ROLLBACK;  -- to undo the last commmand, but will not affect if save commands execute first...


---------------------------------------
------------ SQL FUNCTIONS ------------
---------------------------------------

SELECT SUM(p_price) AS total_price FROM product; --virtual column to calculate sum of total price using SUM() Function  ..
SELECT COUNT(p_price) AS total_price FROM product; --virtual column to calculate count of total price using count() Function  ..


SELECT FirstName FROM Customer order by FirstName ASC; 

SELECT COUNT(CustomerId), FirstName FROM "Order" , Customer
WHERE "Order".CustomerId = Customer.Id --WHERE .. can't used after aggregate functions(group by)
AND "Order".OrderDate < '2013-01-01'
GROUP BY FirstName  
HAVING COUNT(CustomerId)> 5 -- HAVING must be used after GROUP BY, because must be be used with AGGREGATE FUNCTION , 
ORDER BY FirstName DESC;

SELECT TOP 6 MAX(TotalAmount) AS TOTAL, FirstName, LastName 
FROM "Order" , Customer 
WHERE "Order".CustomerId = Customer.Id
GROUP BY FirstName, LastName
ORDER BY TOTAL DESC;

SELECT AVG(UnitPrice) As Average, CompanyName 
FROM Product, Supplier
WHERE Product.SupplierId = Supplier.Id
GROUP BY CompanyName;

SELECT COUNT(CompanyName) AS CompanyNumber, Country 
FROM Supplier
GROUP BY Country;
 
SELECT MAX(Quantity) AS HighQuantity, FirstName, LastName
from OrderItem, Product, Customer, "Order"
WHERE OrderItem.ProductId = Product.Id AND "Order".CustomerId = Customer.Id AND OrderItem.OrderId = "Order".Id
GROUP BY  FirstName, LastName
ORDER BY HighQuantity DESC;

------- LIKE and IN Conditions -------

SELECT FirstName FROM Customer WHERE FirstName LIKE 'j%';

SELECT * FROM Customer WHERE Country IN ('UK', 'Maxico');

SELECT FirstName FROM Customer WHERE Phone LIKE ('%555%');

SELECT FirstName + LastName AS "Student Name" FROM Customer;

------- Create sequence (For generate numbers rather than use primary key)-------

CREATE SEQUENCE TestSequence;
SELECT * FROM sys.sequences WHERE name = 'TestSequence';


CREATE SEQUENCE CountBy1 START WITH 1 INCREMENT BY 1;
SELECT NEXT VALUE FOR CountBy1;


CREATE SEQUENCE DecSeq 
AS decimal (3, 0)
START WITH 125
INCREMENT BY 25
MINVALUE 100
MAXVALUE 200
CYCLE
CACHE 3;
SELECT NEXT VALUE FOR DecSeq;

DROP SEQUENCE CountBy1;


------------------------------
---------INDEX COMMAND--------
------------------------------

SELECT * FROM Customer WHERE FirstName = 'Thomas'; --- index search rows ..execute, then select a row that will appear, then press ctrl+l ...
SELECT * FROM Customer WHERE Id = 5;

CREATE INDEX Customer_Index ON Customer(FirstName);
SELECT * FROM Customer WHERE Id = 5;


SELECT CONVERT (VARCHAR(10), GETDATE(), 120);     

SELECT DATEDIFF(DAY, '2022-01-01', '2022-01-10')
SELECT YEAR('2022-06-01');

CREATE TABLE [Order Item](id int, order1 varchar(20)); -- we can use [] to put name of table with space...