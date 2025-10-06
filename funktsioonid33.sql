Create Function fn_GetEmployeeNameById(@EmployeeKey int)

Returns nvarchar(20)
as
Begin
return (select FirstName from DimEmployee Where EmployeeKey = @EmployeeKey)
End

exec sp_helptext fn_GetEmployeeNameById;
-----alter funktsioon
Alter Function fn_GetEmployeeNameById(@EmployeeKey int)

Returns nvarchar(20)
With Encryption 
as
begin
Return (select FirstName from DimEmployee Where EmployeeKey = @EmployeeKey)
End

exec sp_helptext fn_GetEmployeeNameById;