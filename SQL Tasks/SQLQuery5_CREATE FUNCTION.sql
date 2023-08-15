----------------------------------------------------------------
------- CREATE FUNCTION TO CALCULATE CIRCLE OF AREA -------------

CREATE OR ALTER FUNCTION circle_area (@p_radius NUMERIC(10, 2))
RETURNS NUMERIC(8, 2)
AS
BEGIN
DECLARE @v_pi NUMERIC(8, 2) = PI();
DECLARE @v_area NUMERIC(8, 2);

SET @v_area = @v_pi * POWER(@p_radius, 2);
RETURN @v_area;
END;
--------Execute first block first ,,then statement bellow...----------
SELECT dbo.circle_area(5) AS area;


----------------------------------------------------------------------------------------------------------------------
-------CREATE A SCALAR FUNCTION THAT CONCATENATES A FIRST NAME AND LAST NAME AND TAKING THE ID AS PARAMETER..---------

CREATE OR ALTER FUNCTION Full_Name (@id INT)
RETURNS NVARCHAR(40)
AS
BEGIN
DECLARE @FNAME NVARCHAR(40);
DECLARE @LNAME NVARCHAR(40);
DECLARE @RESULT NVARCHAR(40);
SELECT @FNAME = FirstName, @LNAME = LastName FROM Customer
WHERE Id = @id;
SET @RESULT = @FNAME + ' ' + @LNAME;
RETURN @RESULT;
END;
--------Execute first block first ,,then statement bellow...----------
SELECT dbo.Full_Name(5) AS NameCustomer;

-------------------FUNCTION TO RETURN TABLE USING PARAMETER-----------
CREATE OR ALTER FUNCTION GetCustomerByCountry (@country NVARCHAR(50))
RETURNS TABLE
AS
RETURN
  SELECT Id, FirstName, LastName, City
  FROM Customer
  WHERE Country = @country;

SELECT * FROM dbo.GetCustomerByCountry('USA');


------------------------------------------------------------------------------------------------------------
--------------CREATE A TABLE_VALUED FUNCTION THAT RETURNS A LIST OF PRODUCT IN A SPECIFIC COMPANY-----------
------------------------------------------------------------------------------------------------------------
CREATE OR ALTER FUNCTION GetSupplierProductDetails (@comp INT)
RETURNS TABLE
AS
RETURN
  SELECT Product.Id, Product.ProductName, Supplier.CompanyName FROM Product
  INNER JOIN Supplier ON (Supplier.Id = Product.SupplierId)
  WHERE SupplierId = @comp;
---------TO EXECUTE -------
SELECT * FROM dbo.GetSupplierProductDetails(2);


----CREATE A FUNCTION THAT DETERMINE THE TOTAL SALES AMOUNT FOR EACH YEAR AND EACH CUSTOMER AND TAKING YEAR AS A PARAMETER-----
-------------------------------------------------------------------------------------------------------------------------------

CREATE OR ALTER FUNCTION TotalSalesDetails (@year DATETIME)
RETURNS TABLE
AS
RETURN
  SELECT YEAR(O.OrderDate) AS "Year", C.Id , FirstName, LastName, SUM(TotalAmount) AS "Sum"
  FROM [Order] O, Customer C
  WHERE O.CustomerId = C.Id AND YEAR(O.OrderDate) = @year
  GROUP BY YEAR(O.OrderDate), C.Id , FirstName, LastName;

SELECT * FROM dbo.TotalSalesDetails(2012);


