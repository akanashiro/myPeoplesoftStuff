**Microsoft SQL Server**

```sql
SELECT TOP 10 column
FROM table
```

**PostgreSQL and MySQL**

```sql
SELECT column FROM table
LIMIT 10
```

**Oracle**

```sql
SELECT column FROM table
WHERE ROWNUM <= 10
```

**Sybase**

```sql
SET rowcount 10
SELECT column FROM table
```

**Firebird**

```sql
SELECT FIRST 10 column 
FROM table
```