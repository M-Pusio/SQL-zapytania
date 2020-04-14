--4.1
SELECT 
	COUNT(*) AS IloœæProduktów
FROM Shop.dbo.Product

--4.2
SELECT
	COUNT (*) AS IloœæProduktów
FROM Shop.dbo.Product
WHERE Price < 100

--4.3
SELECT
	COUNT (*) AS LiczbaZamówieñ
FROM Shop.dbo.Orders
WHERE YEAR(OrderDate) = 2015

--4.4
SELECT 
	AVG (Price) AS ŒredniaCena,
	MIN (Price) AS MinimalnaCena,
	MAX (Price) AS MaksymalnaCena
FROM Shop.dbo.Product

--4.5
SELECT
	AVG (PPP.Price) AS ŒredniaCena
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.ProductCategory AS PCC ON PCC.Id=PPP.CategoryId
WHERE PCC.Name = 'Drive'

--4.6
SELECT
	SUM (OrderTotal) AS SumaZamówieñ
FROM Shop.dbo.Orders
WHERE 
	MONTH (OrderDate) = 2 
	AND YEAR (OrderDate) = 2015

--4.7
SELECT
	SUM (OOO.OrderTotal) AS SumaZamówieñKobiet
FROM Shop.dbo.Orders AS OOO
	INNER JOIN Shop.dbo.Employee AS EEE ON EEE.Id=OOO.EmployeeId
GROUP BY EEE.Gender
HAVING EEE.Gender = 'W'

--4.8
SELECT
	PCC.Name,
	COUNT (PPP.Name) AS IloœæProduktów
FROM Shop.dbo.ProductCategory AS PCC
	LEFT OUTER JOIN Shop.dbo.Product AS PPP ON PPP.CategoryId=PCC.Id
GROUP BY PCC.Name

--4.9
SELECT
	EEE.FirstName,
	EEE.LastName,
	SUM (OOO.OrderTotal) AS SumaZamówieñ
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
	SUM (OOO.OrderTotal) AS SumaZamówieñ
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
	ISNULL (SUM (ODD.Quantity), '0') AS IloœæProduktów
FROM Shop.dbo.Product AS PPP
	LEFT OUTER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.ProductId=PPP.Id
GROUP BY PPP.Name

--4.12
SELECT
	PPP.Name,
	MIN (OOO.OrderDate) AS DataPierwszegoZamówienia
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
	ISNULL (SUM (ODD.Quantity), '0') AS IloœæSztuk
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
	SUM (ODD.Quantity) AS LiczbaTowarów
FROM Shop.dbo.Orders AS OOO
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.OrderId=OOO.Id
GROUP BY OOO.OrderNumber

--4.17
SELECT
	OOO.OrderNumber,
	AVG (ODD.UnitCost) AS ŒredniaCena
FROM Shop.dbo.Orders AS OOO
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.OrderId=OOO.Id
GROUP BY OOO.OrderNumber

--4.18
SELECT
	YEAR (OOO.OrderDate) AS Rok,
	SUM (OOO.OrderTotal) AS SumaZamówieñ
FROM Shop.dbo.Orders AS OOO
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.OrderId=OOO.Id
GROUP BY YEAR (OOO.OrderDate)

--4.19
SELECT
	DATENAME (MONTH, OOO.OrderDate) AS Miesi¹c,
	SUM (OOO.OrderTotal) AS SumaZamówieñ
FROM Shop.dbo.Orders AS OOO
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.OrderId=OOO.Id
WHERE YEAR(OOO.OrderDate) = '2015'
GROUP BY DATENAME (MONTH, OOO.OrderDate)

--4.20
SELECT
	EEE.FirstName + ' ' + EEE.LastName AS Pracownik,
	YEAR (OOO.OrderDate) AS Rok,
	SUM (OOO.OrderTotal) AS SumaZamówieñ
FROM Shop.dbo.Employee AS EEE
	INNER JOIN Shop.dbo.Orders AS OOO ON OOO.EmployeeId=EEE.Id
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.OrderId=OOO.Id
WHERE EEE.Active = 1
GROUP BY
	YEAR (OOO.OrderDate), 
	EEE.FirstName + ' ' + EEE.LastName

--4.21
SELECT
	OOO.OrderNumber AS NumerZamówienia,
	OOO.OrderTotal AS SumaZamówienia,
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
	SUM (OOO.OrderTotal) AS SumaZamówieñ
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
	SUM (OOO.OrderTotal) AS SumaZamówieñ
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
	SUM (ODD.Quantity) AS IloœæProduktów
FROM Shop.dbo.ProductCategory AS PCC
	INNER JOIN Shop.dbo.Product AS PPP ON PPP.CategoryId=PCC.Id
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.ProductId=PPP.Id
GROUP BY PCC.Name

--4.25
SELECT
	EEE.FirstName,
	EEE.LastName,
	EEE.Salary,
	SUM (OOO.OrderTotal) AS SumaZamówieñ
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
	ISNULL (SUM (OOO.OrderTotal), '0') AS SumaZamówieñ
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
	MONTH (OOO.OrderDate) AS Miesi¹c,
	COUNT (OOO.Id) AS LiczbaZamówieñ,
	SUM (ODD.Quantity) AS IloœæZamówionychProduktów,
	SUM (OOO.OrderTotal) AS WartoœæZamówieñ
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
	COUNT (OrderNumber) AS LiczbaZamówieñ,
	DATENAME(weekday, OrderDate) AS DzieñZamówienia,
	SUM (OrderTotal) As WartoœæZamówienia
FROM Shop.dbo.Orders
GROUP BY DATENAME(weekday, OrderDate)

--4.29
SELECT TOP 50 PERCENT
	PPP.Name AS NazwaProduktu,
	SUM (ODD.Quantity) AS IloœæProduktów
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.ProductId=PPP.Id
GROUP BY PPP.Name
ORDER BY SUM (ODD.Quantity) DESC

--4.30
SELECT
	PPP.Name AS NazwaProduktu,
	SUM (ODD.Quantity) AS IloœæProduktów
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.ProductId=PPP.Id
GROUP BY PPP.Name
HAVING SUM (ODD.Quantity) > 20

--4.31
SELECT 
	SUM (PPP.Price - ODD.UnitCost) AS Ró¿nicaCen
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.ProductId=PPP.Id
WHERE ODD.UnitCost < PPP.Price

--4.32
SELECT 
	SUM (ODD.UnitCost * ODD.Quantity) AS WartoœæZamówienia,
	SUM (PPP.Price * ODD.Quantity) AS WartoœæWgCenySugerowanej
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON ODD.ProductId=PPP.Id

