```
Evaluate Record.Field /* Ejemplo Evaluate PS_JOB.HR_STATUS */
WHEN "A"
    PS_JOB.AE_SECTION.Value="VALIDALL" /* Call here which sction is required to retrieve the data */
    Break;
WHEN = "I"
    PS_JOB.AE_SECTION.Value = 'LOADDATA' /* Call here loading data sction */
    Break;
End-Evaluate;

```