--1.1
SELECT *
FROM Shop.dbo.Company
WHERE Name LIKE 'P%'

--1.2
SELECT *
FROM Shop.dbo.Company
WHERE 
	CityId = 1 
	AND PostCode LIKE '5%'

--1.3A
SELECT *
FROM Shop.dbo.Company
WHERE 
	Active = 1 
	AND StartDate >= '2000-01-01' 
	AND StartDate <= '2000-12-31'

--1.3B
SELECT *
FROM Shop.dbo.Company
WHERE 
	Active = 1 
	AND StartDate BETWEEN '2000-01-01' AND '2000-12-31'

--1.4
SELECT 
	Name, 
	AnnualIncome, 
	AnnualIncome / 12 AS 'MonthIncome'
FROM Shop.dbo.Company
WHERE 
	Active = 1 
	AND EmployeeCount > 1000

--1.5
SELECT TOP (3) 
	Name, 
	AnnualIncome / 12 AS 'MonthIncome'
FROM Shop.dbo.Company
ORDER BY AnnualIncome DESC

--1.6
SELECT *
FROM Shop.dbo.Company
WHERE AnnualIncome/12 > 10000

--1.7A
SELECT 
	Name, 
	PostCode, 
	Street + ' ' + Number AS Address
FROM Shop.dbo.Company
WHERE PostCode IN ('54-621', '78-695', '63-896')

--1.7B
SELECT 
	Name, 
	PostCode, 
	Street + ' ' + Number AS Address
FROM Shop.dbo.Company
WHERE 
	PostCode = '54-621' 
	OR PostCode = '78-695' 
	OR PostCode = '63-896'

--1.8
SELECT 
	Name, 
	ISNULL (Street, 'ulica nieznana') + ' ' + Number AS Address
FROM Shop.dbo.Company

--1.9A
SELECT *
FROM Shop.dbo.Company
WHERE 
	CityId <> 1 
	AND CityId <> 3 
	AND CityId <> 5

--1.9B
SELECT *
FROM Shop.dbo.Company
WHERE CityId LIKE '[^1,3,5]'

--1.9C
SELECT *
FROM Shop.dbo.Company
WHERE CityId NOT IN (1,3,5)

--1.10
SELECT *
FROM Shop.dbo.Company
WHERE 
	Active = 1 
	AND StartDate IS NULL

--1.11
SELECT *
FROM Shop.dbo.Company
WHERE Name LIKE '[CTP]%[OR]'

--1.12
SELECT *
FROM Shop.dbo.Company
WHERE Name LIKE '_O%[^E]'

--1.13
SELECT TOP (3) *
FROM Shop.dbo.Company
WHERE StartDate IS NOT NULL
ORDER BY StartDate

--1.14
SELECT 
	Name, 
	EmployeeCount, 
	1000 - EmployeeCount AS AmountOfEmployeesMissingTo1000
FROM Shop.dbo.Company
WHERE 
	Active = 1 
	AND EmployeeCount < 1000

--1.15
SELECT 
	Name, 
	AnnualIncome/EmployeeCount AS IncomePerEmployee
FROM Shop.dbo.Company
WHERE Active = 1

--1.16
SELECT Name
FROM Shop.dbo.Company
WHERE AnnualIncome/EmployeeCount > 300

--1.17
SELECT TOP (1) * 
FROM Shop.dbo.Company
ORDER BY AnnualIncome/EmployeeCount DESC

--1.18
SELECT *
FROM Shop.dbo.Company
WHERE 
	Active = 1 
	AND CityId IN (1,2) 
	AND (EmployeeCount < 500 
	OR EmployeeCount > 1500)

--1.19
SELECT *
FROM Shop.dbo.Company
WHERE PostCode NOT LIKE '__-___'

--1.20
SELECT TOP (10) PERCENT *
FROM Shop.dbo.Company
ORDER BY EmployeeCount DESC

--1.21
SELECT DISTINCT 
	Street
FROM Shop.dbo.Company

--1.22
SELECT 
	Name, 
	CityId, 
	AnnualIncome, 
	EmployeeCount
FROM Shop.dbo.Company
WHERE CityId IS NOT NULL
ORDER BY 
	CityId, 
	AnnualIncome DESC, 
	EmployeeCount DESC

--1.23
SELECT *
FROM Shop.dbo.Company
WHERE 
	StartDate IS NULL 
	OR StartDate >= '01-01-2000'

--1.24A
SELECT *
FROM Shop.dbo.Company
WHERE 
	EmployeeCount >= 1000 
	AND EmployeeCount <= 1500

--1.24B
SELECT *
FROM Shop.dbo.Company
WHERE EmployeeCount BETWEEN 1000 AND 1500

--1.25A
SELECT *
FROM Shop.dbo.Company
WHERE 
	Active = 1 
	AND Name <> 'Casio' 
	AND Name <> 'Yamaha'

--1.25B
SELECT *
FROM Shop.dbo.Company
WHERE 
	Active = 1 
	AND Name NOT IN ('Casio','Yamaha')