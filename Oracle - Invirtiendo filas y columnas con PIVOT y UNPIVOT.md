# Invirtiendo filas y columnas con PIVOT y UNPIVOT

PIVOT y UNPIVOT son dos operaciones del lenguaje SQL que el servidor de base de datos Oracle ofrece desde la versión 11g.

Con PIVOT puedo transformar filas en columnas. Con UNPIVOT puedo transformar columnas en filas.


Veamos primero un ejemplo con PIVOT. Sea la siguiente tabla de ventas:

```sql
select * from ventas;

PAIS            MES  IMPORTE
-------------- ----- -------
Argentina        1      3000
Argentina        2      2300
Argentina        3      8500
Argentina        4      9000
Argentina        5      1000
Argentina        6      4500
Uruguay          1      5000
Uruguay          2      6600
Uruguay          3      1300
Uruguay          4      2400
Uruguay          5      7840
Uruguay          6      9000

12 rows selected.
```

Puedo construir la siguiente tabla utilizando la operación PIVOT:

```sql
select * from (
select pais, mes, sum(importe) imptotal from ventas group by pais, mes
)
pivot (sum(imptotal) for mes in (1, 2, 3, 4, 5, 6))
/

PAIS        1    2    3    4    5    6
--------- ---- ---- ---- ---- ---- ----
Argentina 3000 2300 8500 9000 1000 4500
Uruguay   5000 6600 1300 2400 7840 9000
```

A continuación, utilizo PIVOT para crear una tabla desnormalizada:

```sql
create table ventas_totales as (
select * from (
select pais, mes, sum(importe) imptotal from ventas group by pais, mes
)
pivot (sum(imptotal) for mes in (1, 2, 3, 4, 5, 6))
)
/

Table created.


select * from ventas_totales
2 /

PAIS         1    2    3    4    5    6
---------- ---- ---- ---- ---- ---- ----
Argentina  3000 2300 8500 9000 1000 4500
Uruguay    5000 6600 1300 2400 7840 9000
```

Ahora voy a utilizar UNPIVOT para convertir en filas las columnas de mi tabla desnormalizada:

```sql
select * from ventas_totales
unpivot (importe for mes in ("1", "2", "3", "4", "5", "6"))
/


PAIS         M IMPORTE
------------ - -------
Argentina    1   3000
Argentina    2   2300
Argentina    3   8500
Argentina    4   9000
Argentina    5   1000
Argentina    6   4500
Uruguay      1   5000
Uruguay      2   6600
Uruguay      3   1300
Uruguay      4   2400
Uruguay      5   7840
Uruguay      6   9000

12 rows selected.
```

PIVOT y UNPIVOT suelen ser consideradas operaciones complementarias. Sin embargo, UNPIVOT no es la operación inversa de PIVOT, pues no permite deshacer las agregaciones hechas por PIVOT.