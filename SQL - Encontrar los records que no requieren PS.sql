/*markdown
# Encontrar los records que no requieren PS_ (Oracle)

Formateado con [SQL Notebook][def]

[def]: https://marketplace.visualstudio.com/items?itemName=cmoog.sqlnotebook
*/

SELECT * 
FROM PS_DATA_REC_VW A
WHERE PSARCH_RECCOUNT in 
        (SELECT recname 
         FROM PSRECDEFN 
         WHERE SQLTABLENAME = A.PSARCH_RECCOUNT);