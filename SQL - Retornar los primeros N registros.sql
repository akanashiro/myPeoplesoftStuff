--Microsoft SQL Server
SELECT TOP 10 column
FROM table;

--PostgreSQL and MySQL
SELECT column FROM table
LIMIT 10;

--Oracle
SELECT column FROM table
WHERE ROWNUM <= 10;

**Sybase**
SET rowcount 10
SELECT column FROM table

--Firebird
SELECT FIRST 10 column 
FROM table;