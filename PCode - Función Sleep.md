```
/* Función sleep para ejecutar instrucciones con un determinado delay */
Function Sleep()
    &current_time = %Datetime;
    &delay_time = AddToDateTime(&current_time, 0, 0, 0, 0, 1, 0);

    While True
        If %Datetime > &delay_time Then
            Break;
        End-If;
    End-While
End-Function;
```
