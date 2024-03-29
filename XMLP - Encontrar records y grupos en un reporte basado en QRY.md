# Encontrar records/access groups para un BI Publisher basado en PSQUERY

_(1) DS_TYPE should be "QRY", and DS_ID is Data Source_

```sql
SELECT DS_TYPE, DS_ID
FROM PSXPRPTDEFN
WHERE REPORT_DEFN_ID = '<REPORT NAME>';
```

_(2) Returns data source_
```sql
SELECT *
FROM PSXPDATASRC
WHERE DS_ID = '<DS_ID>';
```

_(3) Returns query definition_
```sql
SELECT * 
FROM PSQRYDEFN 
WHERE QRYNAME = '<DS_ID>';
```

_(4) Returns RECNAME(s)_
```sql
SELECT * 
FROM PSQRYRECORD 
WHERE QRYNAME = '<DS_ID>';
```

_(5) Find Access Group(s)_
```sql
SELECT AG.TREE_NODE AS Access_Group, R.TREE_NODE as Record
  FROM PSTREENODE AG,  PSTREENODE R
 WHERE AG.TREE_NODE_TYPE = 'G'
   AND AG.TREE_NAME LIKE '<QUERY_TREE>'
   AND AG.TREE_NODE_NUM = R.PARENT_NODE_NUM
   AND R.SETID = AG.SETID
   AND R.SETCNTRLVALUE = AG.SETCNTRLVALUE
   AND R.EFFDT = AG.EFFDT                         
   AND R.TREE_NODE_TYPE = 'R'
   AND R.TREE_NODE IN ('<RECORDS FOUND IN (4)>')
   AND R.TREE_NAME = AG.TREE_NAME
   AND AG.EFFDT = (
             SELECT MAX(EFFDT)  
              FROM PSTREENODE AG1  
             WHERE AG1.SETID = AG.SETID  
               AND AG1.SETCNTRLVALUE = AG.SETCNTRLVALUE  
               AND AG1.TREE_NAME = AG.TREE_NAME  
               AND AG1.TREE_NODE_NUM = AG.TREE_NODE_NUM  
               AND AG1.TREE_NODE = AG.TREE_NODE  
               AND AG1.TREE_BRANCH = AG.TREE_BRANCH  
               AND AG1.EFFDT <= SYSDATE);
```