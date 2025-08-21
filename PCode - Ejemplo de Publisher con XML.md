# Funciones para generar XSD, XML y Publisher
Adicionalmente este código envía por correo el PDF generado

```
import PT_MCF_MAIL:MCFOutboundEmail;
import PSXP_RPTDEFNMANAGER:*;
import PSXP_XMLGEN:RowSetDS;

Function sendReport(&strRptOutputDir_ As string, &strPDFfile_ As string)
   
   Local PT_MCF_MAIL:MCFOutboundEmail &objEmail = create PT_MCF_MAIL:MCFOutboundEmail();
   
   Local SQL &sqlEmail = CreateSQL("select emailid from %table(V92HR_HCMVS_L1) where OPRID =:1 and RUN_CNTL_ID = :2", %UserId, V92HR_HCMVS_AET.RUN_CNTL_ID.Value);
   Local string &strEmailId, &strRecipients;
   
   &strRecipients = "";
   While &sqlEmail.Fetch(&strEmailId)
      &strRecipients = &strEmailId | "; " | &strRecipients;
   End-While;
   
   If &strRecipients <> "" Then
      /* Set the email address. */
      &objEmail.Recipients = &strRecipients;
      &objEmail.Subject = "Reporte de cuadre HCM - VISMA";
      &objEmail.Text = MsgGetExplainText(28000, 1001, "message not found");
      &objEmail.ContentType = "text/html";
      
      Local string &strNombreArchivo = "Reporte de cuadre HCM-VISMA_" | %Date | ".pdf";
      
      &objEmail.AddAttachment(&strRptOutputDir_ | &strPDFfile_ | ".pdf", %FilePath_Absolute, &strNombreArchivo, &strNombreArchivo, "", "");
      
      Local integer &nbrResp = &objEmail.Send();
   End-If;
End-Function;

/* Generar archivo de schema XSD */
Function createXSD(&rsArowset As Rowset, &aBoolean_ As boolean)
   
   Local string &strXSDFile = "V92HR_HCMVIS.xsd";
   
   If &aBoolean_ = True Then
      
      
      Local PSXP_XMLGEN:RowSetDS &rds;
      
      Local File &filXSD;
      Local string &myschema;
      
      &rds = create psxp_xmlgen:RowSetDS();
      &myschema = &rds.getXSDSchema(&rsArowset);
      &filXSD = GetFile(&strXSDFile, "W", %FilePath_Relative);
      &filXSD.WriteLine(&myschema);
      &filXSD.Close();
      
   End-If;
   
End-Function;

/* Generar XML de datos */
Function generarXML(&rsArowset As Rowset, &FileXMLPath As string, &FileXMLGen As string)
   
   Local PSXP_XMLGEN:RowSetDS &rds;
   
   Local File &filTmp;
   Local string &strXML;
   
   &filTmp = GetFile(&FileXMLPath | &FileXMLGen, "W", "UTF-8", %FilePath_Absolute);
   If &filTmp.IsOpen Then
      &rds = create psxp_xmlgen:RowSetDS();
      
      &strXML = &rds.getXMLData(&rsArowset, "");
      &filTmp.WriteLine(&strXML);
      &filTmp.Close();
   End-If;
   
End-Function;


Function crearReporte(&strXMLFile_ As string)
   Local string &strFileOutput = "V92HR_HCMVIS";
   
   try
      &oRptDefn = create PSXP_RPTDEFNMANAGER:ReportDefn("V92HR_HCMVIS");
      &oRptDefn.Get();
      
      &strRptOutputDir = %FilePath;
      &strFilePath = &strRptOutputDir | &strXMLFile_;
      
      /* Carga datos */
      &oRptDefn.SetRuntimeDataXMLFile(&strFilePath);
      
      rem Warning &strFilePath;
      
      /* Seteos de reporte de reporte */
      &oRptDefn.OutDestination = &strRptOutputDir;
      
      Local string &strReportFilename = "Cuadre HCM-VISMA";
      &oRptDefn.ReportFileName = &strReportFilename;
      
      /* se especifica el destino cuando la salida es del tipo "archivo" */
      If %OutDestType = 2 Then /* archivo */
         &oRptDefn.OutDestination = &strRptOutputDir;
      End-If;
      
      /* Procesa reporte */
      &oRptDefn.ProcessReport("V92HR_HCMVIS_1", "ESP", %Date, &oRptDefn.GetOutDestFormatString(2));
      rem &oRptDefn.Publish("", "", "", GetRecord().PROCESS_INSTANCE.Value);
      
      sendReport(&strRptOutputDir, &strReportFilename);
      
   catch Exception &Err
      WriteToLog(%ApplicationLogFence_Error, &Err.ToString());
   end-try;
   
End-Function;

Function principal()
   
   Local Rowset &rsReport;
   Local Rowset &rsDif0, &rsDifFields;
   Local string &strXMLPath, &strXMLFile;
   Local number &nbrProcessInstance;
   
   try
      &strXMLPath = %FilePath;
      &strXMLFile = "V92HR_HCMVIS.xml";
      
      /* Llenar rowsets */
      &nbrProcessInstance = V92HR_HCMVS_AET.PROCESS_INSTANCE.Value;
      &rsDifFields = CreateRowset(Record.V92HR_VS_DIF1);
      &rsDif0 = CreateRowset(Record.V92HR_VS_DIF0);
      &rsReport = CreateRowset(Record.V92HR_VS_HDR, &rsDif0, &rsDifFields);
      
      &rsReport.Fill("where process_instance =:1", &nbrProcessInstance);
      &rsDif0 = &rsReport(1).GetRowset(Scroll.V92HR_VS_DIF0);
      &rsDif0.Fill("where process_instance =:1", &nbrProcessInstance);
      &rsDifFields = &rsReport(1).GetRowset(Scroll.V92HR_VS_DIF1);
      &rsDifFields.Fill("where process_instance =:1", &nbrProcessInstance);
      
      
      createXSD(&rsReport, False);
      generarXML(&rsReport, &strXMLPath, &strXMLFile);
      crearReporte(&strXMLFile);
      
      
   catch Exception &c1
      MessageBox(0, "", 0, 0, "Caught exception: " | &c1.ToString());
      
   end-try;
   
End-Function;


principal();
```