## Para calcular año, mes y día con el formato "99a, 99m, 99d"

```sql
SELECT 
	to_char(trunc(trunc(months_between(%CurrentDateIn, A.HIRE_DT))/12)) 
       || 'a ,' || 
    to_char(trunc(months_between(%CurrentDateIn, A.HIRE_DT)- trunc(trunc(months_between(%CurrentDateIn, A.HIRE_DT))/12)*12)) 
		|| 'm ,' ||
	to_char(trunc(%CurrentDateIn - add_months(A.HIRE_DT,trunc(months_between(%CurrentDateIn, A.HIRE_DT))))) 
		|| 'd '
FROM dual
```