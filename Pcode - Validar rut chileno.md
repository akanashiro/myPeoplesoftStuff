```
Function validarRut(&strRut_) Returns boolean;
   
   /* Se asigna el RUT a una variable interna de trabajo */
   Local string &strRut = &strRut_;

   /* Se quitan los espacios innecesarioss */
   &strRut = LTrim(RTrim(&strRut));
   
   /* Si posee alguna línea o raya se invalida */
   If (Find("-", &strRut) <> 0) Then
  	Return False;
   End-If;

   /* El último caracter puede ser una letra, pero el resto */
   /* deben ser números, caso contrario se invalida */
   Local string &strRutNoDig = Left(&strRut, Len(&strRut) - 1);
   If Not IsDigits(&strRutNoDig) Then
  	Return False;
   End-If;
   
   /* Si el último caracter es una letra y ésta es DISTINTA */
   /* de la letra K, se invalida */
   Local string &strDigitoVer = Right(&strRut, 1);
   If Not IsDigits(&strDigitoVer) And
     	Upper(&strDigitoVer) <> "K" Then
  	Return False;
   End-If;
   
   /* Una vez validado los elementos, se procede a */
   /* determinar la veracidad del RUT ingresado */
   Local number &RETORNO = 0;
   
   &strRut = LTrim(RTrim(&strRut));
   Local number &SUMADOR = 0;
   Local string &strDigitoCheck = " ";
   Local number &nbrResto = 0;
   Local number &R0LI = 0;
   Local number &R01D = 0;
   Local number &R0LFP = 0;
   While (Len(&strRutNoDig) - &R0LI > 0)
  	If &R0LI = 6 Or
        	&R0LI = 0 Then
     	&R0LFP = 2;
  	Else
     	&R0LFP = &R0LFP + 1;
  	End-If;
  	&R01D = Len(&strRutNoDig) - &R0LI;
  	&SUMADOR = &SUMADOR + (Value(Substring(&strRutNoDig, &R01D, 1)) * &R0LFP);
  	&R0LI = &R0LI + 1;
   End-While;
   Local number &R01QQ = Int(&SUMADOR / 11);
   &nbrResto = &SUMADOR - (&R01QQ * 11);
   &nbrResto = 11 - &nbrResto;
   If &nbrResto = 11 Then
  	&strDigitoCheck = "0";
   Else
  	If &nbrResto = 10 Then
     	&strDigitoCheck = "K";
  	Else
     	&strDigitoCheck = String(&nbrResto);
  	End-If;
   End-If;
   /* Se devuelve el resultado de la comparación entre */
   /* el dig.verif. ingresado y el dig.verif. calculado */
   Return (&strDigitoVer = &strDigitoCheck);
   
End-Function;
```