-----------------------------------------
-----------------PROCEDURE---------------
-----------------------------------------

CREATE OR ALTER PROCEDURE product_details
@id INT, @productName NVARCHAR(50) OUTPUT, @unitPrice DECIMAL(12, 2) OUTPUT
AS ------------Will write which inside procedure (PROCEDURE DEFINITION)
BEGIN 
SELECT @productName = ProductName, @unitPrice = UnitPrice 
FROM Product WHERE Id = @id;
END
--------------------- EXECUTE THE PROCEDURE WITH PARAMETERS--------------
BEGIN
DECLARE @name NVARCHAR(50);
DECLARE @price DECIMAL(12, 2);

EXEC product_details 11, @name OUTPUT, @price OUTPUT;
--PRINT @name + ' => ' + CAST(@price AS NVARCHAR);
PRINT @name;
PRINT @price;
END

/*
CREATE OR ALTER PROCEDURE read_products_procedure
@pCity AS NVARCHAR(40) AS
BEGIN 
DECLARE @city_name NVARCHAR(40) = @pCity;
SELECT * FROM Supplier WHERE City = @city_name;
END

EXEC read_products_procedure 'New Orleans';
*/

