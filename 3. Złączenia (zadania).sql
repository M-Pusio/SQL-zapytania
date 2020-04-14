--3.1
SELECT 
	OrderNumber, 
	OrderDate
FROM Shop.dbo.Orders AS OOO
	INNER JOIN Shop.dbo.Employee AS EEE ON OOO.EmployeeId=EEE.Id
WHERE LastName = 'Brown'

--3.2
SELECT 
	OrderNumber, 
	OrderDate
FROM Shop.dbo.Orders AS OOO
	INNER JOIN Shop.dbo.Employee AS EEE ON OOO.EmployeeId=EEE.Id
WHERE 
	LastName = 'Brown' 
	AND YEAR(OrderDate) = 2015

--3.3
SELECT 
	OOO.OrderNumber, 
	PPP.Name, 
	ODD.Quantity
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON PPP.Id=ODD.ProductId
	INNER JOIN Shop.dbo.Orders AS OOO ON OOO.Id=ODD.OrderId
WHERE OrderNumber = 'Z/25/2015'

--3.4
SELECT 
	PPP.Name, 
	ODD.Quantity
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON PPP.Id=ODD.ProductId
	INNER JOIN Shop.dbo.Orders AS OOO ON OOO.Id=ODD.OrderId
WHERE 
	YEAR(OrderDate) = '2015' 
	AND MONTH(OrderDate) = '02'

--3.5
SELECT PPP.Name
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.ProductCategory AS PCC ON PPP.CategoryId=PCC.Id
WHERE PCC.Name = 'drive'

--3.6
SELECT 
	PPP.Name AS Product, 
	PCC.Name AS Category
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.ProductCategory AS PCC ON PPP.CategoryId=PCC.Id
WHERE PCC.Name LIKE '%y'

--3.7
SELECT 
	PPP.Name AS Product, 
	PCC.Name AS Category
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.ProductCategory AS PCC ON PPP.CategoryId=PCC.Id
WHERE PPP.Name LIKE '%'+PCC.Name+'%'

--3.8
SELECT 
	PPP.Name, 
	ODD.Quantity
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON PPP.Id=ODD.ProductId
	INNER JOIN Shop.dbo.Orders AS OOO ON ODD.OrderId=OOO.Id
WHERE 
	YEAR(OOO.OrderDate) = '2015' 
	AND MONTH(OOO.OrderDate) = '6'

--3.9
SELECT PCC.Name
FROM Shop.dbo.ProductCategory AS PCC
	LEFT JOIN Shop.dbo.Product AS PPP ON PCC.Id=PPP.CategoryId
WHERE PPP.Id IS NULL

--3.10
SELECT PPP.Name
FROM Shop.dbo.Product AS PPP
	LEFT OUTER JOIN Shop.dbo.OrderDetails AS ODD ON PPP.Id=ODD.ProductId
WHERE ODD.ProductId IS NULL

--3.11
SELECT TOP (1) 
	EEE.FirstName, 
	EEE.LastName, 
	OOO.OrderTotal
FROM Shop.dbo.Employee AS EEE
	INNER JOIN Shop.dbo.Orders AS OOO ON OOO.EmployeeId=EEE.Id
ORDER BY OOO.OrderTotal DESC

--3.12
SELECT 
	OOO.OrderNumber, 
	OOO.OrderDate, 
	DATENAME(weekday,OOO.OrderDate) AS WeekDay, 
	UPPER(SUBSTRING(EEE.FirstName,1,3)+SUBSTRING(EEE.LastName,1,3)) AS 'Key'
FROM Shop.dbo.Orders AS OOO
	INNER JOIN Shop.dbo.Employee AS EEE ON OOO.EmployeeId=EEE.Id
	INNER JOIN Shop.dbo.Department AS DDD ON EEE.DepartmentId=DDD.Id
WHERE DDD.Name = 'IT'

--3.13
SELECT 
	OOO.OrderNumber, 
	OOO.OrderDate
FROM Shop.dbo.Orders AS OOO
	LEFT OUTER JOIN Shop.dbo.OrderDetails AS ODD ON OOO.Id=ODD.OrderId
WHERE ODD.Id IS NULL

--3.14
SELECT DISTINCT PPP.Name
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON PPP.Id=ODD.ProductId
	INNER JOIN Shop.dbo.Orders AS OOO ON ODD.OrderId=OOO.Id
	INNER JOIN Shop.dbo.Employee AS EEE ON OOO.EmployeeId=EEE.Id
WHERE EEE.SecondName IS NULL

--3.15
SELECT 
	EEE.FirstName, 
	EEE.LastName,
	EEE.Salary,
	OOO.OrderTotal
FROM Shop.dbo.Employee AS EEE
	INNER JOIN Shop.dbo.Orders AS OOO ON EEE.Id=OOO.EmployeeId
WHERE OOO.OrderTotal=EEE.Salary

--3.16
SELECT 
	PPP.Name, 
	ODD.Quantity, 
	EEE.FirstName, 
	EEE.LastName, 
	DATEDIFF(YEAR, EEE.BirthDate,GETDATE()) AS Age
FROM Shop.dbo.Product AS PPP
	INNER JOIN Shop.dbo.OrderDetails AS ODD ON PPP.Id=ODD.ProductId
	INNER JOIN Shop.dbo.Orders AS OOO ON ODD.OrderId=OOO.Id
	INNER JOIN Shop.dbo.Employee AS EEE ON OOO.EmployeeId=EEE.Id
WHERE ODD.Quantity = DATEDIFF(YEAR, EEE.BirthDate,GETDATE())

--3.17
SELECT 
	ODD.Quantity,
	EEE.FirstName,
	EEE.LastName,
	MONTH (OOO.OrderDate) AS Month
FROM Shop.dbo.OrderDetails AS ODD 
	INNER JOIN Shop.dbo.Orders AS OOO ON ODD.OrderId=OOO.Id
	INNER JOIN Shop.dbo.Employee AS EEE ON OOO.EmployeeId=EEE.Id
WHERE ODD.Quantity= MONTH(OOO.OrderDate)

--3.18.
SELECT 
	PPP.Name,
	PPP.Price,
	ODD.UnitCost
FROM Shop.dbo.Product AS PPP
	FULL OUTER JOIN Shop.dbo.OrderDetails AS ODD ON PPP.Id=ODD.ProductId
WHERE ODD.UnitCost<PPP.Price