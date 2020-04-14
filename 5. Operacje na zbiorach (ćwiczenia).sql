--5.1A
SELECT
	FirstName,
	LastName,
	Salary
FROM Shop.dbo.Employee
WHERE 
	Salary < 1000 
	OR Salary > 2000;


--5.1B
SELECT 
	FirstName, 
	LastName, 
	Salary
FROM Shop.dbo.Employee
WHERE Salary < 1000
	UNION ALL
SELECT 
	FirstName, 
	LastName, 
	Salary
FROM Shop.dbo.Employee
WHERE  Salary > 2000;


--5.2
SELECT 
	FirstName,
	LastName
FROM Shop.dbo.Employee
WHERE Active = 1
	UNION ALL
SELECT 
	FirstName, 
	LastName
FROM Shop.dbo.FormerEmployee
WHERE RelieveDate IS NOT NULL;


--5.3
SELECT 
	FirstName,
	LastName
FROM Shop.dbo.Employee
	UNION ALL
SELECT 
	FirstName, 
	LastName
FROM Shop.dbo.FormerEmployee
ORDER BY LastName;


--5.4
SELECT 
	FirstName,
	LastName
FROM Shop.dbo.Employee
	UNION
SELECT 
	FirstName, 
	LastName
FROM Shop.dbo.FormerEmployee
ORDER BY LastName;


--5.5
SELECT 
	FirstName,
	LastName
FROM Shop.dbo.Employee
WHERE Active = 0
	UNION
SELECT 
	FirstName,
	LastName
FROM Shop.dbo.FormerEmployee;


--5.6
SELECT 
	'Liczba Kobiet' AS Opis, 
	COUNT(*) AS 'Wartoœæ'
FROM Shop.dbo.Employee
WHERE Gender = 'W'
	UNION ALL
SELECT 
	'Liczba Mê¿czyzn', 
	COUNT(*)
FROM Shop.dbo.Employee
WHERE Gender = 'M';


