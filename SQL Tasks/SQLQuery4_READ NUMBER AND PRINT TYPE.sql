---------------------------------------------------------------------
----------READ NUMBER AND PRINT TYPE OF NUMBER IF ODD OR EVEN--------
---------------------------------------------------------------------

CREATE OR ALTER PROCEDURE read_number ------------ EXECUTE THIS BLOCK FIRST...
@num INT , @type_num NVARCHAR(20) OUTPUT
AS
BEGIN
IF @num % 2 = 0
  BEGIN
    SET @type_num = 'EVEN NUMBER'
  END
ELSE
  BEGIN
    SET @type_num = 'ODD NUMBER'
  END
END

BEGIN
DECLARE @type_num1 NVARCHAR(20);

EXEC read_number 8, @type_num1 OUTPUT;
PRINT @type_num1;
END

