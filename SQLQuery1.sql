
--funktsioonid
select * from DimEmployee;

--Tabelisisev‰‰rtusega funktsioon
CREATE FUNCTION fn_ILTVF_GetEmployees()
RETURNS TABLE
AS
RETURN(SELECT EmployeeKey, FirstName, 
CAST(BirthDate as Date) AS DOB
from dbo.DimEmployee);
--k‰ivita funktsiooni
SELECT * FROM fn_ILTVF_GetEmployees()
