```
/* Deshabilitar todos los campos de la página (nivel 0) */
function disableLevel0()
    Local Rowset &RS;
    Local Row &R_LINE;
    &RS = GetLevel0();
    &R_LINE = &RS.GetRow(1);
    For &i = 1 To &R_LINE.RecordCount
    Local Record &rc_temp = &R_LINE.GetRecord(&i);
            For &j = 1 To &rc_temp.FieldCount
                &rc_temp.GetField(&j).Enabled = False;
            End-For;
    End-For;
end-function;

/* Deshabilitar todos campos de Nivel 1 y 2 de rowsets pasados por parámetro */
Function disableScrolls(&aRowset1 As string, &aRowset2 As string)
   Local Rowset &rsLevel1, &rsLevel2;
   Local Row &rowLine, &rowDistriLine;
   Local Record &recTemp1, &recTemp2;
   
   If &aRowset1 <> "" Then
  	&rsLevel1 = GetLevel0().GetRow(1).GetRowset(@("Scroll." | &aRowset1));
 	 
  	&rsLevel1.InsertEnabled = False;
  	&rsLevel1.DeleteEnabled = False;
  	For &i = 1 To &rsLevel1.RowCount
     	&rowLine = &rsLevel1(&i);
     	For &j = 1 To &rowLine.RecordCount
        	&recTemp1 = &rowLine.GetRecord(&j);
        	For &k = 1 To &recTemp1.FieldCount
           	&recTemp1.GetField(&k).Enabled = False;
        	End-For;
     	End-For;
    
     	If &aRowset2 <> "" Then
        	&rsLevel2 = &rsLevel1(&i).GetRowset(@("Scroll." | &aRowset2));
        	&rsLevel2.InsertEnabled = False;
        	&rsLevel2.DeleteEnabled = False;
        	For &l = 1 To &rsLevel2.RowCount
           	&rowDistriLine = &rsLevel2(&l);
          	 
           	For &m = 1 To &rowDistriLine.RecordCount
              	&recTemp2 = &rowDistriLine.GetRecord(&m);
              	For &k = 1 To &recTemp2.FieldCount
                 	&recTemp2.GetField(&k).Enabled = False;
              	End-For;
           	End-For;
        	End-For;
     	End-If;
  	End-For;
   End-If;
   
End-Function;
```
