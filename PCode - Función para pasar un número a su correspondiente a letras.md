```
/* Esta función es complementaria de la función num2let que es la principal y que invoca a esta.
Esta función hace el pasaje de números a letras, a aquellos importes que estén entre 0 y 999*/
Function num2letras(&importe) Returns String
 
REM 'Centena ----------------------------------------;
&centena2 = Integer(&importe / 100);
	Evaluate  &centena2
When = 0 Then &num2letras = "";
When = 1 Then &num2letras = "cien";
When = 2 Then &num2letras = "doscientos";
When = 3 Then &num2letras = "trescientos";
When = 4 Then &num2letras = "cuatrocientos";
When = 5 Then &num2letras = "quinientos";
When = 6 Then &num2letras = "seiscientos";
When = 7 Then &num2letras = "setecientos";
When = 8 Then &num2letras = "ochocientos";
When = 9 Then &num2letras = "novecientos";
End-Evaluate;
 
REM 'Decena ----------------------------------------------;
&decena2 = Integer((&importe - &centena2 * 100) / 10);
If &centena2 = 1 Then
&num2letras = &num2letras || "to";
End-If;
Evaluate  &decena2
When = 1 Then &num2letras = &num2letras || " diez";
When = 2 Then &num2letras = &num2letras || " veinte";
When = 3 Then &num2letras = &num2letras || " treinta";
When = 4 Then &num2letras = &num2letras || " cuarenta";
When = 5 Then &num2letras = &num2letras || " cincuenta";
When = 6 Then &num2letras = &num2letras || " sesenta";
When = 7 Then &num2letras = &num2letras || " setenta";
When = 8 Then &num2letras = &num2letras || " ochenta";
When = 9 Then &num2letras = &num2letras || " noventa";
End-Evaluate;
 
REM 'Unidad ----------------------------------------------;
&unidad2 = Integer((&importe - &centena2 * 100 - &decena2 * 10));
	If &decena2 = 0 Then
&num2letras = Substring(&num2letras, 1, Len(&num2letras) - 6);
Evaluate &unidad2
When = 0 Then &num2letras = &num2letras || " cero";
When = 1 Then &num2letras = &num2letras || " un";
When = 2 Then &num2letras = &num2letras || " dos";
When = 3 Then &num2letras = &num2letras || " tres";
When = 4 Then &num2letras = &num2letras || " cuatro";
When = 5 Then &num2letras = &num2letras || " cinco";
When = 6 Then &num2letras = &num2letras || " seis";
When = 7 Then &num2letras = &num2letras || " siete";
When = 8 Then &num2letras = &num2letras || " ocho";
When = 9 Then &num2letras = &num2letras || " nueve";
End-Evaluate;
End-If;
 
If &decena2 = 1 Then
&num2letras = Substring(&num2letras, 1, Len(&num2letras) - 4);
Evaluate &unidad2
When = 0 Then &num2letras = &num2letras || " diez";
When = 1 Then &num2letras = &num2letras || " once";
When = 2 Then &num2letras = &num2letras || " doce";
When = 3 Then &num2letras = &num2letras || " trece";
When = 4 Then &num2letras = &num2letras || " catorce";
When = 5 Then &num2letras = &num2letras || " quince";
When = 6 Then &num2letras = &num2letras || " diceciseis";
When = 7 Then &num2letras = &num2letras || " diecisiete";
When = 8 Then &num2letras = &num2letras || " dieciocho";
When = 9 Then &num2letras = &num2letras || " diecinueve";
End-Evaluate;
End-If;
 
	If &decena2 = 2 Then
If &unidad2 <> 0 Then
  &num2letras = substring(&num2letras, 1, Len(&num2letras) - 6);
End-If;
Evaluate &unidad2
When = 1 Then &num2letras = &num2letras || " veintiún";
When = 2 Then &num2letras = &num2letras || " veintidos";
When = 3 Then &num2letras = &num2letras || " veintitrés";
When = 4 Then &num2letras = &num2letras || " veinticuatro";
When = 5 Then &num2letras = &num2letras || " veinticinco";
When = 6 Then &num2letras = &num2letras || " veintiséis";
When = 7 Then &num2letras = &num2letras || " veintisiete";
When = 8 Then &num2letras = &num2letras || " veintiocho";
When = 9 Then &num2letras = &num2letras || " veintinueve";
End-Evaluate;
End-If;
 
If &decena2 > 2 Then
Evaluate &unidad2
When = 1 Then &num2letras = &num2letras || " y un";
When = 2 Then &num2letras = &num2letras || " y dos";
When = 3 Then &num2letras = &num2letras || " y tres";
When = 4 Then &num2letras = &num2letras || " y cuatro";
When = 5 Then &num2letras = &num2letras || " y cinco";
When = 6 Then &num2letras = &num2letras || " y seis";
When = 7 Then &num2letras = &num2letras || " y siete";
When = 8 Then &num2letras = &num2letras || " y ocho";
When = 9 Then &num2letras = &num2letras || " y nueve";
End-Evaluate;
       End-If;
 
If &importe = 100 Then
&num2letras = "cien"
      End-If;
 
 	Return &num2letras;
 End-Function;
 
 
 
/*Función principal para pasar un número a su correspondiente en letras. Esta función es complementaria de la función num2let que es la principal y que invoca a esta.
Esta función hace el pasaje de números a letras, a aquellos importes que estén entre 0 y 999*/
Function num2let(&importe as Number) Returns String
Local String &final;
 
If &importe > 999 Then
   &num2let = num2letras(Integer(&importe / 1000)) || " mil";
end-if;
 
&num2let = &num2let || num2letras(&importe - Integer(importe / 1000) * 1000) || &final;
 
If Integer(&importe) = 0 Then
&num2let = "cero"
end-If;
 
If &importe <> Integer(&importe) Then
&num2let = &num2let || ' con ' || num2letras((&importe - Integer(&importe)) * 100) || " centavos.";
End-If
 
Return &num2let;
End-Function
```
