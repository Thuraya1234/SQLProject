
---------- PROCEDURE WITH DEFAULT PARAMETERS ------------
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE customer_default ------------EXECUTE THIS BLOCK FIRST...
@id INT = 10, 
@fName NVARCHAR(40) OUTPUT, @lName NVARCHAR(40) OUTPUT, @phoneNO NVARCHAR(20) OUTPUT
AS 
BEGIN 
SELECT @fName = FirstName, @lName = LastName, @phoneNO = Phone
FROM Customer WHERE Id = @id;
END
------------------ THEN EXECUTE THE SECOND BLOCK ...
BEGIN
DECLARE @fName1 NVARCHAR(40);
DECLARE @lName1 NVARCHAR(40);
DECLARE @phoneNO1 NVARCHAR(20);
EXEC customer_default default ,@fName1 OUTPUT, @lName1 OUTPUT, @phoneNO1 OUTPUT; 
PRINT @fName1 + ' => ' + @lName1 + ' => '+ @phoneNO1;
END
