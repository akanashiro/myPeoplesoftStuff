/*markdown
# Retornar los primeros N registros
Formateado con [SQL Notebook][def]

[def]: https://marketplace.visualstudio.com/items?itemName=cmoog.sqlnotebook
*/

/*markdown
**Microsoft SQL Server**
*/

SELECT TOP 10 column
FROM table

/*markdown
**PostgreSQL and MySQL**
*/

SELECT column FROM table
LIMIT 10

/*markdown
**Oracle**
*/

SELECT column FROM table
WHERE ROWNUM <= 10

/*markdown
**Sybase**
*/

SET rowcount 10
SELECT column FROM table

/*markdown
**Firebird**
*/

SELECT FIRST 10 column 
FROM table