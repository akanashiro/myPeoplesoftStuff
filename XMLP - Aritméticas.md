# Aritméticas

## Manejo de variables para hacer totales
_Crear antes del each-group (for)_
```xslt
<?xdoxslt:set_variable($_XDOCTX, 'x', 0)?>
```

_dentro del for_
```xslt
<?xdoxslt:set_variable($_XDOCTX, 'x', xdoxslt:get_variable($_XDOCTX,'x') + (current-group()/fld_QQ_ADQUISIC_AMT))?>
```

_al final del for_
```xslt
<?xdoxslt:get_variable($_XDOCTX, 'x')?>
```

## Totalizador de página (no sirve para salida de Excel)
_Va al lado del campo_
```xslt
<?fld_CALC_RSLT_VAL?><?add-page-total:subtotal;'fld_CALC_RSLT_VAL'?>
```

_Fuera del for_
```xslt
<?show-page-total:subtotal;'999G990'?>
```

## Valores absolutos
```xslt
<?xdoxslt:abs(xdoxslt:to_number(D_LINE_UNIT_SELLING_PRICE))?>
```