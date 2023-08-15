
----------- to calculate the area of rectangular ----------------
begin
   declare @width numeric(4,1);
   declare @heigh numeric(4,1);
   set @width = 40;
   set @heigh = 20;
   print 'the area is '+ cast((@width * @heigh) as varchar);
end

----------------The average Price of all products ---------------
BEGIN

   DECLARE @avg NUMERIC(5,2);
   SET @avg = (SELECT avg(UnitPrice)
   FROM Products);
   PRINT 'The average Price of all products is ' + cast(@avg AS VARCHAR);

END

--------------- IF STATEMNT ..To check the product price------------------

BEGIN 
  DECLARE @price NUMERIC (12,2)
  SELECT @price = UnitPrice FROM Products
  WHERE ProductID = 38;
  IF @price >= 100
    PRINT 'THE PRODUCT IS EXPENSIVE';
  ELSE
    PRINT 'THE PRODUCT IS NOT EXPENSIVE';
END


BEGIN
DECLARE @price1 DECIMAL(12, 2) = 70;
IF @price1 >= 50
SELECT * FROM Products WHERE UnitPrice >= 50;
ELSE
SELECT * FROM Products WHERE UnitPrice < 50;
END

----------------- to use case statement to change the value of string or int---------------
SELECT CompanyName, Country = 
       CASE Country
	      WHEN 'UK' THEN 'United Kingdom'
		  WHEN 'USA' THEN 'United Stat'
		  ELSE Country
	   END
FROM Suppliers;

-------- TO CHECK THE CASE ...LIKE SWITCH IN PROGRAMMING..----------------
SELECT ProductName, Discontinued = 
      CASE Discontinued
	    WHEN  '1' THEN 'YES'
        WHEN  '0' THEN 'NO'	
	  END
FROM Products;


BEGIN 
 DECLARE @price2 NUMERIC(12, 2);
 DECLARE @id INT = 30;
 WHILE @id <=40
  BEGIN
   SELECT @price2 = UnitPrice
   FROM Product
   WHERE Id = @id;
   if @price2 >=100
    PRINT 'THE PRODUCT IS EXPENSIVE ';
	ELSE 
	PRINT'THE PRODUCT IS NOT EXPENSIVE';
	SET @id +=1;
  END
END

BEGIN
  DECLARE @name VARCHAR(30)
  DECLARE @contry VARCHAR(30)
  DECLARE @unm INT = 1;

 WHILE @unm<=10
   BEGIN 
    SELECT @name = FirstName , @contry = Country
	FROM Customer   
	WHERE Country = 'London';
	IF @contry = 'London'
	  PRINT 'country'+ @name + @contry;
	  SET @unm= @unm+ 1;
	  CONTINUE; 
   END
END

------------------------PRINT NUMBERS FROM 1, 10 AND SKIP NUMBERS DIVISIBLE BY 3-----------
BEGIN 
  DECLARE @NUMBER INT = 1;
  DECLARE @counter INT = 10;

  WHILE @NUMBER<=10
   BEGIN 
    if @NUMBER %3 =0
     BEGIN
	   SET @NUMBER+=1;
       Continue;
     END
    PRINT cast(@NUMBER as varchar);

    SET @NUMBER+=1;
    END
END
    
---------EXCEPTION HANDLING --------------

BEGIN TRY
  SELECT 1/0;
END TRY
BEGIN CATCH
  SELECT 
  @@ERROR AS ERROR,
  ERROR_MESSAGE() AS ErrorMessage;
END CATCH

 -----------------CURSER --------------

BEGIN
-- step1 : declare variables--
DECLARE @customerId INT;
DECLARE @fname NVARCHAR (40);
DECLARE @city NVARCHAR (40);
--- step2 : declare cursor--
DECLARE v_customer_cursor CURSOR FOR
 SELECT ID, FirstName, City
 FROM Customer
 WHERE Country = 'UK';
--- step3 : open cursor----
OPEN v_customer_cursor;
--- step4 : fetch rows from cursor ---
FETCH NEXT FROM v_customer_cursor INTO @customerId, @fname, @city
--fetch using loops--
WHILE @@FETCH_STATUS = 0 --if return value it will be 0 --else return -1
BEGIN 
PRINT 'Customer: ' + CAST(@customerId AS VARCHAR)+ ---for first customer
'=>' + @fname + 'from' + @city;
FETCH NEXT FROM v_customer_cursor  -- next customer
INTO @customerId, @fname, @city  
END
--- step5 : close cursor -----
CLOSE v_customer_cursor
-- step6 : deallocate cursor ---
DEALLOCATE v_customer_cursor
END

------------------------
BEGIN
-- step1 : declare variables--
DECLARE @ProductPrice DECIMAL(12, 2);
DECLARE @Companyname NVARCHAR (40);
--- step2 : declare cursor--
DECLARE v_product_cursor CURSOR FOR
 SELECT UnitPrice, CompanyName 
 FROM Product
 JOIN Supplier ON(Product.SupplierId = Supplier.Id)
 WHERE IsDiscontinued = '1';
 --- step3 : open cursor----
OPEN v_product_cursor;
--- step4 : fetch rows from cursor ---
FETCH NEXT FROM v_product_cursor INTO @ProductPrice, @Companyname
--fetch using loops--
WHILE @@FETCH_STATUS = 0 --if return value it will be 0 --else return -1
BEGIN 
PRINT 'Products have Discount: ' + CAST(@ProductPrice AS VARCHAR)+ ---for first customer
' => ' + @Companyname;
FETCH NEXT FROM v_product_cursor  -- next customer
INTO @ProductPrice, @Companyname 
END
--- step5 : close cursor -----
CLOSE v_product_cursor
-- step6 : deallocate cursor ---
DEALLOCATE v_product_cursor
END

 
select * from Supplier;

BEGIN 
DECLARE @fax NVARCHAR(30);
DECLARE @SupplierID INT;

DECLARE v_supplier_cursor CURSOR FOR
SELECT Fax ,Id
 FROM Supplier
 WHERE Country = 'UK';
OPEN v_supplier_cursor;
FETCH NEXT FROM v_supplier_cursor INTO @fax, @SupplierID
WHILE @@FETCH_STATUS = 0 
BEGIN
	SET @fax = 'Not Found'
	UPDATE Supplier SET Fax = @fax WHERE Country = 'UK' ;
    PRINT 'SUPPLIER: '+ CAST(@SupplierID AS VARCHAR)+
   '    The Fax : ' + @fax; 
FETCH NEXT FROM v_supplier_cursor  -- next customer
INTO @fax,@SupplierID
END
--- step5 : close cursor -----
CLOSE v_supplier_cursor
-- step6 : deallocate cursor ---
DEALLOCATE v_supplier_cursor
END


BEGIN
DECLARE @phone NVARCHAR(20);
DECLARE @cus_id INT;
DECLARE @cus_name NVARCHAR(40);

DECLARE p_customer_cursor CURSOR FOR
SELECT Id  ,FirstName, Phone
 FROM Customer
 WHERE Phone LIKE '%555%';

OPEN p_customer_cursor;
--- step4 : fetch rows from cursor ---
FETCH NEXT FROM p_customer_cursor INTO  @cus_id, @cus_name, @phone
--fetch using loops--
WHILE @@FETCH_STATUS = 0 --if return value it will be 0 --else return -1
BEGIN 
PRINT ' THE CUSTOMER WHICH HAVE 555  ' + CAST(@cus_id AS VARCHAR)+ ---for first customer
' => ' + @cus_name + ' => ' + @phone;
FETCH NEXT FROM p_customer_cursor  -- next customer
INTO  @cus_id, @cus_name, @phone
END
--- step5 : close cursor -----
CLOSE p_customer_cursor
-- step6 : deallocate cursor ---
DEALLOCATE p_customer_cursor
END


