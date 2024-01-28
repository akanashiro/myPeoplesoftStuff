**Advertencia: no está soportado por Oracle**

A veces es necesario reabrir (_un-finalize_) un *Período de pago/Grupo Calendario* mientras se está testeando o depurando una nómina.
Sin embargo, no existe una funcionalidad online que lo permita.

El siguiente script permite resetear un Grupo Calendario. Después de correr el script es importante y necesario cancelar el proceso que usa ese el cálculo de nómina y ausencias.

Al no ser una funcionalidad soportada por Oracle, no se puede asegurar que hubiera algún efecto colateral.
Por lo que se recomiendo no aplicarlo en Producción, a menos que sea una situación crítica en la que el cliente tome toda responsabilidad de las consecuencias.

Siempre la solución es aplicar las correcciones en la nómina del siguiente mes (corrección retroactiva o sustitución).

```sql
–Reset Seg Stat table
UPDATE PS_GP_PYE_SEG_STAT
SET PYE_CALC_STAT = ’50’
WHERE CAL_RUN_ID = :1;
/
–Reset the Calendar Group
UPDATE PS_GP_CAL_RUN 
SET RUN_FINALIZED_IND = ‘N’,
RUN_FINALIZED_TS = NULL,
RUN_OPEN_IND = ‘Y’,
PMT_SENT_IND = ‘N’,
GL_SENT_IND = ‘N’
WHERE CAL_RUN_ID = :1;
/
UPDATE PS_GP_CAL_RUN_DTL 
SET CAL_FINAL_TS = NULL
WHERE CAL_RUN_ID = :1;
/
–Reset T&L
DELETE FROM PS_TL_RUNCTL_ACDT
WHERE CAL_RUN_ID = :1;
/
–Reverse GL
DELETE FROM PS_GP_GL_DATA 
WHERE CAL_RUN_ID = :1;
/
–Reverse Payment Data
DELETE FROM PS_GP_PAYMENT
WHERE CAL_RUN_ID = :1;
/
```

[https://supportingelement.com/index.php/2011/09/21/how-to-un-finalize-a-global-payroll-calendar-group/](https://supportingelement.com/index.php/2011/09/21/how-to-un-finalize-a-global-payroll-calendar-group/)