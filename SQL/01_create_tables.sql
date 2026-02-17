CREATE TABLE Sales.customers (
	customer_id INT PRIMARY KEY,
	first_name NVARCHAR(100),
	last_name NVARCHAR(100),
	phone NVARCHAR(100),
	email NVARCHAR(100),
	street NVARCHAR(100),
	city NVARCHAR(100),
	state NVARCHAR(100),
	zip_code INT)



--Creating table 'Sales.orders':

CREATE TABLE Sales.orders (
	order_id INT PRIMARY KEY,
	customer_id INT,
	order_status INT,
	order_date NVARCHAR(100),
	required_date NVARCHAR(100),
	shipped_date NVARCHAR(100),
	store_id INT,
	staff_id INT,
	CONSTRAINT FK_Sales_Orders_Customers FOREIGN KEY (customer_id) 
	REFERENCES Sales.customers(customer_id),
	CONSTRAINT FK_Sales_Orders_Stores FOREIGN KEY (store_id) 
	REFERENCES Sales.stores(store_id),
	CONSTRAINT FK_Sales_Orders_Staff FOREIGN KEY (staff_id)
	REFERENCES Sales.staffs(staff_id))


	
--Creating table 'Sales.staffs':

CREATE TABLE Sales.staffs (
	staff_id INT PRIMARY KEY,
	first_name NVARCHAR(100),
	last_name NVARCHAR(100),
	email NVARCHAR(100),
	phone NVARCHAR(100),
	active INT,
	store_id INT,
	manager_id NVARCHAR(100),
	CONSTRAINT FK_Sales_Staffs_Stores FOREIGN KEY (store_id)
	REFERENCES Sales.stores(store_id))



--Creating table 'Sales.stores':

CREATE TABLE Sales.stores (
	store_id INT PRIMARY KEY,
	store_name NVARCHAR(100),
	phone NVARCHAR(100),
	email NVARCHAR(100),
	street NVARCHAR(100),
	city NVARCHAR(100),
	state NVARCHAR(100),
	zip_code INT)



--Creating table 'Sales.order_items':

CREATE TABLE Sales.order_items (
	order_id INT,
	item_id INT IDENTITY(1,1) PRIMARY KEY,
	product_id INT,
	quantity INT,
	list_price DECIMAL(10,2),
	discount DECIMAL(5,2),
	CONSTRAINT FK_Sales_Order_Items_Orders FOREIGN KEY (order_id)
	REFERENCES Sales.orders(order_id),
	CONSTRAINT FK_Sales_Order_Items_Production_Products FOREIGN KEY (product_id)
	REFERENCES Production.products(product_id))



--Creating schema 'Production':

CREATE SCHEMA Production



--Creating table 'Production.table':



--Creating table 'Production.products':

CREATE TABLE Production.products (
	product_id INT PRIMARY KEY,
	product_name NVARCHAR(100),
	brand_id INT,
	category_id INT,
	model_year INT,
	list_price DECIMAL(10,2),
	CONSTRAINT FK_Production_Products_Brands FOREIGN KEY (brand_id)
	REFERENCES Production.brands(brand_id),
	CONSTRAINT FK_Production_Products_Categories FOREIGN KEY (category_id)
	REFERENCES Production.categories(category_id))



--Creating table 'Production.categories':

CREATE TABLE Production.categories (
	category_id INT PRIMARY KEY,
	category_name NVARCHAR(100))



--Creating table 'Production.stocks':

CREATE TABLE Production.stocks (
	store_id INT,
	product_id INT,
	quantity INT,
	CONSTRAINT FK_Production_Stocks_Stores FOREIGN KEY (store_id)
	REFERENCES Sales.stores(store_id),
	CONSTRAINT FK_Production_Stocks_Products FOREIGN KEY (product_id)
	REFERENCES Production.products(product_id))



--Creating table 'Production.brands':

CREATE TABLE Production.brands (
	brand_id INT PRIMARY KEY,
	brand_name NVARCHAR(100))
