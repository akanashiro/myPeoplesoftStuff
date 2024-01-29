## Obtener el árbol según una BUSINESS_UNIT

```SQL
SELECT %Substring(setcntrlvalue ,1 ,5)
 , tree_name
 , setid
FROM PS_set_cntrl_tree
```