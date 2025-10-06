USE AdventureWorksDW2019;

SELECT * FROM DimCustomer;
--loon protseduuri et lokaalne ajutine tabel luua
CREATE PROCEDURE spCreateLocalTempTable
AS 
BEGIN
CREATE TABLE #DimEmployee(EmployeeKey INT, FirstName NVARCHAR(20))
INSERT INTO #DimEmployee VALUES(1,'Mike')
INSERT INTO #DimEmployee VALUES(2,'John')
INSERT INTO #DimEmployee VALUES(3,'Todd')
SELECT * FROM #DimEmployee
END
-- K�ivita funktsiooni
EXEC spCreateLocalTempTable
--loon protseduuri et lokaalne ajutine tabel luua
CREATE PROCEDURE spCreateGlobalTempTable
AS 
BEGIN
    CREATE TABLE ##DimEmployee(EmployeeKey INT, FirstName NVARCHAR(20))
    INSERT INTO ##DimEmployee VALUES(1,'Mike')
    INSERT INTO ##DimEmployee VALUES(2,'John')
    INSERT INTO ##DimEmployee VALUES(3,'Todd')
    SELECT * FROM ##DimEmployee
END
EXEC spCreateLocalTempTable;
--Mitu kasutajat mitmes �henduses saavad sama nimega lokaalse ajutise tabeli luua, 
--aga globaalne peab olema unikaalse nimega. 
--Kui uurid ajutist tabelit object exploreris, 
--siis seal ei ole l�pus suvalisi numbreid tabeli nimes.


