```
/* Para saber si un peoplecode está siendo invocado desde un CI */
if %CompIntfcName = "abcdefg" then

/* Obtener ruta definida en la variable de entorno */
Getenv("PS_HOME")

/* Forzar al componente a ejecutar validaciones de campos al hacer SaveEdit 
Este método es útil en Finanzas cuando los datos fueron ingresados por algún proceso batch sin validación */
SetReEdit(True);

/* Forzar al componente a ejecutar SaveEdit */
SetComponentChanged();
```