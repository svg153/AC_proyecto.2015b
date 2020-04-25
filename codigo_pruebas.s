* -----------------------------------------------------------------------------
* Titulacion:	Grado en Informatica. Plan 09.
* Anyo:			2014-2015
* Materia:		Arquitectura de Computadores
* Semestre:		2 Semestre. Manana
* Ejercicio:	Proyecto E/S Interrupciones
* Archivo:		codigo de Pruebas.s
* -----------------------------------------------------------------------------
* Autores:
*	twitter ; Apellido, Nombre ;
*	@diegofpb ; Fernandez, Diego ;
*	@svg153 ; Valverde, Sergio ;
* -----------------------------------------------------------------------------

* -----------------------------------------------------------------------------
* Informacion del proyecto:
*	Toda la informacion sobre este proyecto se encuentra aqui:
*	http://www.datsi.fi.upm.es/docencia/Arquitectura_09/Proyecto_E_S
* -----------------------------------------------------------------------------

* -----------------------------------------------------------------------------
* Informacion del fichero:
*	Fichero con el codigo de las pruebas del corrector del proyecto, para poder 
*   testearlas.
* -----------------------------------------------------------------------------


********************************************************************************
* ----------------------------------------------------------------------> PPALS 	
********************************************************************************

* --------------------------------------------------------------------> CheckSOL
* 
* 
CheckSOL:
			* Comprobamos que D0 tiene el resultado correcto
			CMP.L	(PRCHAROK),D6			* Comprobamos caracteres que debemos tener.
			BEQ		BIEN					* Saltamos a BIEN.
			JMP 	MAL						* Si no, esta MAL.
BIEN:
*			EOR.L	D0,D0
			BREAK						
			RTS	

MAL:		
*			MOVE.L	#$FFFFFFFF,D0
			BREAK						
			RTS	
			
MAL2:		
*			MOVE.L	#$FFFFFFFF,D0
			BREAK						
			RTS	
* --------------------------------------------------------------------> CheckSOL


* --------------------------------------------------------------------> LEECAR2
* AUX. LEECAR2 (buffer)
*	Objetivo:
*		Leer un caracter del buffer circular designado por el parametro 
*		entrante "buffer"
*
*	Parámetros:
*		buffer
*				Se pasara en A0
*
*	Valor de retorno:
*		D0		
*				- 0 = Todo OK
*		D1		
*				- numero de 0 a 255 caracter del buffer
*
LEECAR2:
	*** NO ES UN BUFFER INTERNO

		* Limpiamos el D1
 		EOR.L		D1,D1							

		* Leemos el ASCII del Buffer pasado en A2
		MOVE.B		(A2),D1		* Extraccion de Ascii en D0. (De 0 a 255 DEC / 0 a FF HEX)
		
		* Aumentamos la dir del Buff pasado
		ADD.L		#$1,A2				
		
		* Ponemos a D0 = 0 para indicar OK
 		EOR.L		D0,D0		
		
		RTS
* --------------------------------------------------------------------> LEECAR2


* --------------------------------------------------------------------> ESCCAR2
* AUX. ESCCAR2 (buffer)
*	Objetivo:
*		Leer un caracter del buffer circular designado por el parametro 
*		entrante "buffer"
*
*	Parametros:
*		buffer
*				Se pasara en A0
*				Nos fijamos en los dos bits menos significativos 
*
*	Valor de retorno:
*		D0		
*				- 0 = Todo OK
*		D1		
*				- numero de 0 a 255 caracter del buffer
*
ESCCAR2:
	*** NO ES UN BUFFER INTERNO
		
		* Guardamos el ASCII pasado en D1 al Buffer pasado
		MOVE.B		D1,(A2)					* Inserccion del Ascii al Buffer seleccionado. (De 0 a 255)
		
		* Aumentamos la dir del Buff pasado.
		ADD.L		#$1,A2				
		
		* Ponemos a D0 = 0 para indicar OK
		EOR.L		D0,D0					
		
		RTS
* --------------------------------------------------------------------> ESCCAR2
		

*** NOTA: abecedario ASCII en Hex
* Letra 	a  b  c  d  e  f  g  h  i  j  k  l  m  n  o  p  q  r  s  t  u  v  w  x  y  z
* Hex 		61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f 70 71 72 73 74 75 76 77 78 79 7a
* 

*** Numeros: en ASCII
* 	dec 	 0   1   2   3   4   5   6   7   8   9
* 	HEX 	30	31	32	33	34	35	36	37	38	39
* 	ASCII 	48  49  50  51  52  53  54  55  56  57



* ----------------------------------------------------------> DATOS PARA SCAN
*
* Funcionamiento:
* SCILETRA: Introduce la letra desde la que quieres que copie ESCCAR [hex].
* SCFLETRA: Introduce la ultima letra que quieres que copie ESCCAR [hex].
* SCBUCSCA:	Numero de veces que quieres que se repita bucle anterior. [dec]
* SCCHARFI: Valor 0 = No quiero RC en mi linea ; 1 = Incluye un 0d al final.
* SCSPEEDR: Introduce la velocidad para las linea. [Mirar valores en tabla]
* SCSDESCR: Valor de descriptor deseado para SCAN. 0 = Linea A; 1 = Linea B.
* SCTAMMAX: Introduce el tamanyo maximo que se debe de leer de la linea incluido 0d.
* SCCHAROK:	Introduce el valor que deberia tener SCAN al final de su ejecucion.

** A continuacion se meten datos de ejemplo, que es vÃ¡lido.

*SCILETRA	EQU		$00000061		* Caracter 'a' [hex].
*SCFLETRA	EQU		$00000074		* Caracter 't' [hex].
*SCBUCSCA	EQU		25			* Repetir bucle 25 veces [dec].
*SCCHARFI	EQU		1			* Quiero que esta prueba contenga al final
								* del bucle un 0d. Indico 1 [dec].
*SCSPEEDR	EQU		%00000000		* Velocidad 50bps [bin].
*SCSDESCR	EQU		$0				* Valor 0 = Linea A [hex}.
*SCTAMMAX	EQU		$4444			* Tamanyo maximo de la linea [hex].
*SCCHAROK	EQU		$000001f5		* Valor que deberia volver SCAN [hex].

dirBUFF 	EQU		$4000           	* El BUFF que a las pruebas

SCILETRA	DC.L		$00000061		* Caracter 'a' [hex].
SCFLETRA	DC.L		$00000074		* Caracter 't' [hex].
SCBUCSCA	DC.L		25			* Repetir bucle 25 veces [dec].
SCCHARFI	DC.L		1			* Quiero que esta prueba contenga al final
								* del bucle un 0d. Indico 1 [dec].
SCLinCFI	DC.L		1			* Quiero que esta prueba contenga al final
								* del bucle un 0d. Indico 1 [dec].
SCNLin		DC.L		0			* Numero de Lineas iguales que se quieren enviar (pr34es_int)
SCSPEEDR	DC.B		%00000000		* Velocidad 50bps [bin].
SCSDESCR	DC.L		$0			* Valor 0 = Linea A [hex}.
SCdir		DC.L		$4e20			* dir de la linea A de SCAN
SCTAMMAX	DC.L		$4444			* Tamanyo maximo de la linea [hex].
SCCHAROK	DC.L		$000001f5		* Valor que deberia volver SCAN [hex].

SCRES2L		DC.L		0			* Guardamos los result de cada linea en SCAN


*** PRINT

PRNLin		DC.L		1			* Numero de Lineas iguales que se quieren enviar (pr34es_int)
PRSDESCR	DC.L		$0			* Valor 0 = Linea A [hex}.
PRTAMMAX    	DC.L		$4444			* Tamanyo maximo de la linea [hex].
PRCHAROK	DC.L		$00000000		* Valor que deberia volver PRINT [hex].

PRRES2L		DC.L		0			* Guardamos los result de cada linea en SCAN

* ----------------------------------------------------------> DATOS PARA SCAN


* ------------------------------------------------------------------> pr23es_int	
* PPAL: pr23es_int
*
* 	Estado: PASA (local)
*
* 	Descripcion: Le pasamos tamanyo 0 para que no nos saque nada
*		SCAN - 
*
*	Salida:
*		D0 = 00000000
*
pr23es_int: 
			MOVE.W	#1,D0			* descriptor
			MOVE.W	#0,D1			* TAMANYO
			
			MOVE.W 	D1,-(A7)		* Parametro TamaÃ±o para Scan
			MOVE.W 	D0,-(A7)		* Parametro Descriptor para Scan
			MOVE.L 	#dirBUFF,-(A7)	* Parametro Buffer para Scan
			
			BSR 	SCAN
	
			CMP.L	#0,D0
			BEQ		BIEN
			JMP		MAL
* ------------------------------------------------------------------> pr23es_int 


* ------------------------------------------------------------------> pr26es_int	
* PPAL: pr26es_int
*
* 	Estado: PASA (sin RTI, local)
*
* 	Descripcion: 	
*		SCAN - PUERTO B - 20 CARACTERES 	
*		0123456789 (2 veces) + 0d (Retorno de Carro)
*		5 BytesPS velocidad de escritura de la persona en la linea
*
*	Salida:
*		D0 = 00000015
*
pr26es_int:
			MOVE.L	#2,(SCBUCSCA)			* 2 bucles
			MOVE.L	#$00000030,(SCILETRA)	* empezamos en Hex 30 = numero 0 dec
			MOVE.L	#$00000039,(SCFLETRA)	* terminamos en Hex 39 = numero 9 dec

			MOVE.L	#%00000000,(SCSPEEDR)	* Velocidad = 50 bps. (No tenemso la de 5 BPS=40bps)

			MOVE.L	#$00000015,(SCCHAROK)	* El valor de terminacion correcto

			MOVE.L	#1,(SCCHARFI)
			
			BSR		prSCes_int
			
			RTS
* pr26es_int <-----------------------------------------------------------------


* ------------------------------------------------------------------> pr27es_int	
* PPAL: pr27es_int
*
* 	Estado: haciendo
*
* 	Descripcion: 	
*		SCAN - PUERTO A - 100 CARACTERES 	
*		abcdefghijklmnopqrst (5 veces) + 0d (Retorno de Carro)
*		10 BytesPS velocidad de escritura de la persona en la linea
*
*	Salida:
*		D0 = 00000065
*
pr27es_int:
			MOVE.L	#5,(SCBUCSCA)			* 5 bucles -> 100 charts

			* No tocamos SCILETR ni SCFLETRA, ya que esta prueba se hace 
			* con los valores por defecto
		
			MOVE.L	#%00000000,(SCSPEEDR)	* Velocidad = 50 bps. (No tenemos la de 10BPS = 80bps)

			MOVE.L	#$00000065,(SCCHAROK)	* El valor de terminacion correcto

			* No tocamos SCSDESCR ni SCdir por que es el puerto A que es el de por defecto
			
			BSR		prSCes_int
			
			RTS
* pr27es_int <-----------------------------------------------------------------


pr27RTI:
			MOVE.L	#$00000065,(SCCHAROK)	* El valor de terminacion correcto

			* Esperamos para escribir por la linea A
			BREAK

			* una vez que la RTI ya haya metido todos los caracteres de la linea en el buffer de la linea A pasamos a llamar a SCAN

			MOVE.L	#0,(SCSDESCR)			* Descriptor de la linea A

			JMP		prSCRTI
			
			RTS


* ------------------------------------------------------------------> pr28es_int	
* PPAL: pr28es_int
*
* 	Descripcion: 	
*		SCAN - PUERTO B - 200 CARACTERES 	
*		abcdefghijklmnopqrst (10 VECES) + 0d (Retorno de Carro)
*		50 BPS velocidad de escritura de la persona en la linea
*
*	Salida:
*		D0 = 000000c9
*
pr28RTI:
			MOVE.L	#$000000c9,(SCCHAROK)	* El valor de terminacion correcto
*			MOVE.L	#$0000003,(SCCHAROK)	* El valor de terminacion temporal para no poner tantas por la linea
			
			* Esperamos para escribir por la linea B
			BREAK

			* una vez que la RTI ya haya metido todos los caracteres de la linea en el buffer de la linea A pasamos a llamar a SCAN

			MOVE.L	#1,(SCSDESCR)			* Descriptor de la linea B

			JMP		prSCRTI
			
			RTS


* pr28es_int <-----------------------------------------------------------------



* ------------------------------------------------------------------> pr29es_int	
* PPAL: pr29es_int
*
* 	Descripcion: 	
*		SCAN - PUERTO A - 500 CARACTERES 	
*		abcdefghijklmnopqrst (25 VECES) + 0d (Retorno de Carro)
*		50 BPS
*
*	Salida:
*		D0 = 000001f5
*
pr29es_int:
			MOVE.L	#1,D7				* CONTADOR [HASTA 25 INCLUIDO]
			MOVE.L	#$00000074,D3		* ULTIMO CARACTER A METER [T]
			
			MOVE.B  #%00000000,CSRA     * Velocidad = 50 bps.
    		MOVE.B  #%00000000,CSRB     * Velocidad = 50 bps.


pr29INI:
		
			MOVE.L	#$00000061,D1			* PRIMER CARACTER A METER [a]
	
pr29BUC:		
		
			MOVE.L	#$0,D0					* BUFFER PARA METER DATOS [PUERTO A]	
			
			MOVEM.L	A0-A6/D1-D7,-(A7)		* GUARDAMOS REGISTROS EN PILA EXCEPTO D0			
			BSR		ESCCAR					* LLAMAMOS A ESCCAR CON 
			MOVEM.L	(A7)+,A0-A6/D1-D7	    * RESTAURAMOS REGISTROS EXCEPTO D0		

			CMP.L	#$FFFFFFFF,D0			* VERIFICAMOS QUE ESCCAR NO FALLA.
			BEQ		MAL				* SALTAMOS A ESCFalla.

			CMP.L	D3,D1					* COMPARAMOS SI D1 ES D3 [T]. 
											* SI LO ES ENTONCES AUMENTO CONT D7.
			BEQ		pr29D7A1				* AUMENTAMOS 1 EN D7	

			ADD.L	#1,D1
			JMP		pr29BUC		

pr29D7A1:	

			CMP.L	#25,D7					* SI D7 ES 25. FIN, METO D0 Y OLE.
			BEQ		pr29SUM0

			ADD.L	#1,D7
			JMP		pr29INI

pr29SUM0:
		
			MOVE.L	#$0000000d,D1			* PRIMER CARACTER A METER [a]
			MOVEM.L	A0-A6/D1-D7,-(A7)		* GUARDAMOS REGISTROS EN PILA EXCEPTO D0			
			BSR		ESCCAR					* LLAMAMOS A ESCCAR CON D0.
			MOVEM.L	(A7)+,A0-A6/D1-D7	    * RESTAURAMOS REGISTROS EXCEPTO D0		

			CMP.L	#$FFFFFFFF,D0			* VERIFICAMOS QUE ESCCAR NO FALLA.
			BEQ		MAL						* SALTAMOS A ESCFalla.
			
pr29SCAN:
            
      	MOVE.B          #%11001100,CSRB     * Velocidad = 38400 bps.
      	MOVE.B          #%11001100,CSRA     * Velocidad = 38400 bps.

		MOVE.L	#$0,D0			* descriptor
		MOVE.L	#$4444,D1		* TAMANYO

		MOVE.W 	D1,-(A7)		* Parametro TamaÃ±o para Scan
		MOVE.W 	D0,-(A7)		* Parametro Descriptor para Scan
		MOVE.L 	#dirBUFF,-(A7)	* Parametro Buffer para Scan

		BSR 	SCAN

		CMP.L	#$000001f5,D0
		BEQ		BIEN
		JMP 	MAL



* Probamos con la RTI
pr29RTI:
			MOVE.L	#$000001f5,(SCCHAROK)	* El valor de terminacion correcto
			
			* Esperamos para escribir por la linea B
			BREAK

			* una vez que la RTI ya haya metido todos los caracteres de la linea en el buffer de la linea A pasamos a llamar a SCAN

			MOVE.L	#0,(SCSDESCR)			* Descriptor de la linea A

			JMP		prSCRTI
			
			RTS


* pr29es_int <-----------------------------------------------------------------

* ------------------------------------------------------------------> pr30es_int	
* PPAL: pr30es_int
*
* 	Descripcion: 
*		SCAN - PUERTO A - 1 linea de 1000 CARACTERES 	
*		abcdefghijklmnopqrst (50 VECES)
*		200 BPS
*
*	Salida:
*		D0 = 000003e9
*
pr30es_int:
		MOVE.L	#50,(SCBUCSCA)
		MOVE.L	#$000003e9,(SCCHAROK)
		
		BSR		prSCes_int

		RTS
* -----------------------------------------------------------------> pr30es_int



* ------------------------------------------------------------------> pr32es_int	
* PPAL: pr32es_int
*
* 	Descripcion: 	
*		SCAN - PUERTO B - 2 Lineas - 20 Charts (cada una)
*		abcdefghijklmnopqrst (1 vez) + 0d (Retorno de Carro) - 2 veces todo
*		500 BPS velocidad de escritura de la persona en la linea
*
*	Salida:
*		D0 = 000000c9
*
pr32RTI:
			
			MOVE.L	#$0000002a,(SCCHAROK)	* El valor de terminacion correcto

			* Esperamos para escribir por la linea A
			BREAK

			* una vez que la RTI ya haya metido todos los caracteres de la linea en el buffer de la linea A pasamos a llamar a SCAN

			MOVE.L	#1,(SCSDESCR)			* Descriptor del puerto o linea B
			
			* decimos que son 2 lineas
			MOVE.L	#2,(SCNLin)				* Como son dos lienas ponemos un 2
											* hara 2 SCAN y sumara los resulta

			JMP		prSCRTI2L
			
			
			RTS
* ------------------------------------------------------------------> pr32es_int	




* ------------------------------------------------------------------> pr34es_int	
* PPAL: pr34es_int
*
* 	Descripcion: 	
*		SCAN - PUERTO A - 2 Lineas - 1000 Charts (cada una)
*		abcdefghijklmnopqrst (50 vez) + 0d (Retorno de Carro) - 2 veces todo
*		1000 BPS velocidad de escritura de la persona en la linea
*
*	Salida:
*		D0 = 000007d2
*
pr34es_int:
		MOVE.L	#50,(SCBUCSCA)
		MOVE.L	#$000007d2,(SCCHAROK)

		MOVE.L	#1,(SCCHARFI)
		MOVE.L	#1,(SCNLin)
		
		BSR		prSC2Les_int
		
		RTS
		

pr34RTI:
			
			MOVE.L	#$000007d2,(SCCHAROK)	* El valor de terminacion correcto

			* Esperamos para escribir por la linea A
			BREAK

			* una vez que la RTI ya haya metido todos los caracteres de la linea en el buffer de la linea A pasamos a llamar a SCAN

			MOVE.L	#0,(SCSDESCR)			* Descriptor del puerto o linea A
			
			* decimos que son 2 lineas
			MOVE.L	#2,(SCNLin)				* Como son dos lienas ponemos un 2
											* hara 2 SCAN y sumara los resulta

			JMP		prSCRTI2L
			
			
			RTS
* ------------------------------------------------------------------> pr34es_int	




* ------------------------------------------------------------------> pr35es_int	
* PPAL: pr35es_int
*
* 	Descripcion: 	
*		SCAN - PUERTO B - 2 Lineas - 1500 Charts (cada una)
*		abcdefghijklmnopqrst (75 vez) + 0d (Retorno de Carro) - 2 veces todo
*		1000 BPS velocidad de escritura de la persona en la linea
*
*	Salida:
*		D0 = 00000bba
*
pr35RTI:
			
			MOVE.L	#$00000bba,(SCCHAROK)	* El valor de terminacion correcto

			* Esperamos para escribir por la linea A
			BREAK

			* una vez que la RTI ya haya metido todos los caracteres de la linea en el buffer de la linea A pasamos a llamar a SCAN

			MOVE.L	#1,(SCSDESCR)			* Descriptor del puerto o linea B
			
			* decimos que son 2 lineas
			MOVE.L	#2,(SCNLin)				* Como son dos lienas ponemos un 2
											* hara 2 SCAN y sumara los resulta

			JMP		prSCRTI2L
			
			
			RTS
* ------------------------------------------------------------------> pr35es_int





* -----------------------------------------------------------------> pr38es_int	
* PPAL: pr38es_int
*
* 	Estado:
*		Se quedó a medias, faltan cosas... 
*
* 	Descripcion: 	
*		PRINT - PUERTO A - 1 Linea - 1 Chart
*		a + 0d (Retorno de Carro)
*		1000 BPS velocidad de escritura de la persona en la linea
*
*	Salida:
*		D0 = 00000002
*

pr38es_int:
		MOVE.L	#$0,D1
		
pr38Buc:
		MOVE.L	D1,D0
				
		BSR 	LINEA
		
		CMP.L	#$0,D0
		BNE		pr38Lin
		
		CMP.L	#$1,D1
		BEQ		pr38Inic

		ADD.L	#$1,D1
		JMP		pr38Buc
pr38Inic:
		EOR.L	D1,D1
		JMP		pr38Buc
	
pr38Lin:
		
		* D0 = tendra el nuemro de char de la linea
		* D1 = El descriptor del buffer
		
	*** Llamamos a SCAN para que nos deje la linea en dirBUFF
		MOVE.W	D0,-(A7)			* Tamano de bloque: 1 byte
		MOVE.W	D1,-(A7)			* Descriptor de linea 0: Linea A
		MOVE.L	#dirBUFF,-(A7)		* Dir de buffer 0x4000

		MOVEM.L	A0-A6/D1-D7,-(A7)		* GUARDAMOS REGISTROS EN PILA EXCEPTO D0
		BSR 	SCAN
		MOVEM.L	(A7)+,A0-A6/D1-D7	    * RESTAURAMOS REGISTROS EXCEPTO D0		
		* Cuando termine nos dejara en "dirBUFF" la linea
		* D0 = tendra el numero de char que se han podido escribir
		
	*** AHORA HACEMOS LO QUE QUERAMOS CON ESA LINEA
	
	
		
	*** Llamamos a PRINT para que saque la linea
		MOVE.W	D0,-(A7)			* Tamanyo
		MOVE.W	D1,-(A7)			* Descriptor
		MOVE.L	#dirBUFF,-(A7)		* Dir de buffer

		MOVEM.L	A0-A6/D1-D7,-(A7)		* GUARDAMOS REGISTROS EN PILA EXCEPTO D0
		BSR 	PRINT
		MOVEM.L	(A7)+,A0-A6/D1-D7	    * RESTAURAMOS REGISTROS EXCEPTO D0	

	*** FIN
		BREAK
		RTS



pr38RTI:
			
			MOVE.L	#$00000002,(PRCHAROK)	* El valor de terminacion correcto

			* Esperamos para escribir por la linea B
			BREAK

			* una vez que la RTI ya haya metido todos los caracteres de la linea en el buffer de la linea B pasamos a llamar a SCAN

			MOVE.L	#1,(SCSDESCR)			* Descriptor del puerto o linea B para SCAN
    		MOVE.L	#0,(PRSDESCR)			* Descriptor del puerto o linea A para PRINT
			
			* decimos que son 1 lineas
			MOVE.L	#1,(SCNLin)				* Como son 1 lineas ponemos un 1
											* hara 1 SCAN y sumara los resulta
			MOVE.L	#1,(PRNLin)				* Como son 1 lineas ponemos un 1
											* hara 1 PRINT y sumara los resulta
							

			JMP		prSCPRRTI
			

* -----------------------------------------------------------------> pr38es_int


* -----------------------------------------------------------------> pr39es_int	
* PPAL: pr39es_int
*
* 	Descripcion: 	
*		PRINT - PUERTO A - 1 Linea - 10 Charts
*		1234567890 + 0d (Retorno de Carro)
*
*	Salida:
*		D0 = 0000000b
*

pr39RTI:
			
			MOVE.L	#$0000000b,(PRCHAROK)	* El valor de terminacion correcto

			* Esperamos para escribir por la linea B
			BREAK

			* una vez que la RTI ya haya metido todos los caracteres de la linea en el buffer de la linea B pasamos a llamar a SCAN

			MOVE.L	#1,(SCSDESCR)			* Descriptor del puerto o linea B para SCAN
    		MOVE.L	#0,(PRSDESCR)			* Descriptor del puerto o linea A para PRINT
			
			* decimos que son 1 linea
			MOVE.L	#1,(SCNLin)				* Como son 1 lineas ponemos un 1
											* hara 1 SCAN y sumara los resulta
			MOVE.L	#1,(PRNLin)				* Como son 1 lineas ponemos un 1
											* hara 1 PRINT y sumara los resulta
							

			JMP		prSCPRRTI

* -----------------------------------------------------------------> pr39es_int


* -----------------------------------------------------------------> pr40es_int	
* PPAL: pr40es_int
*
* 	Descripcion: 	
*		PRINT - PUERTO B - 1 Linea - 100 Charts
*		1234567890 (10 veces) + 0d (Retorno de Carro)
*
*	Salida:
*		D0 = 00000065
*

pr40RTI:
			
			MOVE.L	#$00000065,(PRCHAROK)	* El valor de terminacion correcto

			* Esperamos para escribir por la linea A
			BREAK

			* una vez que la RTI ya haya metido todos los caracteres de la linea en el buffer de la linea B pasamos a llamar a SCAN

			MOVE.L	#0,(SCSDESCR)			* Descriptor del puerto o linea A para SCAN
    		MOVE.L	#1,(PRSDESCR)			* Descriptor del puerto o linea B para PRINT
			
			* decimos que son 1 linea
			MOVE.L	#1,(SCNLin)				* Como son 1 lineas ponemos un 1
											* hara 1 SCAN y sumara los resulta
			MOVE.L	#1,(PRNLin)				* Como son 1 lineas ponemos un 1
											* hara 1 PRINT y sumara los resulta
							

			JMP		prSCPRRTI

* -----------------------------------------------------------------> pr40es_int	


* -----------------------------------------------------------------> pr41es_int
* PPAL: pr41es_int
*
* 	Descripcion: 	
*		PRINT - PUERTO A - 1 Linea - 1000 Charts
*		1234567890 (100 veces) + 0d (Retorno de Carro)
*
*	Salida:
*		D0 = 000003e9
*

pr41RTI:
			
			MOVE.L	#$000003e9,(PRCHAROK)	* El valor de terminacion correcto

			* Esperamos para escribir por la linea B
			BREAK

			* una vez que la RTI ya haya metido todos los caracteres de la linea en el buffer de la linea B pasamos a llamar a SCAN

			MOVE.L	#1,(SCSDESCR)			* Descriptor del puerto o linea B para SCAN
    		MOVE.L	#0,(PRSDESCR)			* Descriptor del puerto o linea A para PRINT
			
			* decimos que son 1 linea
			MOVE.L	#1,(SCNLin)				* Como son 1 lineas ponemos un 1
											* hara 1 SCAN y sumara los resulta
			MOVE.L	#1,(PRNLin)				* Como son 1 lineas ponemos un 1
											* hara 1 PRINT y sumara los resulta
							

			JMP		prSCPRRTI

* -----------------------------------------------------------------> pr41es_int	



* -----------------------------------------------------------------> pr42es_int
* PPAL: pr42es_int
*
* 	Descripcion: 	
*		PRINT - PUERTO B - 1 Linea - 1900 Charts
*		1234567890 (190 veces) + 0d (Retorno de Carro)
*
*	Salida:
*		D0 = 0000076d
*

pr42RTI:
			
			MOVE.L	#$0000076d,(PRCHAROK)	* El valor de terminacion correcto

			* Esperamos para escribir por la linea A
			BREAK

			* una vez que la RTI ya haya metido todos los caracteres de la linea en el buffer de la linea B pasamos a llamar a SCAN

			MOVE.L	#0,(SCSDESCR)			* Descriptor del puerto o linea A para SCAN
    		MOVE.L	#1,(PRSDESCR)			* Descriptor del puerto o linea B para PRINT
			
			* decimos que son 1 linea
			MOVE.L	#1,(SCNLin)				* Como son 1 lineas ponemos un 1
											* hara 1 SCAN y sumara los resulta
			MOVE.L	#1,(PRNLin)				* Como son 1 lineas ponemos un 1
											* hara 1 PRINT y sumara los resulta
							

			JMP		prSCPRRTI

* -----------------------------------------------------------------> pr42es_int


* -----------------------------------------------------------------> pr44es_int
* PPAL: pr44es_int
*
* 	Descripcion: 	
*		PRINT - PUERTO B - 4 Lineas - 400+4 = 404 Charts
*		1234567890 (10 veces) + 0d (Retorno de Carro) - Todo 4 veces, 1 por linea 
*
*	Salida:
*		D0 = 00000194
*

pr44RTI:
			
			MOVE.L	#$00000194,(PRCHAROK)	* El valor de terminacion correcto

			* Esperamos para escribir por la linea A
			BREAK

			* una vez que la RTI ya haya metido todos los caracteres de la linea en el buffer de la linea B pasamos a llamar a SCAN

			MOVE.L	#0,(SCSDESCR)			* Descriptor del puerto o linea A para SCAN
    		MOVE.L	#1,(PRSDESCR)			* Descriptor del puerto o linea B para PRINT
			
			* decimos que son 4 lineas
			MOVE.L	#4,(SCNLin)				* Como son 1 lineas ponemos un 1
											* hara 1 SCAN y sumara los resulta

			* decimos que son 4 lineas
			MOVE.L	#4,(PRNLin)				* Como son 1 lineas ponemos un 1
											* hara 1 PRINT y sumara los resulta
							

			JMP		prSCPRRTI

* -----------------------------------------------------------------> pr44es_int



* -----------------------------------------------------------------> pr45es_int
* PPAL: pr45es_int
*
* 	Descripcion: 	
*		PRINT - PUERTO A - 3 Lineas - 3000+3 = 3003 Charts
*		1234567890 (100 veces) + 0d (Retorno de Carro) - Todo 3 veces, 1 por linea 
*
*	Salida:
*		D0 = 00000bbb
*

pr45RTI:
			
			MOVE.L	#$00000bbb,(PRCHAROK)	* El valor de terminacion correcto

			* Esperamos para escribir por la linea B
			BREAK

			* una vez que la RTI ya haya metido todos los caracteres de la linea en el buffer de la linea B pasamos a llamar a SCAN

			MOVE.L	#1,(SCSDESCR)			* Descriptor del puerto o linea B para SCAN
    		MOVE.L	#0,(PRSDESCR)			* Descriptor del puerto o linea A para PRINT
			
			* decimos que son 3 lineas
			MOVE.L	#3,(SCNLin)				* Como son 3 lineas ponemos un 1
											* hara 1 SCAN y sumara los resulta

			* decimos que son 3 lineas
			MOVE.L	#3,(PRNLin)				* Como son 3 lineas ponemos un 1
											* hara 1 PRINT y sumara los resulta
							

			JMP		prSCPRRTI

* -----------------------------------------------------------------> pr45es_int



* -----------------------------------------------------------------> pr46es_int
* PPAL: pr46es_int
*
* 	Descripcion: 	
*		PRINT - PUERTO A - 1 Lineas - 1+1 = 3 Charts
*		a (1 vez) + 0d (Retorno de Carro) + 0a (alt10) - Todo 1 veces, 1 por linea 
*
*	Salida:
*		D0 = 00000003
*
*	Memoria:
*		0001: 0x61
*		0002: 0x0d
*		0003: 0x0a
*

pr46RTI:
			
			MOVE.L	#$00000003,(PRCHAROK)	* El valor de terminacion correcto

			* Esperamos para escribir por la linea B
			BREAK

			* una vez que la RTI ya haya metido todos los caracteres de la linea en el buffer de la linea B pasamos a llamar a SCAN

			MOVE.L	#1,(SCSDESCR)			* Descriptor del puerto o linea B para SCAN
    		MOVE.L	#0,(PRSDESCR)			* Descriptor del puerto o linea A para PRINT
			
			* decimos que son 3 lineas
			MOVE.L	#1,(SCNLin)				* Como son 1 lineas ponemos un 1
											* hara 1 SCAN y sumara los resulta

			* decimos que son 3 lineas
			MOVE.L	#1,(PRNLin)				* Como son 1 lineas ponemos un 1
											* hara 1 PRINT y sumara los resulta
							

			JMP		prSCPRRTI

* -----------------------------------------------------------------> pr46es_int




* -----------------------------------------------------------------> pr47es_int
* PPAL: pr47es_int
*
* 	Descripcion: 	
*		PRINT - PUERTO B - 2 Lineas - 4+2 = 6 Charts
*		a (1 vez) + 0d (Retorno de Carro) + 0a (alt10) - Todo 2 veces, 1 por linea 
*		Se realiza una unica llamada a PRINT que contiene las lineas descritas mas 
*		diez bytes que no conforman una linea.
*
*	Salida:
*		D0 = 0000000e
*
*	Memoria:
*		0001: 0x61
*		0002: 0x0d
*		0003: 0x0a
*		0004: 0x61
*		0005: 0x0d
*		0006: 0x0a
*

pr47RTI:
			
			MOVE.L	#$0000000e,(PRCHAROK)	* El valor de terminacion correcto

			* Esperamos para escribir por la linea A
			BREAK

			* una vez que la RTI ya haya metido todos los caracteres de la linea en el buffer de la linea A pasamos a llamar a SCAN

			MOVE.L	#0,(SCSDESCR)			* Descriptor del puerto o linea A para SCAN
    		MOVE.L	#1,(PRSDESCR)			* Descriptor del puerto o linea B para PRINT
			
			* decimos que son 2 lineas
			MOVE.L	#2,(SCNLin)				* Como son 1 lineas ponemos un 1
											* hara 1 SCAN y sumara los resulta

			* decimos que son 2 lineas
			MOVE.L	#2,(PRNLin)				* Como son 1 lineas ponemos un 1
											* hara 1 PRINT y sumara los resulta
							

			JMP		prSCPRRTI

* -----------------------------------------------------------------> pr47es_int







* prSCANRTI: * nombre antiguo
prSCRTI:

			* Sacamos los parametros que nos han pasado o lo 
			MOVE.L	(SCSDESCR),D0			* Descriptor
			MOVE.L	(SCTAMMAX),D1			* Tamanyo

			* Preparamos los parametros para SCAN
			MOVE.W 	D1,-(A7)				* Parametro TamaÃ±o para Scan
			MOVE.W 	D0,-(A7)				* Parametro Descriptor para Scan
			MOVE.L 	#dirBUFF,-(A7)			* Parametro Buffer para Scan

			* Aquí la RTI ya tendría que haber saltado y haberlo guardado en el 
			
			* Llamamos a SCAN para guardar los caracteres escritos por la linea
			BSR 	SCAN
	
			* Comprobamos que D0 tiene el resultado correcto
			CMP.L	(SCCHAROK),D0			* Comprobamos caracteres que debemos tener.
			BEQ		BIEN					* Saltamos a BIEN.
			JMP 	MAL						* Si no, esta MAL.





* -----------------------------------------------------------------> prSCPRRTI
* PPAL: prSCPRRTI
*
* 	Descripcion: 	
* 		SCAN de un puerto pasado por SCSDESCR
*		PRINT de un puerto pasados por PRSDESCR
*		Se imprimira el tamaño se que escane del puerto pasado a SCAN
*
*

prSCPRRTI:
			EOR 	D6,D6					* Registro temporal de charts leidos

SCBUC:
		
			* Sacamos los parametros que nos han pasado o lo 
			MOVE.L	(SCSDESCR),D0			* Descriptor
			MOVE.L	(SCTAMMAX),D1			* Tamanyo


			* Preparamos los parametros para SCAN
			MOVE.W 	D1,-(A7)				* Parametro TamaÃ±o para Scan
			MOVE.W 	D0,-(A7)				* Parametro Descriptor para Scan
			MOVE.L 	#dirBUFF,-(A7)			* Parametro Buffer para Scan
			

			* Aquí la RTI ya tendría que haber saltado y haberlo guardado en el 
			
			* Llamamos a SCAN para guardar los caracteres escritos por la linea
			BSR 	SCAN
					
			* Sacamos el numero de lineas que nso faltan
			MOVE.L	(SCNLin),D7				* numeros de lienas
											* numero de veces que hacermos SCAN
			MOVE.L	(SCRES2L),D6			* Temporal para los result
			
			* quitamos uno al contador y volvemos ha hacer el bucle
			SUB.L	#1,D7
			
			* nos copiamos el resultado a un registro temp
			ADD.L	D0,D6					* sumamos el resultado
			
			* Guardamos en memoria
			MOVE.L	D7,SCNLin
			MOVE.L	D6,SCRES2L
	
			* Comprobamos si quedan lineas por leer
			CMP.L	#0,D7					* Comprobamos si ya no tenemos que hacer mas bucles
			BEQ		PRCont				* Saltamos a fin para comprobar el resultado
			JMP		SCBUC				* Si no vamos al bucle otra vez
			
			
PRCont:
        *** Empezamos a imprimir
*        	EOR 	D6,D6					* Registro temporal de charts leidos
			MOVE.L	D6,PRTAMMAX				* Solo imprimiremos lo que hayamos escrito

PRBUC:
            
            * Sacamos los parametros que nos han pasado
			MOVE.L	(PRSDESCR),D0			* Descriptor
			MOVE.L	(PRTAMMAX),D1			* Tamanyo

            * Salvamos los registros
		    MOVEM.L	A0-A6/D1-D7,-(A7)		* GUARDAMOS REGISTROS EN PILA EXCEPTO D0
			
		*** Llamamos a PRINT para que saque la linea
		    MOVE.W	D1,-(A7)			* Tamanyo
		    MOVE.W	D0,-(A7)			* Descriptor
		    MOVE.L	#dirBUFF,-(A7)		* Dir de buffer


		    BSR 	PRINT
		    
            * Sacamos los registros
		    MOVEM.L	(A7)+,A0-A6/D1-D7	    * RESTAURAMOS REGISTROS EXCEPTO D0	       
		    
		    * Sacamos el numero de lineas que nso faltan
			MOVE.L	(PRNLin),D7				* numeros de lienas
											* numero de veces que hacermos SCAN
			MOVE.L	(PRRES2L),D6			* Temporal para los result    
            
            * quitamos uno al contador y volvemos ha hacer el bucle
			SUB.L	#1,D7
			
			* nos copiamos el resultado a un registro temp
			ADD.L	D0,D6					* sumamos el resultado
			
			* Guardamos en memoria
			MOVE.L	D7,PRNLin
			MOVE.L	D6,PRRES2L
	
			* Comprobamos si quedan lineas por leer
			CMP.L	#0,D7					* Comprobamos si ya no tenemos que hacer mas bucles
			BEQ		SCPRFIN				* Saltamos a fin para comprobar el resultado
    		JMP		PRBUC				* Si no vamos al bucle otra vez
        

SCPRFIN:
		*** Saltamos a comprobar la solución
			* Pasamos en D6 el contador de los corracteres.
			BSR 	CheckSOL
			
			* Salimos
			RTS	
			

* -----------------------------------------------------------------> prSCPRRTI









* ------------------------------------------------------------------> prSCes_int
* PPAL: prSCes_int
prSCes_int:
			MOVE.L	#1,D7					* CONTADOR.
			MOVE.L	(SCFLETRA),D3			* ULTIMO CARACTER A METER.
			
			MOVE.B  (SCSPEEDR),CSRA     		* VELOCIDAD LINEA A.
    		MOVE.B  (SCSPEEDR),CSRB     		* VELOCIDAD LINEA B.


prSCINI:

			MOVE.L	(SCILETRA),D1			* PRIMER CARACTER A METER.
			
	
prSCBUC:		
			MOVE.L	(SCSDESCR),D0			* BUFFER PARA METER DATOS [PUERTO]	
			
			MOVEM.L	A0-A6/D1-D7,-(A7)		* GUARDAMOS REGISTROS EN PILA EXCEPTO D0			
			BSR		ESCCAR					* LLAMAMOS A ESCCAR
			MOVEM.L	(A7)+,A0-A6/D1-D7	    * RESTAURAMOS REGISTROS EXCEPTO D0		

			CMP.L	#$FFFFFFFF,D0			* VERIFICAMOS QUE ESCCAR NO FALLA.
			BEQ		MAL2						* SALTAMOS A ESCFalla.

			CMP.L	D3,D1					* COMPARAMOS SI D1 ES D3 [ULTIMA CARACTER]. 
											* SI LO ES ENTONCES AUMENTO CONT D7.
			BEQ		prSCD7A1				* AUMENTAMOS 1 EN D7	

			ADD.L	#1,D1
			JMP		prSCBUC		

prSCD7A1:	

			CMP.L	(SCBUCSCA),D7			* SI D7 ES REPETICION DEL BUCLE. FIN.
			BEQ		prSCSUM0

			ADD.L	#1,D7
			JMP		prSCINI

prSCSUM0:
		
			CMPI.L	#0,(SCCHARFI)		* Si hay un 0, entonces NO anadiremos 0d al final.
			BEQ		prSCSCAN				* Por lo tanto SCAN deberia salir con D0=0.

			* Si hay un 1 e SCCHARFI, entonces si hay que aÃ±adirlo y se hace un ESCCAR con 0d.

			MOVE.L	#$0000000d,D1			* METEMOS EL SALTO DE LINEA
			MOVEM.L	A0-A6/D1-D7,-(A7)		* GUARDAMOS REGISTROS EN PILA EXCEPTO D0			
			BSR		ESCCAR					* LLAMAMOS A ESCCAR CON D0.
			MOVEM.L	(A7)+,A0-A6/D1-D7	    * RESTAURAMOS REGISTROS EXCEPTO D0		

			CMP.L	#$FFFFFFFF,D0			* VERIFICAMOS QUE ESCCAR NO FALLA.
			BEQ		MAL2						* SALTAMOS A ESCFalla.
			
prSCSCAN:
            

			MOVE.L	(SCSDESCR),D0			* Descriptor
			MOVE.L	(SCTAMMAX),D1			* Tamanyo

			MOVE.W 	D1,-(A7)				* Parametro TamaÃ±o para Scan
			MOVE.W 	D0,-(A7)				* Parametro Descriptor para Scan
			MOVE.L 	#dirBUFF,-(A7)			* Parametro Buffer para Scan

			BSR 	SCAN
	
		
		*** Saltamos a comprobar la solución
			* Pasamos en D6 el contador de los corracteres.
			BSR 	CheckSOL
			
			* Salimos
			RTS
* ------------------------------------------------------------------> prSCes_int




* -----------------------------------------------------------------> prENUNSCPR

prENUNSCPR: 
BUCPR:  MOVE.W  #0,CONTC        * Inicializa contador de caracteres
        MOVE.W  #NLIN,CONTL     * Inicializa contador de Líneas
        MOVE.L  #BUFFER,DIRLEC  * Dirección de lectura = comienzo del buffer
OTRAL:  MOVE.W  #TAML,-(A7)     * Tamaño máximo de la línea
        MOVE.W  #DESA,-(A7)     * Puerto A
        MOVE.L  DIRLEC,-(A7)    * Direción de lectura
ESPL:   BSR     SCAN
        CMP.L   #0,D0
        BEQ     ESPL            * Si no se ha leido una línea se intenta de nuevo
        ADD.L   #8,A7           * Restablece la pila
        ADD.L   D0,DIRLEC       * Calcula la nueva dirección de lectura
        ADD.W   D0,CONTC        * Actualiza el número de caracteres leidos
        SUB.W   #1,CONTL        * Actualiza el número de líneas leidas
        BNE     OTRAL           * Si no se han leido todas las líneas se vuelve a leer

        MOVE.L  #BUFFER,DIRLEC  * Dirección de lectura = comienzo del buffer
OTRAE:  MOVE.W  #TAMB,TAME      * Tamaño de escritura = Tamaño de bloque
ESPE:   MOVE.W  TAME,-(A7)      * Tamaño de escritura
        MOVE.W  #DESB,-(A7)     * Puerto B
        MOVE.L  DIRLEC,-(A7)    * Dirección de lectura
        BSR     PRINT
        ADD.L   #8,A7           * Restablece la pila
        ADD.L   D0,DIRLEC       * Calcula la nueva dirección del buffer
        SUB.W   D0,CONTC        * Actualiza el contador de caracteres
        BEQ     SALIR           * Si no quedan caracteres se acaba
        SUB.W   D0,TAME         * Actualiza el tamaño de escritura
        BNE     ESPE            * Si no se ha escrito todo el bloque se insiste
        CMP.W   #TAMB,CONTC     * Si el nº de caracteres que quedan es menor que el
                                * tamaño establecido se imprime ese número
        BHI     OTRAE           * Siguiente  bloque
        MOVE.W  CONTC,TAME
        BRA     ESPE            * Siguiente  bloque
* -----------------------------------------------------------------> prENUNSCPR



* -----------------------------------------------------------------> prSCRTI2L
		
prSCRTI2L:
			EOR 	D6,D6					* Registro temporal de charts leidos

SCRTIBUC:
			
			
			
			* Sacamos los parametros que nos han pasado o lo 
			MOVE.L	(SCSDESCR),D0			* Descriptor
			MOVE.L	(SCTAMMAX),D1			* Tamanyo


			* Preparamos los parametros para SCAN
			MOVE.W 	D1,-(A7)				* Parametro TamaÃ±o para Scan
			MOVE.W 	D0,-(A7)				* Parametro Descriptor para Scan
			MOVE.L 	#dirBUFF,-(A7)			* Parametro Buffer para Scan
			

			* Aquí la RTI ya tendría que haber saltado y haberlo guardado en el 
			
			* Llamamos a SCAN para guardar los caracteres escritos por la linea
			BSR 	SCAN
					
			* Sacamos el numero de lineas que nso faltan
			MOVE.L	(SCNLin),D7				* numeros de lienas
											* numero de veces que hacermos SCAN
			MOVE.L	(SCRES2L),D6				* Temporal para los result
			
			* quitamos uno al contador y volvemos ha hacer el bucle
			SUB.L	#1,D7
			
			* nos copiamos el resultado a un registro temp
			ADD.L	D0,D6					* sumamos el resultado
			
			* Guardamos en memoria
			MOVE.L	D7,SCNLin
			MOVE.L	D6,SCRES2L
	
			* Comprobamos si quedan lineas por leer
			CMP.L	#0,D7					* Comprobamos si ya no tenemos que hacer mas bucles
			BEQ		SCRTIFIN				* Saltamos a fin para comprobar el resultado
			JMP		SCRTIBUC				* Si no vamos al bucle otra vez
			
SCRTIFIN:
				
			* Comprobamos que D0 tiene el resultado correcto
			CMP.L	(SCCHAROK),D6			* Comprobamos caracteres que debemos tener.
			BEQ		BIEN					* Saltamos a BIEN.
			JMP 	MAL						* Si no, esta MAL.








prSC2Les_int:

			MOVE.L	#0,D6					* CONTADOR.
			MOVE.L	(SCdir),A2				* BUFFER PARA METER DATOS [PUERTO]
			
			MOVE.B  (SCSPEEDR),CSRA     		* VELOCIDAD LINEA A.
    		MOVE.B  (SCSPEEDR),CSRB     		* VELOCIDAD LINEA B.

			
prSC2LINI:
			MOVE.L	#1,D7					* CONTADOR.
			
prSC2LI2:
			MOVE.L	(SCFLETRA),D3			* ULTIMO CARACTER A METER.
			MOVE.L	(SCILETRA),D1			* PRIMER CARACTER A METER.
			
	
prSC2LBUC:		
*			MOVE.L	(SCSDESCR),D0			* BUFFER PARA METER DATOS [PUERTO]
			
			MOVEM.L	A3-A6/D1-D7,-(A7)		* GUARDAMOS REGISTROS EN PILA EXCEPTO D0			
			BSR		ESCCAR2					* LLAMAMOS A ESCCAR2
			MOVEM.L	(A7)+,A3-A6/D1-D7	    * RESTAURAMOS REGISTROS EXCEPTO D0		

*			CMP.L	#$FFFFFFFF,D0			* VERIFICAMOS QUE ESCCAR NO FALLA.
*			BEQ		MAL2						* SALTAMOS A ESCFalla.

			CMP.L	D3,D1					* COMPARAMOS SI D1 ES D3 [ULTIMA CARACTER]. 
											* SI LO ES ENTONCES AUMENTO CONT D7.
			BEQ		prSC2LD7A1				* AUMENTAMOS 1 EN D7	

			ADD.L	#1,D1
			JMP		prSC2LBUC		

prSC2LD7A1:	

			CMP.L	(SCBUCSCA),D7			* SI D7 ES REPETICION DEL BUCLE. FIN.
			BEQ		prSC2LSUM0

			ADD.L	#1,D7
			JMP		prSC2LI2

prSC2LSUM0:
		
			CMPI.L	#0,(SCCHARFI)			* Si hay un 0, entonces NO anadiremos 0d al final.
			BEQ		prSC2Lnew				* miramos si quieren añadir una linea mas despues
											* Ademas SCNLin=0 -> Por lo tanto SCAN deberia salir con D0=0.

			* Si hay un 1 e SCCHARFI, entonces si hay que aÃ±adirlo y se hace un ESCCAR con 0d.

			MOVE.L	#$0000000d,D1			* METEMOS EL SALTO DE LINEA
			MOVEM.L	A3-A6/D1-D7,-(A7)		* GUARDAMOS REGISTROS EN PILA EXCEPTO D0			
			BSR		ESCCAR2					* LLAMAMOS A ESCCAR CON D0.
			MOVEM.L	(A7)+,A3-A6/D1-D7	    * RESTAURAMOS REGISTROS EXCEPTO D0		

			CMP.L	#$FFFFFFFF,D0			* VERIFICAMOS QUE ESCCAR NO FALLA.
			BEQ		MAL						* SALTAMOS A ESCFalla.
				
prSC2Lnew:			
			CMPI.L	#0,(SCNLin)			* Si hay un 0, entonces NO hay mas lineas que añadir
			BEQ		prSC2LSCAN				
			
			
			CMP.L	(SCNLin),D6			* Si hay un 0, entonces NO hay mas lineas que añadir
			BEQ		prSC2LSCAN				* Si es el mismo numero, entonces se han copiado todas las lineas
			
			ADD.L	#1,D6
			
			JMP		prSC2LINI
			
			
prSC2LSCAN:
            
            * actualizamos el puntero de insercion
            * como es la linea A de SCAN
   			MOVE.L		A2,(PBSLAI)			* Insercion
            

			MOVE.L	(SCSDESCR),D0			* Descriptor
			MOVE.L	(SCTAMMAX),D1			* Tamanyo

			MOVE.W 	D1,-(A7)				* Parametro TamaÃ±o para Scan
			MOVE.W 	D0,-(A7)				* Parametro Descriptor para Scan
			MOVE.L 	#dirBUFF,-(A7)			* Parametro Buffer para Scan

			BSR 	SCAN
	
			* Comparador no funciona
			MOVE.L	(SCCHAROK),D1
			CMP.L	D0,D1
*			CMP.L	(SCCHAROK),D0			* Comprobamos caracteres que debemos tener.
			BEQ		BIEN					* Saltamos a BIEN
			JMP 	MAL						* Si no, esta MAL.

* -----------------------------------------------------------------> prSCRTI2L



* ------------------------------------------------------------------> ppllPr
* PPAL: ppllPr
ppllPr:
        MOVE.L   #2000,D5
ppllOTRO:   
*		MOVE.W    D5,-(A7)     ***10,200,20.....******
*	    MOVE.W    #0,-(A7)
* 	    MOVE.L    #dirBUFF,-(A7)
        
        MOVE.W	#0,D0			* descriptor
		MOVE.W	#4,D1			* TAMANYO
			
		MOVE.W 	D1,-(A7)		* Parametro TamaÃ±o para Scan
		MOVE.W 	D0,-(A7)		* Parametro Descriptor para Scan
		MOVE.L 	#dirBUFF,-(A7)	* Parametro Buffer para Scan
			
        BSR      PRINT            * Inicia el controlador

*        SUB.L    D0,D5
*        BNE      ppllOTRO
		RTS


* ------------------------------------------------------------------> ppllPr


* --------------------------------------------------------------------> PPLLSC0	
* PPAL: PPLLSC0
*
* 	Descripcion: Le pasamos tamanyo 0 para que no nos saque nada
*
PPLLSC0: 

			MOVE.W	#1,D0		* descriptor
			MOVE.W	#0,D1		* TAMANYO
			MOVE.W 	D1,-(A7)		* Parametro TamaÃ±o para Scan
			MOVE.W 	D0,-(A7)		* Parametro Descriptor para Scan
			MOVE.L 	#dirBUFF,-(A7)	* Parametro Buffer para Scan
			BSR 	SCAN
			
			* Comprobamos esta prueba
			CMP.L	#0,D0
			BEQ		BIEN		
			JMP 	MAL
* --------------------------------------------------------------------> PPLLSC0 

* --------------------------------------------------------------------> PPLLSC1	
* PPAL: PPLLSC1
*
* 	Descripcion: Sacamos los charts qeunos diga TAMANYO del Buffer que diga descriptor,
*
PPLLSC1: 

			MOVE.W	#1,D0		* descriptor
			MOVE.W	#20,D1		* TAMAÃ‘O
			MOVE.W 	D1,-(A7)		* Parametro TamaÃ±o para Scan
			MOVE.W 	D0,-(A7)		* Parametro Descriptor para Scan
			MOVE.L 	#dirBUFF,-(A7)	* Parametro Buffer para Scan
			BSR 	SCAN
			
			* Comprobamos esta prueba
			CMP.L	#20,D0
			BEQ		BIEN		
			JMP 	MAL
	
			RTS	
* ------------------------------------------------------------------> PPLLSC1 



******************************************************************
* Recibo un caracter de la linea A y lo transmito por la linea B *
******************************************************************
Rec1A2B:
	*---Llamar a SCAN---*
		MOVE.W	#3000,-(A7)	* Tamano 
		MOVE.W	#0,-(A7)	* Descriptor A
		MOVE.L	#$6000,-(A7)	* Buffer
	REP1:	
		BSR SCAN
		CMP.L #0,D0	* Si no existe ninguna linea valida vuelvo al comienzo
		BEQ REP1
	*---Llamar a PRINT---*
		MOVE.W	D0,-(A7)	* Tamano de bloque
		MOVE.W	#1,-(A7)	* Descriptor B
		MOVE.L	#$6000,-(A7)	* Buffer
		BSR PRINT


******************************************************************
* Recibo un caracter de la linea B y lo transmito por la linea A *
******************************************************************
Rec1B2A:
	*---Llamar a SCAN---*
		MOVE.W	#3000,-(A7)	* Tamano 
		MOVE.W	#1,-(A7)	* Descriptor B
		MOVE.L	#$5000,-(A7)	* Buffer
	REP2:	BSR SCAN
		CMP.L #0,D0	* Si no existe ninguna linea valida vuelvo al comienzo
		BEQ REP2
	*---Llamar a PRINT---*
		MOVE.W	D0,-(A7)	* Tamano de bloque
		MOVE.W	#0,-(A7)	* Descriptor A
		MOVE.L	#$5000,-(A7)	* Buffer
		BSR PRINT



* -------------------------------------------------------------------> METEMOS
* PPAL: METEMOS
*
* 	Descripcion:
*
METEMOS: 
			MOVE.B	#$31,$5001			
			MOVE.B	#$32,$5002			
			MOVE.B	#$33,$5003			
			MOVE.B	#$34,$5004			
			MOVE.B	#$35,$5005			
			MOVE.B	#$36,$5006			
			MOVE.B	#$37,$5007			
			MOVE.B	#$38,$5008			
			MOVE.B	#$39,$5009			
			MOVE.B	#$30,$500a
			
			RTS
* -------------------------------------------------------------------> METEMOS


* -------------------------------------------------------------------> PPALinse
* PPAL: PPALinse
*
* 	Descripcion:
*		* Insertarmos D3 caracteres en el buffer seleccionado en D0
PPALinse:
			MOVE.L	#$0,D1					* metemos 0(HEX) como primer char a meter
			MOVE.L	#$000000FF,D3			* N charts a menter
	* Escribimos los charts
PLinsBuc:		
			MOVE.L	#$2,D0					* inicializamos a cero el contador del buffer que queremos	
			
			BSR		ESCCAR			
			
			CMP.L	#$FFFFFFFF,D1
			BEQ		PLinsERR

			CMP.L	D3,D1
			BEQ		PLinsOK
			
			ADD.L	#$1,D1
			
			JMP		PLinsBuc
			
	* Los tratamos como un error	
PLinsERR:		* porque aqui, el buffer nunca estara lleno
			MOVE.L	#$FFFFFFFF,D0
PLinsOK:
			BREAK						
			RTS		
* -------------------------------------------------------------------> PPALinse


* -------------------------------------------------------------------> PPALLine
* PPAL: PPALLine
*
* 	Descripcion:
*		* Nos dice si hay linea en el buffer que pasamos
*
PPALLine:
			
			
	* Miramos si hay linea
PPLLiBuc:		
			MOVE.L	#$0,D0					* inicializamos a vero el contador del buffer que queremos	
			BSR		LINEA			
			CMP.L	#$FFFFFFFF,D0
			BEQ		PPLLinea

			JMP		PPLLiBuc
			
		* Los tratamos como un error	
PPLLinea:					* porque aqui, el buffer nunca estara lleno
			BREAK						
			RTS		
* -------------------------------------------------------------------> PPALLine

* ---------------------------------------------------------------------> PPALLL
* PPAL: PPALLL
*
* 	Descripcion:
*		* Inserta mas de 2001 charts para que compruebe si el buffer esta lleno
*
PPALLL:
			MOVE.L	#$99,D1					* metemos 99(HEX) como primer char a meter
			
	* Escribimos los charts
PPLLBuc:		
			MOVE.L	#$0,D0					* inicializamos a vero el contador del buffer que queremos	
			BSR		ESCCAR			
			CMP.L	#$FFFFFFFF,D0
			BEQ		PPLLBfLL

			JMP		PPLLBuc
			
PPLLBfLL:		* porque aqui, el buffer estara lleno
			BREAK						
			RTS			
* ---------------------------------------------------------------------> PPALLL

* ---------------------------------------------------------------------> PPALFF	
* PPAL: PPALFF
*
* 	Descripcion:
*		* Vamos a meter desde 00 hasta FF en todos los buffers, 
*		* Miramos si hay alguna linea, qu sera desde el primer char 00 hasta el 0d
*		* Leemos todos los charts hasta que nos de FFFFFFFF
*		* Pasamos al siguiente buffer, y repetimos la operecion hasta que terminemos el 3 buffer
*
PPALFF:
			MOVE.L	#$0,D3					* inicializamos a vero el contador del buffer que queremos
			MOVE.L	#$0,D1					* metemos 0(HEX) como primer char a meter
			
	* Escribimos los charts del 00 al FF
PPFFBucESC:
			MOVE.L	D3,D0					* pasamos el cont del buffer a reg selector de buffers
			
			BSR		ESCCAR			
			CMP.L	#$FFFFFFFF,D0
			BEQ		PPFF_BufferLLeno
			
			CMP.L	#$000000FF,D1
			BEQ		PPFF_Linea
			
			ADD.L	#$1,D1
			JMP		PPFFBucESC

PPFF_Linea:	
			MOVE.L	D3,D0					* le pasamos el buffer del que queremos leer 
			BSR		LINEA					* miramos a ver si hay una linea
											
			CMP.L	#$0,D0					* miramos si no hay linea, pro que si que hay 
			BEQ		PPFF_NOHayLinea			* si dice que no hay, entonces no ha encontrado la linea 
			
	* Vamos a leerlos
PPFFBucLC:		
			MOVE.L	D3,D0					* le pasamos el buffer del que queremos leer 
			BSR		LEECAR			
			CMP.L	#$FFFFFFFF,D0			* ha dado un error al leer por que ha alcanzado al de insercion
			BEQ		PPFF_CONT				* Esta bien y continuamos al siguiente buffer, porque ya hemos leido todos
			JMP		PPFFBucLC				* Si no ha dado Error es que quedan mas por leer
			
	* Resetamos el buffer
PPFF_CONT:			
			CMP.L	#$00000003,D3			* si hemos mirado todos los buffer -> salimos
			BEQ		PPFF_FinOK_todoslosbuffers
			ADD.L	#$1,D3					* aumentamos 1 al contador de buffers
			MOVE.L	#$0,D1					* resetamos a 0 el registro de charts a meter
			JMP		PPFFBucESC		
			
	* Los tratamos como un error		
PPFF_BufferLLeno:					* porque aqui, el buffer nunca estara lleno
			BREAK						
			NOP			
PPFF_NOHayLinea:					* aqui, si que hay una linea
			BREAK						
			NOP
	* Fin del programa OK
PPFF_FinOK_todoslosbuffers:	
			RTS
* ------------------------------------------------------------------> PPALFF 	

			
********************************************************************************
* --------------------------------------------------------------------> PPALS 	
********************************************************************************
