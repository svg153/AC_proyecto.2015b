#!/bin/bash

#  -----------------------------------------------------------------------------
#  Titulacion:	Grado en Informatica. Plan 09.
#  Anyo:			2014-2015
#  Materia:		Arquitectura de Computadores
#  Semestre:		2 Semestre. Manana
#  Ejercicio:	Proyecto E/S Interrupciones
#  Archivo:		codigo de Pruebas.s
#  -----------------------------------------------------------------------------
#  Autores:
# 	twitter ; Apellido, Nombre ;
# 	@diegofpb ; Fernandez, Diego ;
# 	@svg153 ; Valverde, Sergio ;
#  -----------------------------------------------------------------------------

#  -----------------------------------------------------------------------------
#  Informacion del proyecto:
# 	Toda la informacion sobre este proyecto se encuentra aqui:
# 	http://www.datsi.fi.upm.es/docencia/Arquitectura_09/Proyecto_E_S
#  -----------------------------------------------------------------------------

#  -----------------------------------------------------------------------------
#  Informacion del fichero:
# 	Script que cuenta el numero de pruebas pasadas dado el fichero 
#   "corrector.txt", el cual es la copia de la salida del corrector de la web, 
#   dejando el nombre de la prueba pasada por filas en "pruebas_pasadas.txt".
#  -----------------------------------------------------------------------------

cont=0
destinoFile="pruebas_pasadas.txt"
destinoFile2="pruebas_pasadas2.txt"

# borramos el archivo que ya este creado
if [ -f "$destinoFile" ] ; then
	# if create the file
	rm "$destinoFile"
fi
touch "$destinoFile"

# borramos el archivo que ya este creado
if [ -f "$destinoFile2" ] ; then
	# if create the file
	rm "$destinoFile2"
fi
touch "$destinoFile2"


for i in {0..60..1}
	do
		
		if [ $i -lt 10 ]
			then
  				i="0"$i
  		fi
		
		p="pr"$i"es_int"

		g=$(grep -c $p corrector.txt)

		if [ $g -eq 1 ]
			then
				#echo $p | tee pruebas_pasadas.txt
#				echo $p > $destinoFile
				echo "$p" >> "$destinoFile"
				((cont++))
		fi
		
done

echo $cont
echo "$cont" >> "$destinoFile2"
cat "$destinoFile" >> "$destinoFile2"
rm "$destinoFile"
mv "$destinoFile2" "$destinoFile"

 
