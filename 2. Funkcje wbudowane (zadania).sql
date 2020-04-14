--2.1
SELECT 
	Name AS Nazwa,
	YEAR (StartDate) AS [Rok rozpoczêcia dzia³alnoœci]
FROM Shop.dbo.Company

--2.2
SELECT DISTINCT 
	YEAR (StartDate) AS [Rok rozpoczêcia dzia³alnoœci]
FROM Shop.dbo.Company
WHERE StartDate IS NOT NULL

--2.3
SELECT *
FROM Shop.dbo.Company
WHERE YEAR (StartDate) BETWEEN 2000 AND 2005
ORDER BY 
	YEAR (StartDate), 
	Name

--2.4
SELECT *
FROM Shop.dbo.Company
WHERE Active = 1 AND MONTH(StartDate) IN (1,2)

--2.5
SELECT *
FROM Shop.dbo.Company
WHERE DATEDIFF(year,StartDate,GETDATE()) > 20

--2.6
SELECT *
FROM Shop.dbo.Company
WHERE 
	DATEPART(weekday,StartDate) = 6 
	AND MONTH(StartDate) = 5 
	AND DAY(StartDate) = 13 

--2.7 
SELECT *
FROM Shop.dbo.Company
WHERE 
	YEAR(StartDate) < 2000 
	OR StartDate IS NULL

--2.8
SELECT 
	*, 
	DATENAME(month,StartDate) AS Month
FROM Shop.dbo.Company
WHERE 
	Active = 1 
	AND StartDate IS NOT NULL
ORDER BY Month(StartDate)

--2.9
SELECT *
FROM Shop.dbo.Company
WHERE 
	YEAR(StartDate) % 4 = 0 
	AND (YEAR(StartDate) % 100 <> 0 
	OR YEAR(StartDate) % 400 = 0)

--2.10
SELECT TOP 1 *
FROM Shop.dbo.Company
WHERE 
	Active = 1 
	AND StartDate IS NOT NULL
ORDER BY StartDate DESC

--2.11
SELECT TOP 1 *
FROM Shop.dbo.Company
WHERE 
	Active = 1 
	AND DATEDIFF(year,StartDate, GETDATE()) < 20
ORDER BY StartDate

--2.12
SELECT 
	Name, 
	LEN(Name) AS AmountLetters
FROM Shop.dbo.Company
WHERE LEN(Name) >= 8

--2.13
SELECT *
FROM Shop.dbo.Company
WHERE Name LIKE 'K%'

--2.14 
SELECT 
	Name, 
	UPPER(SUBSTRING (Name,1,3)) AS ShortName
FROM Shop.dbo.Company
WHERE MONTH(StartDate) = 5

--2.15
SELECT 
	Name, 
	UPPER (RIGHT (Name,3))
FROM Shop.dbo.Company

--2.16
SELECT 
	Name,
	UPPER(ISNULL(Street,'nieznana')) + ' ' + LOWER(Number) AS Adress
FROM Shop.dbo.Company

--2.17 
SELECT TOP 2 WITH TIES 
	Name,
	LEN (Name) AS Length
FROM Shop.dbo.Company
ORDER BY Length DESC

--2.18 
SELECT DISTINCT LEN(Name) as Length
FROM Shop.dbo.Company
ORDER BY Length

--2.19 
SELECT Name
FROM Shop.dbo.Company
WHERE Name LIKE '__[A,O,E,I]%'
