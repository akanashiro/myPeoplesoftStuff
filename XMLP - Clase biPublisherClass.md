```c++
<*
publisherPackage
|---> reportStructure (class)
|---> createReport (class)
*>

/* ************************ */
/* Generate XML & XSD files */
/* ************************ */

import PSXP_XMLGEN:RowSetDS;

class reportStructure
	/* Constructor */
	method reportStructure();

	/* Generates an XSD based on a rowset */
	method generateXsdFile(&aRowset As Rowset, &anXSDfile As string);

	/* Generates an XML based on a rowset */
	method generateXmlFile(&aRowset As Rowset, &anXMLFileName As string);
end-class;

method reportStructure
end-method;

method generateXsdFile
	/+ &aRowset as Rowset, +/
	/+ &anXSDfile as String +/

	Local PSXP_XMLGEN:RowSetDS &rowsetDS;
	Local File &fileXSD;
	Local string &strSchema;

	&rowsetDS = create psxp_xmlgen:RowSetDS();
	&strSchema = &rowsetDS.getXSDSchema(&aRowset);
	&fileXSD = GetFile(&anXSDfile, "W", %FilePath_Relative);
	&fileXSD.WriteLine(&strSchema);
	&fileXSD.Close();
end-method;

method generateXmlFile
/+ &aRowset as Rowset, +/
	/+ &anXMLFileName as String +/

	Local PSXP_XMLGEN:RowSetDS &rowsetDS;
	Local File &filTmp;
	Local string &strXML;

	&filTmp = GetFile(&anXMLFileName, "W", "UTF-8", %FilePath_Absolute);
	If &filTmp.IsOpen Then
		&rowsetDS = create psxp_xmlgen:RowSetDS();

		&strXML = &rowsetDS.getXMLData(&aRowset, "");
		&filTmp.WriteLine(&strXML);
		&filTmp.Close();
	End-If;

end-method;

/* ****************** */
/* Print Report Class */
/* ****************** */

import PSXP_RPTDEFNMANAGER:ReportDefn;

class createReport
	/* constructor */
	method createReport();

	/*  Rowset-based report, triggered from an Application Engine */
	method buildRptFromAE(&aRptName As string, &aTmplName As string, &aFileOutput As string, &anXMLFileName As string, &anOutFormat as number);

	/* Rowset-based report, triggerd from a page */
	method buildRptOnLine(&aRptName As string, &aTmplName As string, &aFileOutput As string, &anXMLFileName As string, &anOutFormat as number);
end-class;

/* constructor */
method createReport
end-method;

/**************************************************************/
/* Rowset-based report, triggered from an Application Engine  */
/**************************************************************/
method buildRptFromAE
	/+ &aRptName as String, +/
	/+ &aTmplName as String, +/
	/+ &aFileOutput as String, +/
	/+ &aFileXmlName as String, +/
	/+ &anOutFormat as Number +/

	Local PSXP_RPTDEFNMANAGER:ReportDefn &oReportDefn;
	Local date &dtAsOfDate;
	Local string &strLangCD, &strOutFormat;

	/* Instanciar Reporte */
	&oReportDefn = create PSXP_RPTDEFNMANAGER:ReportDefn(&aRptName);
	&oReportDefn.Get();

	/* Idioma, fecha y formato de impresión */
	&strLangCD = %Language_User;
	&dtAsOfDate = %Date;
	rem &nbrOutFormat = %OutDestFormat;
	&strOutFormat = &oReportDefn.GetOutDestFormatString(&anOutFormat);

	&oReportDefn.UseBurstValueAsOutputFileName = True;
	&oReportDefn.SetRuntimeDataXMLFile(&aFileXmlName);
	rem &oReportDefn.OutDestination = &anXMLPath;
	&oReportDefn.ReportFileName = &aFileOutput;
	&oReportDefn.ProcessReport(&aTmplName, &strLangCD, &dtAsOfDate, &strOutFormat);

end-method;

/*********************************************/
/* Rowset-based report, triggerd from a page */
/*********************************************/
method buildRptOnLine
/+ &aRptName as String, +/
	/+ &aTmplName as String, +/
	/+ &aFileOutput as String, +/
	/+ &aFileXmlName as String, +/
	/+ &anOutFormat as Number +/

	Local PSXP_RPTDEFNMANAGER:ReportDefn &oReportDefn;
	Local string &strLangCD, &strOutFormat;
	Local date &dtAsOfDate;

	/* Instanciar Reporte */
	&oReportDefn = create PSXP_RPTDEFNMANAGER:ReportDefn(&aRptName);
	&oReportDefn.Get();

	/* Idioma, fecha y formato de impresión */
	&strLangCD = %Language_User;
	&dtAsOfDate = %Date;
	&strOutFormat = &oReportDefn.GetOutDestFormatString(&anOutFormat);

	&oReportDefn.UseBurstValueAsOutputFileName = True;
	&oReportDefn.SetRuntimeDataXMLFile(&aFileXmlName);
	rem &oReportDefn.OutDestination = &anXMLPath;
	&oReportDefn.ReportFileName = &strFileOutput;
	&oReportDefn.ProcessReport(&strTemplate, &strLangCD, &dtAsOfDate, &strOutFormat);

	/* Publicar reporte*/
	CommitWork();

	/* Mostrar salida en otra ventana */
	&oReportDefn.DisplayOutput();
end-method;
```