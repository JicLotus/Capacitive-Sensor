/*
*
* Definimos algunos nombres para facilitar la lectura del codigo
*
* Author: JicLotus
*
*
* 2 = Sdrive	puerto D
* 4 = Stop		puerto C
* 5 = Sbotton	puerto B
* 0 = Sslope	puerto B
* 12 = sc puerto
*
*/


.def PinDrive = r30			//PinDrive paso de ser un label a ser un registro porque debe cambiar en tiempo de ejecucion
.equ PinStop=4
.equ PinBottom=5
.equ PinSlope=0
.equ pinDrive_cap1 = 3
.equ pinDrive_cap2 = 4


.equ PinLed1=3
.equ PinLed2=2
.equ PinLed3=1

.equ PuertoDrive=portd
.equ PuertoStop=portc
.equ PuertoBottom=portb
.equ PuertoSlope=portb

.equ SentidoDrive=ddrd
.equ SentidoStop=ddrc
.equ SentidoBottom=ddrb
.equ SentidoSlope=ddrb

.equ SentidoLed1=ddrc
.equ PuertoLed1=portc

.equ PuertoLed2=portc
.equ SentidoLed2=ddrc

.equ SentidoLed3=ddrc
.equ PuertoLed3=portc

.def CiclosDeCarga=r17





.equ iteraciones_carga=140

.equ incremento_pwm=250
.equ decremento_pwm=250


.equ ciclos_calibrado=100
.equ dir_ciclos_calibrado=0x305


.equ ciclos_referencia_cap2=160   		//se usa cuando no hay calibrado automatico
.equ ciclos_referencia_cap1=170			//se usa cuando no hay calibrado automatico

.equ dir_ciclos_referencia_cap1=0x306
.equ dir_ciclos_referencia_cap2=0x307

.equ margen_ruido_cap1=20
.equ margen_ruido_cap2=20

.equ correccion_referencia=5			//se usa cuando no hay calibrado automatico	

.equ dir_margen_ruido_cap1=0x308
.equ dir_margen_ruido_cap2=0x309

.equ calibrado_manual_habilitado=0 //1 habilita 0 deshabilita






.def PuertoSerie=r25

//Salida general auxiliar.
.equ Q = PORTC3	 

.equ FlagReposoBajo = 0x0fe
.equ FlagReposo = 0x01
.equ FlagEncendiendo = 0x02
.equ FlagApagando = 0x04


