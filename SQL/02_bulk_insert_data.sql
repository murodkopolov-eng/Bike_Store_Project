--Transfering the 'customers' table:

BULK INSERT Sales.customers
FROM 'C:\Users\Hp\Downloads\customers.csv'
WITH (
	  FIRSTROW = 2,
	  FIELDTERMINATOR = ',',
	  ROWTERMINATOR = '\n' )



--Transfering the 'orders' table:

BULK INSERT Sales.orders
FROM 'C:\Users\Hp\Downloads\orders.csv'
WITH (
	  FIRSTROW = 2,
	  FIELDTERMINATOR = ',',
	  ROWTERMINATOR = '\n' )



--Transfering the 'staffs' table:

BULK INSERT Sales.staffs
FROM 'C:\Users\Hp\Downloads\staffs.csv'
WITH (
	  FIRSTROW = 2,
	  FIELDTERMINATOR = ',',
	  ROWTERMINATOR = '\n' )



--Transfering the 'stores' table:

BULK INSERT Sales.stores 
FROM 'C:\Users\Hp\Downloads\stores.csv'
WITH (
	  FIRSTROW = 2,
	  FIELDTERMINATOR = ',',
	  ROWTERMINATOR = '\n' )



--Transfering the 'order_items' table:

BULK INSERT Sales.order_items
FROM 'C:\Users\Hp\Downloads\order_items.csv'
WITH (
	  FIRSTROW = 2,
	  FIELDTERMINATOR = ',',
	  ROWTERMINATOR = '\n' )



--Transfering the 'categories' table:

BULK INSERT Production.categories
FROM 'C:\Users\Hp\Downloads\categories.csv'
WITH (
	  FIRSTROW = 2,
	  FIELDTERMINATOR = ',',
	  ROWTERMINATOR = '\n' )



--Transfering the 'products' table:

BULK INSERT Production.products
FROM 'C:\Users\Hp\Downloads\products (1).csv'
WITH (
	  FIRSTROW = 2,
	  FIELDTERMINATOR = ',',
	  ROWTERMINATOR = '\n' )

	  

--Transfering the 'stocks' table:

BULK INSERT Production.stocks
FROM 'C:\Users\Hp\Downloads\stocks.csv'
WITH (
	  FIRSTROW = 2,
	  FIELDTERMINATOR = ',',
	  ROWTERMINATOR = '\n' )



--Transfering the 'brands' table:

BULK INSERT Production.brands
FROM 'C:\Users\Hp\Downloads\brands.csv'
WITH (
	  FIRSTROW = 2,
	  FIELDTERMINATOR = ',',
	  ROWTERMINATOR = '\n' )
