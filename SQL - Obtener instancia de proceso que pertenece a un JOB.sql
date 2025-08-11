/*markdown
# Obtener instancia del job con el meta-sql **%jobinstance**
Formateado con [SQL Notebook][def]

[def]: https://marketplace.visualstudio.com/items?itemName=cmoog.sqlnotebook
*/

SELECT PRCSINSTANCE   
  FROM PSPRCSRQST   
WHERE JOBINSTANCE = :1   
   AND PRCSNAME = :2

/*markdown
Ejemplo:
```c++
SQLExec(SQL.IIC_PI_PRCS_JOB_GET_SQL, &nbrJobInstance, <Nombre proceso>, &nbrProcessInstance);
```
*/