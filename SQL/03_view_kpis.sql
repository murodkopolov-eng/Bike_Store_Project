--Creating the Views:



--Creating the view 'vw_StoreSalesSummary':

CREATE VIEW vw_StoreSalesSummary
AS
SELECT
	  s.store_name,
	  SUM( i.quantity * i.list_price ) AS Revenue,
	  COUNT( DISTINCT o.order_id ) AS Orders,
	  SUM( i.quantity * i.list_price ) * 1.0 / COUNT( DISTINCT o.order_id ) AS AOV
FROM Sales.order_items AS i
INNER JOIN Sales.orders AS o ON i.order_id = o.order_id
INNER JOIN Sales.stores AS s ON o.store_id = s.store_id
GROUP BY s.store_name

SELECT * FROM vw_StoreSalesSummary



--Creating the view 'vw_TopSellingProducts':

CREATE VIEW vw_TopSellingProducts
AS
SELECT
      p.product_name,
	  SUM(i.quantity * i.list_price) AS TotalSales,
	  DENSE_RANK() OVER (ORDER BY SUM(i.quantity * i.list_price) ASC ) AS Rank
FROM Production.products AS p
INNER JOIN Sales.order_items AS i ON p.product_id = i.product_id
GROUP BY p.product_name

SELECT * FROM vw_TopSellingProducts



--Creating the view 'vw_InventoryStatus':

CREATE VIEW vw_InventoryStatus
AS
SELECT 
      s.store_id,
	  s.store_name,
	  p.product_id,
	  p.product_name,
	  st.quantity AS Stock_Level
FROM Sales.stores AS s
INNER JOIN Production.stocks AS st ON s.store_id = st.store_id
INNER JOIN Production.products AS p ON st.product_id = p.product_id
WHERE st.quantity <= 10;
      
SELECT * FROM vw_InventoryStatus
ORDER BY Stock_Level ASC;



--Creating the view 'vw_StaffPerformance':

CREATE VIEW vw_StaffPerformance
AS
SELECT 
      s.staff_id,
	  COUNT(o.order_id) AS Orders,
	  SUM(i.quantity * i.list_price) AS Revenue
FROM Sales.orders AS o
INNER JOIN Sales.staffs AS s ON o.staff_id = s.staff_id
INNER JOIN Sales.order_items AS i ON o.order_id = i.order_id
GROUP BY s.staff_id

SELECT * FROM vw_StaffPerformance



--Creating the view 'vw_RegionalTrends':

CREATE VIEW vw_RegionalTrends
AS
SELECT
      s.city,
	  SUM(i.quantity * i.list_price) AS Revenue
FROM Sales.order_items AS i
INNER JOIN Sales.orders AS o ON i.order_id = o.order_id
INNER JOIN Sales.stores AS s ON o.store_id = s.store_id
GROUP BY s.city

SELECT * FROM vw_RegionalTrends



--Create the view 'vw_SalesByCategory':

CREATE VIEW vw_SalesByCategory
AS
SELECT 
      c.category_name,
	  SUM(oi.quantity * oi.list_price) AS Revenue
FROM Production.categories AS c
INNER JOIN Production.products AS p ON c.category_id = p.category_id
INNER JOIN Sales.order_items AS oi ON p.product_id = oi.product_id
GROUP BY c.category_name

SELECT * FROM vw_SalesByCategory
ORDER BY Revenue DESC

--Data is not enough to find margin
