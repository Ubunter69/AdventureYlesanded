------------------- 39. View SQL serveris---------------

-- Kuvame kõik kirjed tabelist DimEmployee (põhitabel)
SELECT * FROM DimEmployee;

-- Loome vaate töötajate põhiteabe ja osakonna nime kuvamiseks
-- Lihtsustab andmepäringuid mitte-tehnilistele kasutajatele
CREATE VIEW vWEmployeesByDepartment
AS
SELECT EmployeeKey, FirstName, Salary, Gender, DepartmentName
FROM DimEmployee;

-- Kuvame andmed läbi loodud vaate
SELECT * FROM vWEmployeesByDepartment;

-- Loome vaate, mis näitab ainult IT osakonna töötajaid
-- Näide ridade kaupa ligipääsu piirangutest
CREATE VIEW vWITDepartment_Employees
AS
SELECT EmployeeKey, FirstName, Salary, Gender, DepartmentName
FROM DimEmployee
WHERE DimEmployee.DepartmentName = 'IT';

-- Loome vaate ilma palgaandmeteta
-- Näide veergude tasemel ligipääsu piirangust
CREATE VIEW vWEmployeesNonConfidentialData
AS
SELECT EmployeeKey, FirstName, Gender, DepartmentName
FROM DimEmployee;

-- Loome vaate, mis kuvab töötajate arvu osakonna kaupa
-- Näide vaate kasutamisest kokkuvõtlike andmete esitamiseks
CREATE VIEW vWEmployeesCountByDepartment
AS
SELECT DepartmentName, COUNT(EmployeeKey) AS TotalEmployees
FROM DimEmployee
GROUP BY DepartmentName;
