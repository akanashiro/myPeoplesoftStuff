It is sometimes very useful to be able to un-finalize a pay period/Calendar Group while testing and/or debugging.  However, there is no online functionality to enable this.

The following SQL Script can be used to reset a Calendar Group.  After running the script it is important that you run the “Cancel” process using the online “Calculate Absence and Payroll” component.

Whilst I have never had an issue with this process, I would not recommend applying it to a production environment.  And as usual: I take no responsibility for any issues resulting from the use of this process 

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