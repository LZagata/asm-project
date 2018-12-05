;
; Traffic_Lights.asm
;
; Created: 28/11/2018 12:48:16
; Author : Lukas Zagata, Daniela Porcescu
;


; Replace with your application code
START:
	
	; Setup DDR for LEDs
	LDI R24, (1 << PA0)
	OUT DDRA, R24 ; set RED_CAR led to output

	LDI R24 , (1 <<	PC6)
	OUT DDRC, R24 ; set GREEN_CAR led to output

	LDI R24 , (1 <<	PG2)
	OUT DDRG, R24 ; set YELLOW_CAR led to output

	LDI R24 , (1 <<	PF7)
	OUT DDRF, R24 ; set GREEN_PEDESTRIAN led to output

	LDI R24 , (1 <<	PE4)
	OUT DDRE, R24 ; set RED_PEDESTRIAN led to output



	CHECK:
	clr r24		;clear the register r24 so we can read a value into it

	in r24, PIND	;read the value into register r24

	SBRS R24, 0 ; if switch input is 0, then go to red
	JMP TRAFFIC_LIGHT_ON

TRAFFIC_LIGHT_OFF:

	ldi r23, 0xFF
	out portg, r23	;Turning on YELLOW_CAR LED

	ldi r22, 0x00
	out portf, r22
	out portc, r22	;Tunring off the rest of LEDs
	out porte, r22

	ldi  r18, 82
    ldi  r19, 43
    ldi  r20, 0
L1: dec  r20
    brne L1				;1 second delay
    dec  r19
    brne L1
    dec  r18
    brne L1
    lpm
    nop

	ldi r23, 0x00
	out portg, r23	;Turn off YELLOW_CAR

	ldi  r18, 82
    ldi  r19, 43
    ldi  r20, 0
L2: dec  r20
    brne L2				;1 second delay
    dec  r19
    brne L2
    dec  r18
    brne L2
    lpm
    nop

	clr r24

	rjmp CHECK	;Check what is the value of the switch

TRAFFIC_LIGHT_ON:

	ldi r17, 0x00
	out porte, r23	;Turning off YELLOW and RED_PEDESTRIAN LEDs
	out portg, r17

	ldi r16, 0xFF
	out porta, r16	;Turning on RED_CAR and GREEN_PEDESTRIAN
	out portf, r16

	ldi  r18, 3
    ldi  r19, 57
    ldi  r20, 46
    ldi  r21, 13
L5: dec  r21
    brne L5			;Delay of 7 seconds
    dec  r20
    brne L5
    dec  r19
    brne L5
    dec  r18
    brne L5
    rjmp PC+1

YELLOW_CAR:

	ldi r23, 0x00
	out portf, r23	;Turning off GREEN_PEDESTRIAN

	ldi r17, 0xFF
	out porte, r17	;Turning on YELLOW_CAR and RED_PEDESTRIAN
	out portg, r17

    ldi  r18, 163
    ldi  r19, 87
    ldi  r20, 3
L6: dec  r20		;Delay of 2 seconds
    brne L6
    dec  r19
    brne L6
    dec  r18
    brne L6
    nop


GREEN_CAR:

	ldi r16, 0x00
	out portf, r16	; Turning off YELLOW_CAR, RED_CAR and GREEN_PEDESTRIAN
	out portg, r16
	out porta, r16

	ldi r22, 0xFF	;Turning on GREEN_CAR
	out portc, r22

	ldi  r18, 2
    ldi  r19, 150
    ldi  r20, 216
    ldi  r21, 9
L3: dec  r21
    brne L3			;Delay of 5 seconds
    dec  r20
    brne L3
    dec  r19
    brne L3
    dec  r18
    brne L3
    rjmp PC+1

BACK_TO_YELLOW_CAR:

	ldi r22, 0x00	;Turning off GREEN_CAR
	out portc, r22

	ldi r17, 0xFF
	out portg, r17	;Turning on YELLOW_CAR

	ldi  r18, 163
    ldi  r19, 87
    ldi  r20, 3
L4: dec  r20
    brne L4			;Delay of 2 seconds
    dec  r19
    brne L4
    dec  r18
    brne L4
    nop

	
	clr r24

	rjmp CHECK
