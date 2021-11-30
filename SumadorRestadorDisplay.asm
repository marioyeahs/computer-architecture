.include "m328pdef.inc" ;Libreria obligatoria para saber el HW a utilizar
.def T=R24 ;Directivas que asocian un registro f?sico con una letra o palabra para el usuario
.def ini=R22 ;Registros para el usuario se sugiere de R15-R31
.def j=R20 ;Registros del R0-R31 Suele usarlo el mismo programa
.def k=R21 ;Todos los registros son de 8 bits
.def mar=R23 ;mar es registro temporal



.org 0x0000 ;Interrupcion a memoria flash, la instruccion se encuentra en la parte baha es la EEPROM
rjmp Puertos ; Primer etiqueta de memoria a buscar y ejecutar
; Las primeras lineas de programa PC=0 (pc apunta a esa linea)
;Etiqueta: Apuntadores de l?nea




Puertos:
ldi T,0b11110000 ;Carga de manera inmediata en binario: T<-11110000
out DDRC,T ;Configuramos el puerto C con DDRpuerto: Ese registro de control determina I/O ---> DDRC<---000000000
out DDRB,T ;Tienen que pasar por registros temporales, no pasa directo



ldi T,0b11111111 ;No se modifica el puerto solo T ... T<----1111111----- ahora es O
out DDRD,T ;Ahora el puerto es salida






Principal:

in j, PINC


cpi j,$01
breq Suma
cpi j,$09
breq Resta
rjmp Principal



Suma:
rcall time_1hz
in j, PINC
rcall time_1hz
in k, PINB
add j,k
rcall Decodificador
rjmp Principal




Resta:
rcall time_1hz
in j, PINC
rcall time_1hz
in k, PINB
sub j,k
rcall Decodificador
rjmp Principal





Decodificador:
CPI J, $00
BREQ Numero0
CPI J, $01
BREQ Numero1
CPI J, $02
BREQ Numero2
CPI J, $03
BREQ Numero3
CPI J, $04
BREQ Numero4
CPI J, $05
BREQ Numero5
CPI J, $06
BREQ Numero6
CPI J, $07
BREQ Numero7
CPI J, $08
BREQ Numero8
CPI J, $09
BREQ Numero9
CPI J, $0A
BREQ Numero10
CPI J, $0B
BREQ Numero11
CPI J, $0C
BREQ Numero12
CPI J, $0D
BREQ Numero13
CPI J, $0E
BREQ Numero14
CPI J, $0F
BREQ Numero15




Numero0:
ldi j, 0b00111111; 0
out PORTD, j
rcall time_1hz
rjmp Principal
Numero1:
ldi j, 0b00000110; 1
out PORTD, j
rcall time_1hz
rjmp Principal




Numero2:
ldi j, 0b01011011; 2
out PORTD, j
rcall time_1hz
rjmp Principal



Numero3:
ldi j, 0b01001111; 3
out PORTD, j
rcall time_1hz
rjmp Principal



Numero4:
ldi j, 0b01100110; 4
out PORTD, j
rcall time_1hz
rjmp Principal




Numero5:
ldi j, 0b01101101; 5
out PORTD, j
rcall time_1hz
rjmp Principal



Numero6:
ldi j, 0b01111101; 6
out PORTD, j
rcall time_1hz
rjmp Principal



Numero7:



ldi j, 0b01000111; 7
out PORTD, j
rcall time_1hz
rjmp Principal



Numero8:
ldi j, 0b01111111; 8
out PORTD, j
rcall time_1hz
rjmp Principal




Numero9:
ldi j, 0b01101111; 9
out PORTD, j
rcall time_1hz
rjmp Principal



Numero10:
ldi j, 0b01110111; 10
out PORTD, j
rcall time_1hz
rjmp Principal



Numero11:
ldi j, 0b01111100; 11
out PORTD, j
rcall time_1hz
rjmp Principal



Numero12:
ldi j, 0b00111001; 12 C
out PORTD, j
rcall time_1hz



Numero13:
ldi j, 0b01011110; 13 D
out PORTD, j
rcall time_1hz
rjmp Principal



Numero14:



ldi j, 0b01111001; 14 E
out PORTD, j
rcall time_1hz
rjmp Principal




Numero15:
ldi j, 0b01110001; 15 F
out PORTD, j
rcall time_1hz
rjmp Principal











time_1hz:



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



ret
