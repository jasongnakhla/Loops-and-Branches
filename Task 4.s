			GLOBAL	user_code				;Labeling instruction
			AREA	mycode, CODE, Readonly	;Making the code a cod and read only from memory
user_code
IO0_Base	EQU		0xE0028000				
PINSEL0		EQU		0xE002C000				;PINSEL0 is a control register and is 32-bit long. pin function selection for port 0 (#0=GPIO)
IO0DIR		EQU		0x8						;sets directions for port 0 (0=input, 1=output)
IO0PIN		EQU		0						;GPIO Port pin to designate value for port (0=0, 1=1)
IO0SET		EQU		0x4						;Similar to IO0PIN except it only turns off the LED
IO0CLR		EQU		0xC						;Similar to IO0PIN except it only turns on the LED
											;Lines 8-10 are offset of IO0_Base instead of loading the address in them
			LDR		R2,=IO0_Base			;Load IO0_Base address into R2
			LDR		R4,=5					;Initialize number for last loop that dictate how many cycles I want the code to run for
											;Has to be initialized outside of the loop or causes an infinte loop
			LDR		R0,=0X0000FFFF			;Making a mask for PINSEL0. This is based on the manual of what values indicate for P0.0-P0.15
			LDR		R1,=PINSEL0				;Load PINSEL0 address into R1
			LDR		R5,[R1]					;Load pointer to point to address in R5
			LDR		R5,R5,R0				;And R5 with the mask to set the Ports we wanr
											;This is active low so 0 means on and 1 means off
			STR		R5,[R1]					;Storing it at Pin Select Port 0's address
			
			MOV		R0,#0x0000FF00			;Setting P0.8-P0.15 to be the output pins from the microcontroller
			STR		R0,[R2,#IO0DIR]			;Storing it in I) Direction's address
			
loop		STR		R0,[R2,#IO0CLR]			;Want to tun on the LEDs. Store the value of R0 into the address of IO0_Base offsetted by
											;IO0CLR to use that address
			LDR		R3,=428571				;Loop 1 to keep LEDs on for 1 second
delay1		SUBS	R3,R3,#1				;Subtract by 1. The last S in SUBS is to set a flag
			BNE		delay1					;Zero flag will not move forward iff the value in R3 is 0
											;If not it branches back to delay1 and keeps subtracting
			STR		R0,[R2,#IO0SET]			;Want to turn off the LEDs. Store the value of R0 into the address of IO0_Base offsetted by
											;IO0_SET to use that address
			LDR		R3,=428571				;Loop 1 to keep LEDs on for 1 second
delay2		SUBS	R3,R3,#1				;Subtract by 1. The last S in SUBS is to set a flag
			BNE		delay2					;Zero flag will not move forward iff the value in R3 is 0
											;If not it branches back to delay2 and keeps subtracting
			SUBS	R4,R4,#1				;Final loop to tell the rocessor how many cycles I want it to run for.
			BNE		loop					;If not 0 branch ack to llop. Number initialized in line 14
			
atop		B		stop
			END