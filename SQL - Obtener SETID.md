## Obtener SETID


**Obtener el SETID de una unidad de negocio**

```sql
SELECT A.setid
FROM ps_set_cntrl_tbl A
WHERE A.SETCNTRLVALUE = <unidad de negocio>
```
**Obtener el SETID de una unidad de negocio de GL**
```sql
SELECT A.setid
FROM PS_BUS_UNIT_GL A
WHERE A.BUSINESS_UNIT = <unidad de negocio>
```

**Obtener el SETID de un Operador**

*en HR:*
```sql
SELECT B.SETID, 
       B.REG_REGION 
FROM PSOPRDEFN A, 
     PS_OPR_DEF_TBL_HR B 
WHERE A.OPRCLASS = B.OPRCLASS 
  AND A.OPRID = <usuario>
```

*en Finanzas:*
```sql
SELECT B.SETID 
FROM PS_OPR_DEF_TBL_FS B 
WHERE B.OPRID = <usuario>
```

**Obtener el SETID a partir de un record**
```sql
SELECT RECNAME, SETID, SETCNTRLVALUE
FROM PS_SET_CNTRL_REC
WHERE SETCNTRLVALUE = <tabla>
ORDER BY SETCNTRLVALUE, RECNAME
```

**Obtener el SETID a partir de un árbol**
```sql
SELECT *
FROM PS_SET_CNTL_TREE
WHERE tree_name = <nombre de árbol>
```