--Creating the Stored Procedures :



--Creating the Store Procedure 'sp_CalculateStoreKPI'

--Guide for finding the store names by store_id:
-- 1 -> Santa Cruz Bikes
-- 2 -> Baldwin Bikes
-- 3 -> Rowlett Bikes

CREATE PROCEDURE sp_CalculateStoreKPI
	@store_id INT
AS
BEGIN
	 WITH StoreSummary AS (
					       SELECT
						         s.store_name,
								 SUM(oi.quantity * oi.list_price) AS Revenue,
								 SUM(oi.quantity * oi.list_price) / COUNT(DISTINCT o.order_id) AS AverageOrderValue,
								 COUNT(DISTINCT c.customer_id) AS Customer_Per_Store
						   FROM Sales.orders AS o
						   INNER JOIN Sales.order_items AS oi ON o.order_id = oi.order_id
						   INNER JOIN Sales.customers AS c ON o.customer_id = c.customer_id
						   INNER JOIN Sales.stores AS s ON o.store_id = s.store_id
						   WHERE s.store_id = @store_id
						   GROUP BY s.store_name
						   )
						   SELECT * FROM StoreSummary;

	 WITH BrandSummary AS (
						   SELECT
						         b.brand_name,
								 SUM(oi.quantity * oi.list_price) AS Sales_By_Brand
						   FROM Production.brands AS b
						   INNER JOIN Production.products AS p ON b.brand_id = p.brand_id
						   INNER JOIN Sales.order_items AS oi ON p.product_id = oi.product_id
						   INNER JOIN Sales.orders AS o ON oi.order_id = o.order_id
						   INNER JOIN Sales.stores AS s ON o.store_id = s.store_id
						   WHERE s.store_id = @store_id
						   GROUP BY b.brand_name
						   )
						   SELECT * FROM BrandSummary;

	 WITH StaffSummary AS (
						   SELECT
						         st.staff_id,
								 st.first_name,
								 st.last_name,
								 SUM(oi.quantity * oi.list_price) AS Revenue_By_Staff,
								 COUNT(DISTINCT o.order_id) AS Orders_Handled
						   FROM Sales.orders AS o
						   INNER JOIN Sales.order_items AS oi ON o.order_id = oi.order_id
						   INNER JOIN Sales.stores AS s ON o.store_id = s.store_id
						   INNER JOIN Sales.staffs AS st ON s.store_id = st.store_id
						   WHERE s.store_id = @store_id
						   GROUP BY st.staff_id, st.first_name, st.last_name
						   )
						   SELECT * FROM StaffSummary ORDER BY Revenue_By_Staff DESC;
END

EXEC sp_CalculateStoreKPI @store_id = n



--Creating the Store Procedure 'sp_GenerateRestockList'

--Guide for finding the store names by store_id:
-- 1 -> Santa Cruz Bikes
-- 2 -> Baldwin Bikes
-- 3 -> Rowlett Bikes

CREATE PROCEDURE sp_GenerateRestockList
	@store_id INT
AS
BEGIN
     WITH Low_Stock_Per_Store AS (
	                              SELECT
										s.store_id,
										s.store_name,
										p.product_id,
										p.product_name,
										st.quantity AS Stock_Level
								  FROM Sales.stores AS s
								  INNER JOIN Production.stocks AS st ON s.store_id = st.store_id
								  INNER JOIN Production.products AS p ON st.product_id = p.product_id
								  WHERE s.store_id = @store_id AND st.quantity <= 10
								  )
								  SELECT * FROM Low_Stock_Per_Store 
END

EXEC sp_GenerateRestockList @store_id = n



--Creating the Store Procudure 'sp_TopSellingProducts':

--Guide for finding the store names by store_id:
-- 1 -> Santa Cruz Bikes
-- 2 -> Baldwin Bikes
-- 3 -> Rowlett Bikes

CREATE PROCEDURE sp_TopSellingProducts
	@store_id INT
AS
BEGIN
     WITH Dense_Ranked  AS (
						SELECT 
						      s.store_id,
						      s.store_name,
							  p.product_id,
						      p.product_name,
						      SUM(oi.quantity) AS TotalSold,
						      DENSE_RANK() OVER (ORDER BY SUM(oi.quantity) DESC) AS drank
						      FROM Sales.stores AS s
						      INNER JOIN Sales.orders AS o ON s.store_id = o.store_id
						      INNER JOIN Sales.order_items AS oi ON o.order_id = oi.order_id
						      INNER JOIN Production.products AS p ON oi.product_id = p.product_id
						      WHERE s.store_id = @store_id
						      GROUP BY
								      s.store_id,
								      s.store_name,
								      p.product_id,
								      p.product_name
						)
						SELECT * FROM Dense_Ranked
						WHERE drank <= 3
END

EXEC sp_TopSellingProducts @store_id = n



--Creating the Store Procedure 'sp_CompareSalesYearOverYear':

CREATE PROCEDURE sp_CompareSalesYearOverYear
	@Year1 INT,
	@Year2 INT
AS
BEGIN
     SELECT
	       YEAR(o.order_date) AS SalesYear,
		   SUM(oi.quantity * oi.list_price) AS Revenue
	 FROM Sales.orders AS o 
	 INNER JOIN Sales.order_items AS oi ON o.order_id = oi.order_id
	 WHERE YEAR(o.order_date) IN (@Year1, @Year2)
	 GROUP BY YEAR(o.order_date)
	 ORDER BY SalesYear ASC
END

EXEC sp_CompareSalesYearOverYear @Year1 = Y1, @Year2 = Y2



--Creating the Store Procedure 'sp_GetCustomerProfile':

ALTER PROCEDURE sp_GetCustomerProfile
	@customer_id INT
AS
BEGIN
     WITH Dense_Rank_sp AS (
	                        SELECT
								  c.customer_id,
								  c.first_name,
		                          c.last_name,
								  p.product_name,
		                          SUM(oi.quantity * oi.list_price) AS TotalSpend,
		                          COUNT(o.order_id) AS TotalOrders,
		                          DENSE_RANK() OVER (ORDER BY SUM(oi.quantity) DESC) AS denserank
	                        FROM Sales.customers AS c
	                        INNER JOIN Sales.orders AS o ON c.customer_id = o.customer_id
	                        INNER JOIN Sales.order_items AS oi ON o.order_id = oi.order_id
							INNER JOIN Production.products AS p ON oi.product_id = p.product_id
							WHERE c.customer_id = @customer_id
	                        GROUP BY
	                                c.customer_id,
			                        c.first_name,
			                        c.last_name,
									p.product_name
							)
							SELECT * FROM Dense_Rank_sp
							WHERE denserank < 3 
							ORDER BY TotalSpend DESC
END	

EXEC sp_GetCustomerProfile @customer_id = n
