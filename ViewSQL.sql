------------------- 39. View SQL serveris---------------

-- Kuvame k�ik kirjed tabelist DimEmployee (p�hitabel)
SELECT * FROM DimEmployee;

-- Loome vaate t��tajate p�hiteabe ja osakonna nime kuvamiseks
-- Lihtsustab andmep�ringuid mitte-tehnilistele kasutajatele
CREATE VIEW vWEmployeesByDepartment
AS
SELECT EmployeeKey, FirstName, Salary, Gender, DepartmentName
FROM DimEmployee;

-- Kuvame andmed l�bi loodud vaate
SELECT * FROM vWEmployeesByDepartment;

-- Loome vaate, mis n�itab ainult IT osakonna t��tajaid
-- N�ide ridade kaupa ligip��su piirangutest
CREATE VIEW vWITDepartment_Employees
AS
SELECT EmployeeKey, FirstName, Salary, Gender, DepartmentName
FROM DimEmployee
WHERE DimEmployee.DepartmentName = 'IT';

-- Loome vaate ilma palgaandmeteta
-- N�ide veergude tasemel ligip��su piirangust
CREATE VIEW vWEmployeesNonConfidentialData
AS
SELECT EmployeeKey, FirstName, Gender, DepartmentName
FROM DimEmployee;

-- Loome vaate, mis kuvab t��tajate arvu osakonna kaupa
-- N�ide vaate kasutamisest kokkuv�tlike andmete esitamiseks
CREATE VIEW vWEmployeesCountByDepartment
AS
SELECT DepartmentName, COUNT(EmployeeKey) AS TotalEmployees
FROM DimEmployee
GROUP BY DepartmentName;
