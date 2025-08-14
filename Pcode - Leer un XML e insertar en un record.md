Lee un XML y parsea por etiqueta.
```
Local XmlDoc &inXMLDoc;
Local array of XmlNode &xmlNodeEmpleado;
Local Record &recInsert;

&inXMLDoc = CreateXmlDoc("");
&ret = &inXMLDoc.ParseXmlFromURL(&strBasePath | &strDumpFile);

If &inXMLDoc.IsNull Then
   &fileLog.WriteLine("Error al cargar el archivo XML.");
Else
   &fileLog.WriteLine("XML leído.");
End-If;

&xmlNodeEmpleado = &inXMLDoc.DocumentElement.GetElementsByTagName("<NODO_RAIZ>");

For &i = 1 To &xmlNodeEmpleado.Len
   
   &recInsert = CreateRecord(Record.TABLA_EMPL);
      
   &recInsert.EMPLID.Value = &xmlNodeEmpleado [&i].GetElementsByTagName("<NRO_EMPL>")[1].NodeValue; 
   &recInsert.NAME_DISPLAY.Value = &xmlNodeEmpleado [&i].GetElementsByTagName("<NOMBRE>")[1].NodeValue  | " " | &xmlNodeEmpleado [&i].GetElementsByTagName("<SEGNOMBRE>")[1].NodeValue;
   
   &recInsert.Insert();
      
End-For;
```