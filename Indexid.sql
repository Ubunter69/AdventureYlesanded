USE AdventureWorksDW2019;
-- Lisame dbo.DimEmployee tabelile uue veeru Salary (int t��biga)
ALTER TABLE dbo.DimEmployee ADD Salary INT;
-- Kuvame veerud EmployeeKey, FirstName, LastName ja Salary tabelist dbo.DimEmployee
SELECT EmployeeKey, FirstName, LastName, Salary FROM dbo.DimEmployee;
-- Otsime t��tajaid, kelle palk on diamasoonis 5000 kuni 7000
SELECT * FROM dbo.DimEmployee
WHERE Salary > 5000 AND Salary < 7000;

-- Loome indeksi veerule Salary, et parandada p�ringute j�udlust
CREATE INDEX IX_DimEmployee_Salary
ON dbo.DimEmployee (Salary ASC);

-- K�ivitame sama p�ringu uuesti, et hinnata indeksi m�ju
SELECT * FROM dbo.DimEmployee
WHERE Salary > 5000 AND Salary < 7000;


-- N�itame dbo.DimEmployee tabeli indeksite infot
EXEC sp_helpindex 'dbo.DimEmployee';

-- Kustutame loodud indeksi dbo.DimEmployee tabelilt
DROP INDEX dbo.DimEmployee.IX_DimEmployee_Salary;

-- Loome tabeli tblEmployee t��tajate andmete salvestamiseks
CREATE TABLE tblEmployee (  
    Id int PRIMARY KEY,  
    Name varchar(50),  
    Salary int,  
    Gender varchar(10),  
    City varchar(50) 
);

-- Lisame tabelisse tblEmployee n�idisandmed t��tajate kohta
INSERT INTO tblEmployee VALUES (3,'John',4500,'Male','New York');
INSERT INTO tblEmployee VALUES (1,'Sam',2500,'Male','London');
INSERT INTO tblEmployee VALUES (4,'Sara',5500,'Female','Tokyo');
INSERT INTO tblEmployee VALUES (5,'Todd',3100,'Male','Toronto');
INSERT INTO tblEmployee VALUES (2,'Pam',6500,'Female','Sydney');

-- Eemaldame olemasoleva primaarv�tme, et saaks luua uue klastrindeksi
ALTER TABLE tblEmployee DROP CONSTRAINT PK_tblEmployee;

-- Loome klastrindeksi veergudele Gender ja Salary
CREATE CLUSTERED INDEX IX_tblEmployee_Gender_Salary
ON tblEmployee (Gender DESC, Salary ASC);

-- Loome mitteklastrindeksi veerule Name
CREATE NONCLUSTERED INDEX IX_tblEmployee_Name
ON tblEmployee(Name);

-- Kuvame tabeli andmed sorteerituna soo ja palga j�rgi
SELECT * FROM tblEmployee ORDER BY Gender DESC, Salary ASC;

-- Kuvame t��tajad, kelle palk j��b vahemikku 5000�7000
SELECT * FROM tblEmployee WHERE Salary BETWEEN 5000 AND 7000;

-------------------------
-- Loome klastrindeksi veergudele Gender (kahanev) ja Salary (kasvav)
CREATE CLUSTERED INDEX IX_DimEmployee_Gender_Salary
ON dbo.DimEmployee (Gender DESC, Salary ASC);

-- Loome mitteklastrindeksi veerule Name, et parandada otsingukiirust nime j�rgi
CREATE NONCLUSTERED INDEX IX_DimEmployee_Name
ON dbo.DimEmployee(Name);

-- Kuvame k�ik kirjed tabelist DimEmployee, sordituna soo ja palga j�rgi
SELECT * FROM dbo.DimEmployee ORDER BY Gender DESC, Salary ASC;

-- Kuvame t��tajad, kelle palk j��b vahemikku 5000�7000
SELECT * FROM dbo.DimEmployee WHERE Salary BETWEEN 5000 AND 7000;

-------------------------------------------------------------Unikaalne ja mitte unikaalne Index---------------------------------------
--Kustutame tebeli et teha sama tabeli aga natuke teiste andmega
drop table tblEmployee;
-- Loome tabeli tblEmployee t��tajate andmete salvestamiseks
CREATE TABLE [tblEmployee]
(
    [Id] int Primary Key,
    [FirstName] nvarchar(50),
    [LastName] nvarchar(50),
    [Salary] int,
    [Gender] nvarchar(10),
    [City] nvarchar(50)
);

-- Kuvame tabeli tblEmployee olemasolevad indeksid
EXECUTE sp_helpindex tblEmployee;

-- Lisame tabelisse tblEmployee n�idisandmed t��tajate kohta
INSERT INTO tblEmployee VALUES (1, 'Mike', 'Sandoz', 4500, 'Male', 'New York');
INSERT INTO tblEmployee VALUES (2, 'John', 'Menco', 2500, 'Male', 'London');

-- Loome unikaalse mitteklastrindeksi veergudele FirstName ja LastName
CREATE UNIQUE NONCLUSTERED INDEX UIX_tblEmployee_FirstName_LastName
ON tblEmployee(FirstName, LastName);


-- Lisame tabelile DimEmployee veeru City
ALTER TABLE DimEmployee 
ADD City VARCHAR(50);

-- Lisame veerule City unikaalse piirangu (loob taga unikaalse mitteklastrindeksi)
ALTER TABLE DimEmployee 
ADD CONSTRAINT UQ_tblEmployee_City 
UNIQUE NONCLUSTERED (City);

-- Loome unikaalse indeksi veerule City koos IGNORE_DUP_KEY valikuga
-- See valik v�imaldab sisestada duplikaate, mis j�etakse automaatselt t�helepanuta
CREATE UNIQUE INDEX IX_tblEmployee_City
ON DimEmployee(City)
WITH IGNORE_DUP_KEY;
-----------------indeksi plussid ja miinused------------------------
-- Loome mitteklastrindeksi veerule Salary kasvavas j�rjekorras
CREATE NONCLUSTERED INDEX IX_DimEmployee_Salary
ON DimEmployee (Salary ASC);

-- Valime k�ik t��tajad, kelle palk on vahemikus 4000�8000 (kasutades Salary indeksit)
SELECT * FROM DimEmployee WHERE Salary > 4000 AND Salary < 8000;

-- Kustutame read, kus Salary on 2500 (indeks aitab kiiremini leida)
DELETE FROM DimEmployee WHERE Salary = 2500;

-- Uuendame Salary v��rtust (n�ide s�ntaksist)
UPDATE DimEmployee SET Salary = 7500 WHERE Salary = 7000;

-- Kuvame k�ik read sorteerituna Salary j�rgi kahanevas j�rjekorras (kasutab indeksit)
SELECT * FROM DimEmployee ORDER BY Salary DESC;

-- R�hmitame t��tajad palkade j�rgi ja loendame iga palga esinemise
SELECT Salary, COUNT(Salary) AS Total
FROM DimEmployee
GROUP BY Salary;

