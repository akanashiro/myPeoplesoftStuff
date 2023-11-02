# Sobreescribir el tipo de notación numérica en un reporte

__Una variable:__
```xslt
<?xdoxslt:xdo_format_number_l(xdoxslt:get_variable($_XDOCTX,'impTotalSolic'),'999G999D99','EN-us')?>
```

__Un campo:__
```xslt
<?xdoxslt:xdo_format_number_l(fld_col00060,'999G999D99','EN-us')?>
```