/* TAREA : CONTADOR ASCEDENTE Y DESCENDENTE */
.include "m328pdef.inc"
.def T=R24
.def ini=R22
.def j=R20
.def k=R21
.def mar=R23

.org 0x0000

rjmp Puertos

Puertos:
	ldi T,0b11111111
	out DDRB,T


;display 7 segmentos

display:

	/*ldi j,0b00000000;00
	out portb,j
	rcall tiempo_1hz*/

	ldi j,0b00111111;00
	out portb,j
	rcall tiempo_1hz

	ldi j,0b00000110;01
	out portb,j
	rcall tiempo_1hz

	ldi j,0b11011011;02
	out portb,j
	rcall tiempo_1hz

	ldi j,0b01001111;03
	out portb,j
	rcall tiempo_1hz

	ldi j,0b01100110;04
	out portb,j
	rcall tiempo_1hz

	ldi j,0b01101101;05
	out portb,j
	rcall tiempo_1hz

	ldi j,0b01111101;06
	out portb,j
	rcall tiempo_1hz

	ldi j,0b01000111;07
	out portb,j
	rcall tiempo_1hz

	ldi j,0b01111111;08
	out portb,j
	rcall tiempo_1hz

	ldi j,0b01100111;09
	out portb,j
	rcall tiempo_1hz

	rcall display


tiempo_1hz:

	; =============================
	; delay loop generator
	; 4000000 cycles:
	; -----------------------------
	; delaying 3999996 cycles:
	ldi R17, $24
	WGLOOP0: ldi R18, $BC
	WGLOOP1: ldi R19, $C4
	WGLOOP2: dec R19
	brne WGLOOP2
	dec R18
	brne WGLOOP1
	dec R17
	brne WGLOOP0
	; -----------------------------
	; delaying 3 cycles:
	ldi R17, $01
	WGLOOP3: dec R17
	brne WGLOOP3
	; -----------------------------
	; delaying 1 cycle:
	nop
	; =============================

	 ret //regreso a programa principal
