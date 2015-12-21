/*
* ESTADOS DE CARGA Y DESCARGA DEL CIRCUITO
*
* Author: JicLotus
*
*/

.include <m88def.inc>

estado1:
	cbi portb, 1
	//Stop = HiZ
	cbi SentidoStop,PinStop
	//Sdrive = 5v
	rcall setear_puerto_drive
	//sbi PuertoDrive,PinDrive		
	//Sbooton = 0v 
	//Como viene de Hiz a 0 debe ser, Portx y luego DDrx
	cbi PuertoBottom,PinBottom
	sbi SentidoBottom,PinBottom
	ret

estado2:
	sbi portb, 1
	//Sbooton = HiZ
	cbi SentidoBottom,PinBottom
	//Sstop = 0v
	//Como viene de Hiz a 0 debe ser, Portx y luego DDrx
	cbi PuertoStop,PinStop		
	sbi SentidoStop,PinStop	
	//Sdrive = 0v
	rcall limpiar_puerto_drive
	ret

estado3:	
	rcall Comparator_Enable			//habilito el comparador
	cbi portb, 1
	//Sdrive = Hiz
	//hay que poner como salida y en 0v a SC (comparador)
	rcall limpiar_sentido_drive
	//cbi SentidoDrive,PinDrive		
	rcall limpiar_puerto_drive
	
	//Sslope = 5v
	//Como viene de Hiz a 5v debe ser, Portx y luego DDrx
	sbi PuertoSlope,PinSlope		
	sbi SentidoSlope,PinSlope
	//en este punto empiza la descarga del capacitor Ctank
	//entonces empiezo a contar ciclos de maquina
	rcall Timer_Start
	ret
