--------procedure with parameters--------

CREATE OR ALTER PROCEDURE customer_details
@id INT, ------- WHEN WANT SYSTEM TO FETCH DEFAULT VALUE, USE @id INT = 5
@fName NVARCHAR(40) OUTPUT, @lName NVARCHAR(40) OUTPUT, @phoneNO NVARCHAR(20) OUTPUT
AS 
BEGIN 
SELECT @fName = FirstName, @lName = LastName, @phoneNO = Phone
FROM Customer WHERE Id = @id;
END

BEGIN
DECLARE @fName1 NVARCHAR(40);
DECLARE @lName1 NVARCHAR(40);
DECLARE @phoneNO1 NVARCHAR(20);
EXEC customer_details 5, @fName1 OUTPUT, @lName1 OUTPUT, @phoneNO1 OUTPUT ; 
PRINT @fName1 + ' => ' + @lName1 + ' => '+ @phoneNO1;
END



