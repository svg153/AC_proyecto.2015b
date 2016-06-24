AC_proyecto.2015b
=================

Pruebas del proyecto de Arquitectura de Computadores (AC) del Grado de Ingeniería Informática de la Escuela Técnica Superior de Ingenieros Informáticos (ETISIINF, antigua Facultad de Informática, FI) de la Universidad Politécnica de Madrid (UPM).

> **PRECAUCIÓN:** Puede ser que las pruebas hayan cambiado respecto a las que eran cuando se creó este fichero.

## Info
| Infomacion: |  |   
| ----------- | --------
| Titulación  | Grado de Ingeniería Informática. Plan 09.
| Año         | 2014-2015
| Materia     | Arquitectura de Computadores
| Semestre    | 2 Semestre. Mañana
| Proyecto    | Proyecto E/S Interrupciones
| Archivo     | codigo_pruebas.s

Información del proyecto:
*	Toda la información sobre este proyecto se encuentra en la [página del proyecto de la asignatura][1]

> **Nota:** Aqui teneis la [sintaxis del m68kasm para Gedit][4], para poder ver mejor el codigo.

## Autores
*	Diego Fernandez, [@diegofpb][2]
* Sergio Valverde, [@svg153][3]


## Archivos de la carpeta
* *codigo_pruebas.s*: Código con las pruebas del corrector de la asignatura.
* *cont.s*: script que cuenta las pruebas correctas pasadas por el corrector. Utiliza *corrector.txt* de entrada y da como salida el número de pruebas pasadas en pantalla *pruebas_pasadas.txt*.

## Uso de las pruebas
* Copiamos del fichero *codigo_pruebas.s* al fichero del proyecto *es_int.s*, lo siguiente:
 * Copiar la subrutina 'CheckSOL:' ya que es la que comprueba si la solución, que nosotros sabemos que tiene que salir, se corresponde con la que sale.
 * Copiar las subrutinas 'LEECAR2:' y 'ESCCAR2:' ya que las usan las pruebas para leer o escribir caracteres.
 * Copiar el conjunto de datos que se encuentran englobados entre dos comentarios de:
 ```
 * ----------------------------------------------------------> DATOS PARA SCAN
 ```
 * Copiar la prueba o pruebas que necesitemos. Teniendo en cuenta que han podido cambiar respecto a cuando se creó este fichero.
 * **CUIDADO:** con los nombres de las etiquetas, puede que *es_int.s* no compile si hay etiquetas iguales.
* En el fichero *es_int.s*, deberíamos tener una subrutina que haga de 'main', normalmente llamada 'INICIO:' o 'START:', la cual se define al principio del código:
```assembly
    ORG     $0
  	DC.L    $8000           		* Pila
  	DC.L    INICIO          		* PC
```
 * Esa subrutina 'INICIO:' debería tener esta formar:
```assembly
INICIO: 
    
    BSR    INIT                   * Inicia el controlador
    
  **** MANEJADORES DE EXCEPCIONES
    MOVE.L   #BUS_ERROR,8         * Bus error handler
    MOVE.L   #ADDRESS_ER,12       * Address error handler
    MOVE.L   #ILLEGAL_IN,16       * Illegal instruction handler
    MOVE.L   #PRIV_VIOLT,32       * Privilege violation handler
    
  *** PERMITIMOS LAS INT -> DESCOMENTAR SOLO CUANDO estemos con la RTI
   * MOVE.W  #$2000,SR            * Permitir interrupciones
  
  **** Llamadas a PP del corrector
    BSR   pr45RTI    

  **** Paramos      
    BREAK
    NOP
```



[1]: http://www.datsi.fi.upm.es/docencia/Arquitectura_09/Proyecto_E_S
[2]: http://diegofpb.no-ip.org/
[3]: https://twitter.com/svg153
[4]: https://github.com/svg153/m68kasm-syntax
