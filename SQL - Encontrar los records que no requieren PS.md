## Encontrar los records que no requieren PS_ (Oracle)

```sql
SELECT * 
FROM PS_DATA_REC_VW A
WHERE PSARCH_RECCOUNT in 
        (SELECT recname 
         FROM PSRECDEFN 
         WHERE SQLTABLENAME = A.PSARCH_RECCOUNT);
 ```