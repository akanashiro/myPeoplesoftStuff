```
/*Genero un Rowset con la cabecera*/
&rs1 = CreateRowset(Record.CABECERA);

/*Genero un rowset con los datos de la Linea*/
&rs2 = CreateRowset(Record.LINEA);

/*Genero un rowset con la cabecera y la linea*/
&rs3 = CreateRowset(&rs1, &rs2);

/*Copio los datos a la cabecera */
&rs1.CopyTo(&rs3, Record.RECORD_ORIGEN, Record.RECORD_DESTINO_CABECERA);

/*Copio los datos de la cabecera el rowset final*/
&rs2.CopyTo(&rs3.GetRow(1).GetRowset(Scroll.RECORD_LINEA), Record.RECORD_ORIGEN, Record.RECORD_DESTINO_LINEA);
```
