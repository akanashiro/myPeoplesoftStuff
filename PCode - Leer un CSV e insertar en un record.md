Lee un archivo plano CSV y almancena cada campo en un array usando el ";" como separador.
Se lee por posición.

```
Local Record &recInsert;
Local array of string &arrFields;
Local File &fileCSV;
Local string &strNomFile = "exportacion-empleados.csv";
&fileCSV = GetFile(GetURL(URL.V92HR_RUTA_ARCHIVO_VISMA_FINCA) | &strNomFile, "r", "ANSI", %FilePath_Absolute);

&arrFields = CreateArrayRept("", 0);
While &fileCSV.ReadLine(&strParse)

         &recInsert = CreateRecord(Record.<TABLA_EMPL>);
         &arrFields = Split(&strParse, ";");        
         &recInsert.EMPLID.Value = &arrFields [1];
         &recInsert.FIRST_NAME.Value = &arrFields [2];
         &recInsert.LAST_NAME.Value = &arrFields [3];
         &recInsert.Insert();
End-While;
&fileCSV.Close();
```