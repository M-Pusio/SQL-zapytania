--4.1
SELECT 
	COUNT(*) AS Ilo��Produkt�w
FROM Shop.dbo.Product

--4.2
SELECT
	COUNT (*) AS Ilo��Produkt�w
FROM Shop.dbo.Product
WHERE Price < 100

--4.3
SELECT
	COUNT (*) AS LiczbaZam�wie�
FROM Shop.dbo.Orders
WHERE YEAR(OrderDate) = 2015

--4.4
SELECT 
	AVG (Price) AS �redniaCena,
	MIN (Price) AS MinimalnaCena,
	MAX (Price) AS MaksymalnaCena
FROM Shop.dbo.Product

--4.5
SELECT
	AVG (PPP.Price) AS �redniaCena
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.ProductCategory AS PCC ON PCC.Id=PPP.CategoryId
WHERE PCC.Name = 'Drive'

--4.6
SELECT
	SUM (OrderTotal) AS SumaZam�wie�
FROM Shop.dbo.Orders
WHERE 
	MONTH (OrderDate) = 2 
	AND YEAR (OrderDate) = 2015

--4.7
SELECT
	SUM (OOO.OrderTotal) AS SumaZam�wie�Kobiet
FROM Shop.dbo.Orders AS OOO
	INNER JOIN Shop.dbo.Employee AS EEE ON EEE.Id=OOO.EmployeeId
GROUP BY EEE.Gender
HAVING EEE.Gender = 'W'

--4.8
SELECT
	PCC.Name,
	COUNT (PPP.Name) AS Ilo��Produkt�w
FROM Shop.dbo.ProductCategory AS PCC
	LEFT OUTER JOIN Shop.dbo.Product AS PPP ON PPP.CategoryId=PCC.Id
GROUP BY PCC.Name

--4.9
SELECT
	EEE.FirstName,
	EEE.LastName,
	SUM (OOO.OrderTotal) AS SumaZam�wie�
FROM Shop.dbo.Employee AS EEE
	RIGHT OUTER JOIN Shop.dbo.Orders AS OOO ON OOO.EmployeeId=EEE.Id
GROUP BY 
	OOO.EmployeeId, 
	EEE.FirstName, 
	EEE.LastName
ORDER BY SUM (OOO.OrderTotal) DESC

--4.10
SELECT
	EEE.FirstName,
	EEE.LastName,
	SUM (OOO.OrderTotal) AS SumaZam�wie�
FROM Shop.dbo.Employee AS EEE
	RIGHT OUTER JOIN Shop.dbo.Orders AS OOO ON OOO.EmployeeId=EEE.Id
GROUP BY 
	OOO.EmployeeId, 
	EEE.FirstName, 
	EEE.LastName, 
	OOO.OrderDate
HAVING 
	YEAR (OOO.OrderDate) = '2015' 
	AND SUM (OOO.OrderTotal) > 2000 
	AND SUM (OOO.OrderTotal) < 3000

--4.11
SELECT
	PPP.Name,
	ISNULL (SUM (ODD.Quantity), '0') AS Ilo��Produkt�w
FROM Shop.dbo.Product AS PPP
	LEFT OUTER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.ProductId=PPP.Id
GROUP BY PPP.Name

--4.12
SELECT
	PPP.Name,
	MIN (OOO.OrderDate) AS DataPierwszegoZam�wienia
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.ProductId=PPP.Id
	INNER JOIN Shop.dbo.Orders AS OOO ON OOO.Id=ODD.OrderId
GROUP BY PPP.Name

--4.13
SELECT
	PPP.Name,
	COUNT (*) AS IleRazy
FROM Shop.dbo.Product AS PPP
	LEFT OUTER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.ProductId=PPP.Id
	LEFT OUTER JOIN Shop.dbo.Orders AS OOO ON OOO.Id=ODD.OrderId
WHERE YEAR (OOO.OrderDate) = '2015'
GROUP BY PPP.Name

--4.14
SELECT
	PPP.Name,
	ISNULL (SUM (ODD.Quantity), '0') AS Ilo��Sztuk
FROM Shop.dbo.Product AS PPP
	LEFT OUTER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.ProductId=PPP.Id
	LEFT OUTER JOIN Shop.dbo.Orders AS OOO ON OOO.Id=ODD.OrderId
WHERE ISNULL (YEAR (OOO.OrderDate),'2015') = '2015'
GROUP BY PPP.Name
HAVING ISNULL (SUM (ODD.Quantity), '0') < 10

--4.15
SELECT
	OOO.OrderNumber,
	COUNT (*)
FROM Shop.dbo.Orders AS OOO
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.OrderId=OOO.Id
GROUP BY OOO.OrderNumber

--4.16
SELECT
	OOO.OrderNumber,
	SUM (ODD.Quantity) AS LiczbaTowar�w
FROM Shop.dbo.Orders AS OOO
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.OrderId=OOO.Id
GROUP BY OOO.OrderNumber

--4.17
SELECT
	OOO.OrderNumber,
	AVG (ODD.UnitCost) AS �redniaCena
FROM Shop.dbo.Orders AS OOO
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.OrderId=OOO.Id
GROUP BY OOO.OrderNumber

--4.18
SELECT
	YEAR (OOO.OrderDate) AS Rok,
	SUM (OOO.OrderTotal) AS SumaZam�wie�
FROM Shop.dbo.Orders AS OOO
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.OrderId=OOO.Id
GROUP BY YEAR (OOO.OrderDate)

--4.19
SELECT
	DATENAME (MONTH, OOO.OrderDate) AS Miesi�c,
	SUM (OOO.OrderTotal) AS SumaZam�wie�
FROM Shop.dbo.Orders AS OOO
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.OrderId=OOO.Id
WHERE YEAR(OOO.OrderDate) = '2015'
GROUP BY DATENAME (MONTH, OOO.OrderDate)

--4.20
SELECT
	EEE.FirstName + ' ' + EEE.LastName AS Pracownik,
	YEAR (OOO.OrderDate) AS Rok,
	SUM (OOO.OrderTotal) AS SumaZam�wie�
FROM Shop.dbo.Employee AS EEE
	INNER JOIN Shop.dbo.Orders AS OOO ON OOO.EmployeeId=EEE.Id
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.OrderId=OOO.Id
WHERE EEE.Active = 1
GROUP BY
	YEAR (OOO.OrderDate), 
	EEE.FirstName + ' ' + EEE.LastName

--4.21
SELECT
	OOO.OrderNumber AS NumerZam�wienia,
	OOO.OrderTotal AS SumaZam�wienia,
	SUM (ODD.UnitCost * ODD.Quantity) AS SumaWyliczona
FROM Shop.dbo.Orders AS OOO
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.OrderId=OOO.Id
GROUP BY 
	OOO.OrderNumber, 
	OOO.OrderTotal
HAVING OOO.OrderTotal <> SUM (ODD.UnitCost * ODD.Quantity)

--4.22
SELECT TOP (1)
	EEE.FirstName,
	EEE.LastName,
	SUM (OOO.OrderTotal) AS SumaZam�wie�
FROM Shop.dbo.Employee AS EEE
	INNER JOIN Shop.dbo.Orders AS OOO ON OOO.EmployeeId=EEE.Id
GROUP BY 
	OOO.OrderTotal, 
	EEE.FirstName, 
	EEE.LastName
ORDER BY OOO.OrderTotal DESC

--4.23
SELECT TOP (1)
	DDD.Name,
	EEE.FirstName,
	EEE.LastName,
	SUM (OOO.OrderTotal) AS SumaZam�wie�
FROM Shop.dbo.Employee AS EEE
	INNER JOIN Shop.dbo.Orders AS OOO ON OOO.EmployeeId=EEE.Id
	INNER JOIN Shop.dbo.Department AS DDD ON DDD.Id=EEE.DepartmentId
GROUP BY 
	OOO.OrderTotal, 
	EEE.FirstName, 
	EEE.LastName, 
	DDD.Name
ORDER BY OOO.OrderTotal DESC

--4.24
SELECT
	PCC.Name,
	SUM (ODD.Quantity) AS Ilo��Produkt�w
FROM Shop.dbo.ProductCategory AS PCC
	INNER JOIN Shop.dbo.Product AS PPP ON PPP.CategoryId=PCC.Id
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.ProductId=PPP.Id
GROUP BY PCC.Name

--4.25
SELECT
	EEE.FirstName,
	EEE.LastName,
	EEE.Salary,
	SUM (OOO.OrderTotal) AS SumaZam�wie�
FROM Shop.dbo.Employee AS EEE
	INNER JOIN Shop.dbo.Orders AS OOO ON OOO.EmployeeId=EEE.Id
WHERE 
	MONTH (OOO.OrderDate) = '5' 
	AND YEAR (OOO.OrderDate) = '2015'
GROUP BY 
	EEE.FirstName, 
	EEE.LastName, 
	EEE.Salary
HAVING SUM (OOO.OrderTotal) > EEE.Salary

--4.26
SELECT
	MMM.FirstName,
	MMM.LastName,
	ISNULL (SUM (OOO.OrderTotal), '0') AS SumaZam�wie�
FROM Shop.dbo.Employee AS MMM
	INNER JOIN Shop.dbo.Department AS DDD ON DDD.ManagerId=MMM.Id
	LEFT OUTER JOIN Shop.dbo.Employee AS EEE ON EEE.DepartmentId=DDD.Id
	LEFT OUTER JOIN Shop.dbo.Orders AS OOO ON OOO.EmployeeId=EEE.Id
GROUP BY 
	MMM.FirstName, 
	MMM.LastName

--4.27
SELECT 
	DDD.Name,
	YEAR (OOO.OrderDate) AS Rok,
	MONTH (OOO.OrderDate) AS Miesi�c,
	COUNT (OOO.Id) AS LiczbaZam�wie�,
	SUM (ODD.Quantity) AS Ilo��Zam�wionychProdukt�w,
	SUM (OOO.OrderTotal) AS Warto��Zam�wie�
FROM Shop.dbo.Department AS DDD
	INNER JOIN Shop.dbo.Employee AS EEE ON EEE.DepartmentId=DDD.Id
	INNER JOIN Shop.dbo.Orders AS OOO ON OOO.EmployeeId=EEE.Id
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.OrderId=OOO.Id
GROUP BY 
	DDD.Id, 
	DDD.Name, 
	YEAR (OOO.OrderDate), 
	MONTH (OOO.OrderDate)
ORDER BY 
	DDD.Name, 
	YEAR (OOO.OrderDate), 
	MONTH (OOO.OrderDate)

--4.28
SELECT
	COUNT (OrderNumber) AS LiczbaZam�wie�,
	DATENAME(weekday, OrderDate) AS Dzie�Zam�wienia,
	SUM (OrderTotal) As Warto��Zam�wienia
FROM Shop.dbo.Orders
GROUP BY DATENAME(weekday, OrderDate)

--4.29
SELECT TOP 50 PERCENT
	PPP.Name AS NazwaProduktu,
	SUM (ODD.Quantity) AS Ilo��Produkt�w
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.ProductId=PPP.Id
GROUP BY PPP.Name
ORDER BY SUM (ODD.Quantity) DESC

--4.30
SELECT
	PPP.Name AS NazwaProduktu,
	SUM (ODD.Quantity) AS Ilo��Produkt�w
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.ProductId=PPP.Id
GROUP BY PPP.Name
HAVING SUM (ODD.Quantity) > 20

--4.31
SELECT 
	SUM (PPP.Price - ODD.UnitCost) AS R�nicaCen
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.ProductId=PPP.Id
WHERE ODD.UnitCost < PPP.Price

--4.32
SELECT 
	SUM (ODD.UnitCost * ODD.Quantity) AS Warto��Zam�wienia,
	SUM (PPP.Price * ODD.Quantity) AS Warto��WgCenySugerowanej
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.ProductId=PPP.Id

