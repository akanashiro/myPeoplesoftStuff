# Ejemplo de algoritmo para separar fechas utilizando recursividad

Maybe recursion is not the most used method in a Peoplesoft implementation. In fact I had only used it once.

However, Peoplecode is capable of performing recursion, so I wrote an example.

## Ejemplo:
Imaginemos un fondo de inversión. Este cuadro del progreso del valor de nuestras cuotas desde el 15 de mayo de 2018 al 30 de diciembre del 2018 y desde el 1 de enero de 2019 al 31 de marzo de 2019.

![image01][def1]

Entonces queremos agregar más detalle para tener una visión más precisa. Es aquí donde enta la recursividad. Tenemos que agregar loas valores entre fechas.

![image02][def2]

Después de procesar la fila A, nuestra grilla debiera verse de esta forma y se procedería con la fila B.

![image03][def3]

Después de procesar la fila B, entonces la línea 3 es dividida y la fila B es insertada.

![image04][def5]

Entonces la última fila es evaluada

![image05][def6]

### Algoritmo:

**Precondiciones:**

- Los rowsets debieran estar ordenados por fecha.
- La fecha final deberá existir en cada fila. No puede estar vacía.

La clase _Mutual Funds_ luciría de la siguiente manera:

App Package MUTUAL_FUND:
\>> Class MutualFund
**Properties:**
* ID FONDO MUTUO
* Risk
* BeginDate
* EndDate
* ShareAmt

**Methods:**
* getBeginDate()
* getEndDate()
* getShareAmt()

Entonces el método o función  _splitDates()_ sería de la siguiente manera

```
function splitDates(&ArrayFund of MUTUAL_FUND:MutualFund, &oMutualFund, &oNewMutualFund)
    /* &oMutualFund = current row of original Mutual Fund */
    /* &oNewMutuallFund = new row of Mutual Fund */
    /*

    Local MUTUAL_FUND:MutualFund &oInsMutualFund;

    /*  Scenario: dates don not overlap
        Current Row: Start Date 21/11/2018 - End Date: 30/12/2018
        New Row: Start Date 30/10/2018 - End Date : 20/11/2018
    */    
    if &oMutualFund.getBeginDate() > &oNewMutualFund.getEndDate() then
        &ArrayFund.Push(&oNewMutualFund)
    else    
        if &oMutualFund.getBeginDate() = &oNewMutualFund.getBeginDate then
            /*  Scenario: both beginning dates are the same or new row
                date range is wider than current row date range
                Current Row: Start Date 21/11/2018 - End Date: 22/11/2018
                New Row: Start Date 21/11/2018 - End Date : 23/11/2018
            */
            if &oMutualFund.getEndDate() <= &oNewMutualFund.getEndDate then
                &oMutualFund = &oNewMutualFund
                /* ends here */
            else
                /* Scenario:
                    Current Row: Start Date 21/11/2018 - End Date: 23/11/2018
                    New Row: Start Date 21/11/2018 - End Date : 22/11/2018
                */
                if &oMutualFund.getEndDate() > &oNewMutualFund.getEndDate then
                
                    Create &oInsMutualFund with new dates and previous ShareAmt
                    &oInsMutualFund.BeginDate = &oNewMutualFund.getEndDate + 1    /* 23/11/2018 */
                    &oInsMutualFund.EndDate = &oMutualFund.getEndDate            /* 23/11/2018 */
                    &oInsMutualFund.ShareAmt = &oMutualFund.getShareAmt
                    ArrayFund.Push(&oInsMutualFund)
                    
                    &oMutualFund = &oNewMutualFund
                end-if;
        else
            /* Start Date 15/05/2018 - Start Date 01/11/2018 */    
            if &oMutualFund.getBeginDate() < &oNewMutualFund.getBeginDate() then
                /* End Date 30/12/2018 - End Date 20/11/2018 */
                if &oMutualFund.getEndDate() > &oNewMutualFund.getEndDate() then
                    Create &oInsMutualFund
                    &oInsMutualFund.BeginDate = &oNewMutualFund.getBeginDate()     /* 01/11/2018 */
                    &oInsMutualFund.EndDate = &oMutualFund.getEndDate()            /* 30/12/2018 */
                    &oInsMutualFund.ShareAmt = &oMutualFund.getShareAmt
                    &ArrayFund.Push(oInsMutualFund)
                    
                    &oMutualFund.BeginDate remains unchanged                        /* 15/05/2018 */
                    &oMutualFund.EndDate = &oNewMutualFund.getBeginDate - 1 day    /* 31/10/2018 */
                    &oMutualFund.ShareAmt remains unchanged
                    
                    Split(&ArrayFund, &oInsMutualFund, &oNewMutualFund)
                else
                    if oMutualFund.getEndDate() = oNewMutualFund.getEndDate() then
                        &oMutualFund.BeginDate remains unchanged
                        &oMutualFund.EndDate = oMutualFund.getEndDate - 1 day
                        &oMutualFund.ShareAmt remains unchanged
                        
                        &ArrayFund.Push(&oNewMutualFund)
                    end-if;
                end-if;
            else
                /* Start Date 01/11/2018 - Start Date 30/10/2018 */
                if &oMutualFund.getBeginDate() > &oNewMutualFund.getBeginDate() then
                    /* End Date 30/12/2018 - End Date 20/11/2018 */
                    if &oMutualFund.getEndDate() > &oNewMutualFund.getEndDate() then
                        Create &oInsMutualFund
                        &oInsMutualFund.BeginDate = &oNewMutualFund.getEndDate()   /* 20/11/2018 */
                        &oInsMutualFund.EndDate = &oMutualFund.getEndDate()         /* 30/12/2018 */
                        
                        &ArrayFund.Push(&oInsMutualFund)
                        
                        &oMutualFund.BeginDate = &oNewMutualFund.getBeginDate    /* 30/10/2018 */
                        &oMutualFund.EndDate = &oNewMutualFund.getEndDate() - 1  /* 19/11/2018 */
                        &oMutualFund.ShareAmt = &oNewMutualFund.getShareAmt()
                    else
                        /* End Date 29/11/2018 - End Date 30/11/2018 */
                        /* When the row includes the current row  */
                        if &oMutualFund.getEndDate() < &oNewMutualFund.getEndDate() then
                            &oMutualFund = &oNewMutualFund
                        end-if;
                    end-if;
                end-if;
            end-if;
        end-if;
    end-if;
```

Los resultados se insertarían en un *array* y esa información posteriormente podría manipularse para ser extraída y copiada a un rowset.

```
/* Create an instance of MUTUAL_FUND:MutualFund and put in an array of MUTUAL_FUND:MutualFund */

&oCurrentObject = create MUTUAL_FUND:MutualFund()
&arrayFunds[1] = &oCurrentObject;

/* Create a rowset that contains rows A, B, C called rowsToBeInserted */

For 1 to rowsToBeInserted.ActiveRowCount
   
    &oNewMutualFund  ​= create MUTUAL_FUND:MutualFund()
    /* assign all row data to oNewMutualFund and then call splitDates */
   
    Split(&arrayFunds, &oCurrentObject, &oNewMutualFund)

End-For;
```

[def1]: ./images/recursion/recursion_01.png
[def2]: ./images/recursion/recursion_02.png
[def3]: ./images/recursion/recursion_03.png
[def5]: ./images/recursion/recursion_04.png
[def6]: ./images/recursion/recursion_05.png