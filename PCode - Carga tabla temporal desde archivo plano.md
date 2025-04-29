```
Local File &FILE;
Local Record &REC;
Local Rowset &FRS;

&Path = HA_RUN_PORC_AET.PATHNAME.Value;
&file_log = GetFile(&Path | "_" | %Date | ".log", "W", %FilePath_Absolute);

&file_log.WriteLine("Inicio Lectura del Archivo");
MessageBox(0, "", 0, 0, "Inicio Lectura del Archivo");

&cant = 0;

If None(&Path) Then
   Error ("No existe la ruta de archivo.");
   Exit (1);
End-If;


&FILE = GetFile(&Path, "R", %FilePath_Absolute);
&REC = CreateRecord(Record.HA_DEPT_POR_TMP);

&SQL = CreateSQL("%Insert(:1)");

If Not &FILE.IsOpen Then
   Error ("TEST: failed file open");
Else
   If Not &FILE.SetFileLayout(FileLayout.HA_APRORR_VAR_FL) Then
  	Error ("TEST: failed SetFilelayout");
   Else
 	 
  	&FRS = &FILE.ReadRowset();
 	 
  	While &FRS <> Null
     	&FRS.GetRow(1).HA_DEPT_POR_WRK.CopyFieldsTo(&REC);
     	&REC.PROCESS_INSTANCE.Value = HA_RUN_PORC_AET.PROCESS_INSTANCE.Value;
     	&SQL.execute(&REC);
    	 
     	&cant = &cant + 1;
     	&FRS = &FILE.ReadRowset();
  	End-While;
 	 
   End-If;
   &FILE.Close();
End-If;

&file_log.WriteLine("Fin Lectura del Archivo. " | &cant | " líneas procesadas.");
MessageBox(0, "", 0, 0, "Fin Lectura del Archivo. " | &cant | " líneas procesadas.");
&file_log.Close();
```
