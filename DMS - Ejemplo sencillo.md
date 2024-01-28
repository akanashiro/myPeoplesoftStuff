**Export Script**

```sql
-- REF0001 DD/MM/YYYY Author
-- Brief explanation of what is being exported

set log C:\\REF0001\_EXPORT.log;
set output C:\\REF0001.dat;

export TABLE_NAME;
```

 
**Import Script**
```sql
-- REF0001 DD/MM/YYYY Author

-- Brief explanation of what is being imported

set log C:\\REF0001\_IMPORT.log;
set input C:\\REF0001.dat;

import TABLE_NAME;
```