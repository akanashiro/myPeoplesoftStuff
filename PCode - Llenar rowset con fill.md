# PCode - Llenar rowset con fill
Dado el siguiente rowset

```
+ Level 0: Cabecera
  - Level 1: Empleados
  	- Level 2: Detalle Empleados
  - Level 1: Total
```

El peoplecode para llenar este rowset es el siguiente:

```
Local Rowset &totalGeneral = CreateRowset(Record.TOTALES);
Local Rowset &empleadoDetalle = CreateRowset(Record.DETALLE);
Local Rowset &empleadoLinea = CreateRowset(Record.EMPLEADO, &empleadoDetalle);
Local Rowset &hdrs = CreateRowset(Record.CABECERA, &empleadoLinea, &totalGeneral);

&hdrs.Fill("where process_instance = :1", &instanciaProc);


For &i = 1 To &hdrs.ActiveRowCount
   
   &setID = &hdrs(&i).GPCL_LHDR_TAO.SETID.Value;
   &company = &hdrs(&i).CABECERA.COMPANY.Value;
   &calRunID = &hdrs(&i).CABECERA.CAL_RUN_ID.Value;
   &empleadoLinea = &hdrs(&i).GetRowset(Scroll.EMPLEADO);
   &empleadoLinea.Fill("WHERE  process_instance= :1 and SETID = :2 AND COMPANY = :3 AND CAL_RUN_ID = :4 ", &instanciaProc, &setID, &company, &calRunID);
   &empleadoLinea.Sort(EMPLEADO.NAME, "A", EMPLEADO.EMPLID, "A");
   For &z = 1 To &empleadoLinea.ActiveRowCount
      &EMPLID = &empleadoLinea(&z).EMPLEADO.EMPLID.Value;
      &EMPL_RCD = &empleadoLinea(&z).EMPLEADO.EMPL_RCD.Value;
      &empleadoDetalle = &empleadoLinea(&z).GetRowset(Scroll.DETALLE);
      &empleadoDetalle.Fill("WHERE  process_instance= :1 and SETID = :2 AND COMPANY = :3 AND CAL_RUN_ID = :4 AND EMPLID = :5 AND EMPL_RCD = :6", &instanciaProc, &setID, &company, &calRunID, &EMPLID, &EMPL_RCD);
      &empleadoDetalle.Sort(DETALLE.SEQNUM, "A", GPCL_LEXD_TAO.PIN_NM, "A");
   End-For;
   
   &totalGeneral = &hdrs(&i).GetRowset(Scroll.TOTALES);
   &totalGeneral.Fill("WHERE process_instance= :1 and SETID = :2 AND COMPANY = :3 AND CAL_RUN_ID = :4 ", &instanciaProc, &setID, &company, &calRunID);
End-For;
```


