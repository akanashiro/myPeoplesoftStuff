## Cambiar el tipo de origen de datos de XML Publisher
*Si nos mandamos la cagada de haber creado un origen de datos que después no nos sirve, podemos cambiar el tipo de origen de la siguiente manera:*

```sql
update PSXPDATASRC set DS_TYPE = 'XML' where DS_ID = '<Data Source>';
update PSXPRPTDEFN set DS_TYPE = 'XML' where DS_ID = '<Data Source>';
update PSXPSCHEMAFLMN set DS_TYPE = 'XML' where DS_ID = '<Data Source>';
update PSXPSMPLDTMN set DS_TYPE = 'XML' where DS_ID = '<Data Source>';
```