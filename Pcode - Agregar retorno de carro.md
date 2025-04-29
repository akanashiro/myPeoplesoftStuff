```c++
/* Ejemplo */
&string1 = "Emplid xyz123 ingresó a la compañía el 01/01/2008";
&string2 = "Emplid xyz123 fue finiquitado el 01/02/2010";

/* Para obtener el siguiente resultado impreso:

    Emplid xyz123 ingresó a la compañía el 01/01/2008
    Emplid xyz123 fue finiquitado el 01/02/2010

Se debe colocar retorno de carro CR (retorno de carro)/LF(nueva línea) entre las dos cadenas de texto
Char 10 = LF (nueva línea)
char 13 = CR (retorno de carro)
*/

&mailString = &string1 | char(10) | char (13) |&string2;


/* =========================== */
/* Agregar una línea al final de un archivo */

Local File &File;
&File = GetFile("newfile.txt", "W", "A", %FilePath_Relative);
&File.SetRecTerminator(Char(13));
&File.WriteLine("hello");
&File.Close();
```

[Código ASCII](https://elcodigoascii.com.ar/caracteres-ascii-control/enter-retorno-carro-codigo-ascii-13.html)