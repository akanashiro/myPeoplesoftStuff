/*markdown
# Obtener el árbol según una BUSINESS_UNIT
Formateado con [SQL Notebook][def]

[def]: https://marketplace.visualstudio.com/items?itemName=cmoog.sqlnotebook
*/

SELECT %Substring(setcntrlvalue ,1 ,5)
 , tree_name
 , setid
FROM PS_set_cntrl_tree