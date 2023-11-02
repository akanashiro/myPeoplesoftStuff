## Condicionales

__Sintaxis xdofx__
```xslt
<?xdofx:if AMOUNT > 1000 then 'Higher'
else
if AMOUNT < 1000 then 'Lower'
else
'Equal'
end if?>
```

__Sintaxis xslt__
```xslt
<?if:xdoxslt:get_variable($_XDOCTX, 'x00') != 0?>
        <?xdoxslt:get_variable($_XDOCTX, 'x00')?>
<?end if?>
<?if: (xdoxslt:get_variable($_XDOCTX, 'x00') = 0) ?>-<?end if?>
```

## Obtener una variable segun una condición
```xslt
<?if:current-group()/fld_QQ_CATEG_RUBRO='SI'?>
<?xdoxslt:set_variable($_XDOCTX, 'VarSi', xdoxslt:get_variable($_XDOCTX, 'TotalCol'))?>
<?end-if?>
```

## Evitar un retorno de carro en un un IF

_Sentencia original:_
```xslt
<?if:number(CHANGEORDERNUMBER)!=0?>
```

_Cambiar a:_
```xslt
<?if@inlines:number(CHANGEORDERNUMBER)!=0?>
```

## Diferentes métodos para tener IF-THEN-ELSE

__Sintaxis:__
```xslt
<?xdoxslt:ifelse(condition,true,false)?>
<?xdofx: if IND=1 then 'N/A' else if IND=2 then '' else FLAG end if?>
    <?choose:?>
        <?when:IND=1?>'N/A'<?end when?>
        <?when:IND=2?><?end when?>
        <?otherwise:?><?FLAG?><?end otherwise?>
    <?end choose?>
```

_Ejemplo:_
```xslt
<?xdoxslt:ifelse(BUDGET!=0,xdoxslt:div(ACTUAL,BUDGET),'-')?>
```