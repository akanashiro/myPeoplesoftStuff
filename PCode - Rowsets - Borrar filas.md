```
rem Borrado de filas SIEMPRE se hace de forma descendente;
 &RS2 = GetRowset(scroll.MY_GRID);
 
 For &I = &RS2.ActiveRowCount To 1 Step -1
  If None(&CHECK_SEQ) Then
     &RS2.DeleteRow(&I);
  End-If;
 End-For;
 

rem De misma forma, el borrado de última fila del rowset que queda blanco después de una inserción;
Local Rowset &rsEmployee;
/* Assuming the grid is on Level 1 */
&rsEmployee = GetLevel0()(1).GetRowset(Scroll.EMPLOYEE);

For &I= &rsEmployee.ActiveRowCount To 1 Step -1
 If &rsEmployee(&I).EMPLOYEE.EMPLOYEE_STATUS.Value = " " Then
  &rsEmployee.DeleteRow(&I);
 End-If;
End-For;
```