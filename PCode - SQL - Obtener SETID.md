## Obtener SETID

**Obtener Setid por PeopleCode**
&str_itm_setid = GetSetId("BUSINESS_UNIT", VOUCHER.BUSINESS_UNIT, "PURCH_ITEM_ATTR", "");

```
GetSetId({FIELD.fieldname | text_fieldname}, set_ctrl_fieldvalue, {RECORD.recname | text_recname}, treename)
```

| Parameter | Description |
| --- | --- |
| fieldname | Specify the set control field name as a FIELD reference. Use this parameter (recommended) or the text\_fieldname parameter. |
| text\_fieldname | Specify the name of the set control field as a string. Use this parameter or the fieldname parameter. |
| set\_ctrl\_fieldvalue | Specify the value of the set control field as a string. |
| recname | Specify as a RECORD reference the name of the control record belonging to the record group for which you want to obtain the setID corresponding to the set control value. Use this parameter (recommended) or the text\_recname parameter. |
| text\_recname | Specify as a string the name of the control record belonging to the record group for which you want to obtain the setID corresponding to the set control field value. Use this parameter or the recname parameter. |
| treename | Specify as a string the name of the tree for which you want to obtain the setID corresponding to the set control field value. |


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