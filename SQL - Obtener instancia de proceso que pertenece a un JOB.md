Obtener instancia del job con el meta-sql **%jobinstance**


```sql
SELECT PRCSINSTANCE   
  FROM PSPRCSRQST   
WHERE JOBINSTANCE = :1   
   AND PRCSNAME = :2
```

Ejemplo:

```c++
SQLExec(SQL.IIC_PI_PRCS_JOB_GET_SQL, &nbrJobInstance, <Nombre proceso>, &nbrProcessInstance);
```
