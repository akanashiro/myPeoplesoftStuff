```
/* Poner en displayonly todas las páginas del componente */

&rec = &rs(1).GetRecord(Record.PSPNLGRPDEFN);
&rs_pnl = CreateRowset(Record.PSPNLGROUP);
&rs_pnl.Fill("WHERE PNLGRPNAME = :1 AND MARKET = :2", &pnlgroup, %Market);
Local integer &i;
Local boolean &flag = True;
For &i = 1 To &rs_pnl.ActiveRowCount
   &pnlname = &rs_pnl(&i).PSPNLGROUP.PNLNAME.Value;
   GetPage(@("PAGE." | &pnlname)).DisplayOnly = True;
End-For;
```
