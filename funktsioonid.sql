select * from DimEmployee


CREATE FUNCTION fn_ILTVF_GetEmployees()
RETURNS TABLE
AS
RETURN
(SELECT EmployeeKey, FirstName, 
        CAST(BirthDate AS DATE) AS DOB
    FROM dbo.DimEmployee
);
select * from fn_ILTVF_GetEmployees();

CREATE FUNCTION fn_MSTVF_GetEmployees()
RETURNS @Table TABLE 
(
    EmloyeeKey INT, 
    FirstName NVARCHAR(20), 
    DOB DATE
)
AS
BEGIN
    INSERT INTO @Table
    SELECT 
        EmployeeKey, 
        FirstName, 
        CAST(BirthDate AS DATE)
    FROM DimEmployee;

    RETURN;
END;

SELECT * FROM fn_MSTVF_GetEmployees();