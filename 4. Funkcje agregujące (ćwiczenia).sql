--4.1
SELECT 
	COUNT (*) AS LiczbaPracowników
FROM Shop.dbo.Employee

--4.2
SELECT 
	COUNT (*) AS LiczbaPracowników
FROM Shop.dbo.Employee
WHERE SecondName IS NULL

--4.3
SELECT 
	COUNT (*) AS LiczbaAktywnychPracowników
FROM Shop.dbo.Employee
WHERE Active = 1

--4.4
SELECT 
	COUNT (*) AS LiczbaPracowników
FROM Shop.dbo.Employee AS EEE
	INNER JOIN Shop.dbo.Department AS DDD ON EEE.DepartmentId=DDD.Id
WHERE 
	EEE.Active=1 
	AND DDD.Name='IT'

--4.5
SELECT 
	COUNT (*) AS LiczbaPracowników
FROM Shop.dbo.Employee AS EEE
	INNER JOIN Shop.dbo.Department AS DDD ON EEE.DepartmentId=DDD.Id
	INNER JOIN Shop.dbo.City AS CCC ON DDD.CityId=CCC.Id
WHERE CCC.Name='Warsaw'

--4.6
SELECT 
	SUM(Salary) AS SumSalary
FROM Shop.dbo.Employee
WHERE Active=1

--4.7
SELECT 
	SUM(Salary * 12) AS AnnualSumSalary
FROM Shop.dbo.Employee
WHERE Active=1

--4.8
SELECT 
	MIN(Salary) AS MinimalneZarobki
FROM Shop.dbo.Employee

--4.9
SELECT 
	MIN(LEN(FirstName)) AS NajmniejLiter
FROM Shop.dbo.Employee

--4.10
SELECT 
	SUM (DATEDIFF (year, HireDate, GETDATE())) AS SumaPrzepracowanychLat
FROM Shop.dbo.Employee
WHERE Active = 1

--4.11
SELECT 
	MAX(Salary) - MIN(Salary) AS Ró¿nicaPensji
FROM Shop.dbo.Employee

--4.12
SELECT 
	AVG (EEE.Salary) AS ŒredniaZarobków,
	MIN (EEE.Salary) AS MinimalneZarobki,
	MAX (EEE.Salary) AS MinimalneZarobki
FROM Shop.dbo.Employee AS EEE
	INNER JOIN Shop.dbo.Department AS DDD ON EEE.DepartmentId=DDD.Id
WHERE DDD.Name = 'IT'

--4.13
SELECT 
	AVG (Salary) - MIN (Salary) AS Wyrównanie
FROM Shop.dbo.Employee

--4.14
SELECT 
	AVG (DATEDIFF (year, BirthDate, GETDATE())) AS ŒredniaZarobków
FROM Shop.dbo.Employee

--4.15
SELECT 
	AVG (DATEDIFF (month, HireDate, RelieveDate)) AS ŒredniaLiczbaMiesiêcy
FROM Shop.dbo.Employee
WHERE RelieveDate IS NOT NULL

--4.16
SELECT
	MAX (BirthDate) AS NajpóŸniejszaDataUrodzin
FROM Shop.dbo.Employee

--4.17
SELECT 
	Salary, 
	COUNT (*) AS LiczbaOsób
FROM Shop.dbo.Employee
GROUP BY Salary

--4.18
SELECT 
	Salary
FROM Shop.dbo.Employee
GROUP BY Salary

--4.19
SELECT 
	DDD.Name, 
	COUNT (EEE.Id) AS LiczbaOsób
FROM Shop.dbo.Employee AS EEE
	RIGHT OUTER JOIN Shop.dbo.Department AS DDD ON EEE.DepartmentId=DDD.Id
GROUP BY DDD.Name

--4.20
SELECT 
	DDD.Name,
	COUNT (EEE.Id) AS LiczbaOsób
FROM Shop.dbo.Department AS DDD
	LEFT OUTER JOIN Shop.dbo.Employee AS EEE ON DDD.Id=EEE.DepartmentId
WHERE EEE.Salary > 1500
GROUP BY DDD.Name

--4.21
SELECT 
	DDD.Name,
	AVG (EEE.Salary) AS ŒredniaPensja
FROM Shop.dbo.Department AS DDD
	INNER JOIN Shop.dbo.Employee AS EEE ON DDD.Id=EEE.DepartmentId
GROUP BY DDD.Name
ORDER BY DDD.Name

--4.22
SELECT
	DDD.Name,
	ISNULL (SUM (Salary),'0') AS SumaWynagrodzeñ
FROM Shop.dbo.Department AS DDD
	LEFT OUTER JOIN Shop.dbo.Employee AS EEE ON DDD.Id=EEE.DepartmentId
GROUP BY DDD.Name

--4.23
SELECT TOP (1) 
	DDD.Name
FROM Shop.dbo.Department AS DDD
	INNER JOIN Shop.dbo.Employee AS EEE ON DDD.Id=EEE.DepartmentId
GROUP BY DDD.Name
ORDER BY AVG (Salary) DESC

--4.24
SELECT 
	YEAR (BirthDate) AS RokUrodzin,
	COUNT (*) AS LiczbaPracowników
FROM Shop.dbo.Employee
GROUP BY YEAR (BirthDate)

--4.25
SELECT
	SUBSTRING(FirstName,1,1) AS PierwszaLiteraImienia,
	COUNT (*) AS IloœæPracowników
FROM Shop.dbo.Employee
WHERE Active = 1
GROUP BY SUBSTRING(FirstName,1,1)

--4.26
SELECT
	DDD.Name,
	EEE.Gender,
	COUNT (*) AS LiczbaPracowników
FROM Shop.dbo.Department AS DDD
	INNER JOIN Shop.dbo.Employee AS EEE ON DDD.Id=EEE.DepartmentId
WHERE Gender IS NOT NULL
GROUP BY 
	DDD.Name, 
	EEE.Gender

--4.27
SELECT
	DDD.Name,
	AVG (EEE.Salary) AS ŒredniaPensja,
	MIN (EEE.Salary) AS MinimalnaPensja,
	MAX (EEE.Salary) AS MaksymalnaPensja
FROM Shop.dbo.Department AS DDD
	INNER JOIN Shop.dbo.Employee AS EEE ON DDD.Id=EEE.DepartmentId
GROUP BY DDD.Name

--4.28
SELECT 
	DDD.Name,
	MMM.FirstName,
	MMM.LastName,
	AVG (EEE.Salary) AS ŒredniaPensja,
	SUM (EEE.Salary) AS SumaPensji
FROM Shop.dbo.Employee AS EEE
	INNER JOIN Shop.dbo.Department AS DDD ON EEE.DepartmentId=DDD.Id
	INNER JOIN Shop.dbo.Employee AS MMM ON MMM.Id=DDD.ManagerId
WHERE MMM.Active = 1
GROUP BY 
	DDD.Name,
	MMM.FirstName, 
	MMM.LastName

--4.29
SELECT
	DDD.Name,
	AVG (EEE.Salary)
FROM Shop.dbo.Department AS DDD
	INNER JOIN Shop.dbo.Employee AS EEE ON DDD.Id=EEE.DepartmentId
WHERE Active = 1 
GROUP BY DDD.Name
HAVING AVG(EEE.Salary) > 1500
ORDER BY DDD.Name

--4.30
SELECT
	CCC.Name
FROM Shop.dbo.City AS CCC
	INNER JOIN Shop.dbo.Department AS DDD ON CCC.Id=DDD.CityId
GROUP BY CCC.Name
HAVING COUNT(*) > 1

--4.31
SELECT
	DDD.Name,
	AVG (DATEDIFF(year, EEE.BirthDate, GETDATE())) AS ŒredniWiekPracownika
FROM Shop.dbo.Employee AS EEE
	INNER JOIN Shop.dbo.Department AS DDD ON DDD.Id=EEE.DepartmentId
WHERE EEE.Active = 1
GROUP BY DDD.Name
HAVING AVG (DATEDIFF(year, EEE.BirthDate, GETDATE())) > 27