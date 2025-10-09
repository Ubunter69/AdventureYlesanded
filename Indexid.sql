USE AdventureWorksDW2019;
-- Lisame dbo.DimEmployee tabelile uue veeru Salary (int tüübiga)
ALTER TABLE dbo.DimEmployee ADD Salary INT;
-- Kuvame veerud EmployeeKey, FirstName, LastName ja Salary tabelist dbo.DimEmployee
SELECT EmployeeKey, FirstName, LastName, Salary FROM dbo.DimEmployee;
-- Otsime töötajaid, kelle palk on diamasoonis 5000 kuni 7000
SELECT * FROM dbo.DimEmployee
WHERE Salary > 5000 AND Salary < 7000;

-- Loome indeksi veerule Salary, et parandada päringute jõudlust
CREATE INDEX IX_DimEmployee_Salary
ON dbo.DimEmployee (Salary ASC);

-- Käivitame sama päringu uuesti, et hinnata indeksi mõju
SELECT * FROM dbo.DimEmployee
WHERE Salary > 5000 AND Salary < 7000;


-- Näitame dbo.DimEmployee tabeli indeksite infot
EXEC sp_helpindex 'dbo.DimEmployee';

-- Kustutame loodud indeksi dbo.DimEmployee tabelilt
DROP INDEX dbo.DimEmployee.IX_DimEmployee_Salary;
