```
/* Nombre de un Record dinámicamente */
&RECNAME = “JOB”;
&RECNAME = “RECORD.” | Upper(&RECNAME);
Local Record &rec = CreateRecord(@&RECNAME);

/* Nombre de un Field dinámicamente */
&MesssgevalueName = “&ValueFieldName”| “1”;
WinMessage(@(&MesssgevalueName),0);

/* Record.Field dinámico */
Local Field &FieldName;
Local Record &REC;

&REC = CreateRecord(Record.TEST_TBL);

For &i = 1 To &rec.activerowcount
    &REC.GetField(@(“Field.” | “STATUS” | String(&i)).Value = &i;
end-for;
```