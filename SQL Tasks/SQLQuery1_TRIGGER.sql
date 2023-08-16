-----------------------------------------------------------------
---------------------------TRIGGERS------------------------------


----------TRIGGER FOR UPDATE SALARY----------
CREATE OR ALTER TRIGGER EmpSalCheck ON Employees FOR UPDATE 
AS
BEGIN
   DECLARE @old_salary DECIMAL(18,2);
   DECLARE @new_salary DECIMAL(18,2);

   SELECT @old_salary = Salary FROM deleted;
   SELECT @new_salary = Salary FROM inserted;
   IF @old_salary > @new_salary
    BEGIN
	 PRINT 'New salary cannot be less than old salary';
	 ROLLBACK;
	END
END
----then execute the choosen statement for update----
UPDATE Employees SET Salary = Salary - 500;

UPDATE Employees SET Salary = Salary + 500;


---------- TRIGGER FOR DELETE ACTION ----------

CREATE OR ALTER TRIGGER EmpDelCheck ON Employees FOR DELETE 
AS
BEGIN
   DECLARE @count INT;

   SELECT @count = COUNT(*) FROM deleted;
   IF @count > 1
      BEGIN
	    PRINT 'Cannot delete more than one record at a time';
		ROLLBACK;
	 END
END
-------------------------------
DELETE FROM Employees; --- Will not delete because of if statement ----

-------------------------------------

CREATE OR ALTER TRIGGER CusUpCity ON Customer FOR UPDATE 
AS
BEGIN
  DECLARE @oldCity NVARCHAR(40);
  DECLARE @newCity NVARCHAR(40);

  SELECT @oldCity = City FROM deleted;
  SELECT @newCity = City FROM inserted;

END

-------------------insert view will insert trigger---EmpDP TABLE------------
/*CREATE OR ALTER VIEW EmpView AS
SELECT e.EmployeeId, e.DepartmentId, e.FirstName, e.Salary, d.DepartmentName
from Employees e, Department d
WHERE d.DepartmentId = e.DepartmentId;

CREATE OR ALTER TRIGGER trig_EmpView ON EmpView INSTEAD OF INSERT AS
BEGIN
  DECLARE @empid INT;
  DECLARE @name NVARCHAR(50);
  DECLARE @sal DECIMAL(18,2);
  DECLARE @depid INT;
  SELECT @empid = EmployeeId, @name = FirstName, @sal = Salary, @depid = d.DepartmentId
  FROM Department d, inserted
  WHERE d.DepartmentName = inserted.DepartmentName;

  IF @depid IS NULL
  BEGIN
     PRINT 'Invalid Department';
	 ROLLBACK;
  END;
  INSERT INTO Employees (EmployeeId, FirstName, Salary, DepartmentId) VALUES(@empid, @name, @sal, @depid)

END;

INSERT INTO EmpView VALUES(11, 'Noor', 60550, );


SELECT * FROM Department;
*/

--------------------------------view + trigger---SDBtest table ----------------------------
CREATE OR ALTER VIEW OrderView AS
SELECT o.OrderDate, o.OrderNumber, c.FirstName, c.LastName
FROM "Order" o, Customer c
WHERE c.Id = o.CustomerId;

CREATE OR ALTER TRIGGER trig_OrderView ON OrderView INSTEAD OF INSERT AS
BEGIN
  DECLARE @custId INT;
  DECLARE @orderdate DATETIME;
  DECLARE @orderNo INT;
  SELECT @orderNo =OrderNumber, @orderdate = OrderDate, @custId = c.Id
  FROM "Order" o, Customer c, inserted
  WHERE c.FirstName = inserted.FirstName AND c.LastName = inserted.LastName

  IF @custId IS NULL
  BEGIN
     PRINT 'Invalid Customer';
	 ROLLBACK;
  END;
  INSERT INTO "Order" (OrderDate, OrderNumber,CustomerId)VALUES(@orderdate, @orderNo, @custId)
END;

select * from "Order";
INSERT INTO OrderView VALUES('2013-05-04', '543207', 'Maria', 'Anders');
