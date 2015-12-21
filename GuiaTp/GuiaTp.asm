.include "m32def.inc"
 

programa:
	LDI ZL, low(MYDATA<<1) ;R30 = 00 parte baja addr tabla prog.
	LDI ZH, high(MYDATA<<1) ;R31 = 0A,parte baja addr tabla prog
	LDI XL, low(0x140) ;R26 = 40, low-byte RAM address tabla datos
	LDI XH, high(0x140) ;R27 = 1, high-byte RAM address tabla datos
AGAIN: 
	LPM R16, Z+ ;lee tabla, e incrementa Z
	CPI R16,0 ;compara R16 with 0
	BREQ END
	ST X+, R16
	RJMP AGAIN
END: RJMP END

.ORG 0x500
MYDATA: .DB "Si buscas resultados distintos, no hagas siempre lo mismo ",0

