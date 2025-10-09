USE AdventureWorksDW2019;
-- Lisame dbo.DimEmployee tabelile uue veeru Salary (int t��biga)
ALTER TABLE dbo.DimEmployee ADD Salary INT;
-- Kuvame veerud EmployeeKey, FirstName, LastName ja Salary tabelist dbo.DimEmployee
SELECT EmployeeKey, FirstName, LastName, Salary FROM dbo.DimEmployee;
-- Otsime t��tajaid, kelle palk on diamasoonis 5000 kuni 7000
SELECT * FROM dbo.DimEmployee
WHERE Salary > 5000 AND Salary < 7000;
