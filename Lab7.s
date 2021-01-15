			GLOBAL 	user_code
			AREA	mydata, Code, Readonly
user_code			
num			EQU		3		
sum			RN		0						;reserve 4-byte location for “sum” with initial value 0
current		RN		1
result		SPACE	8						;reserve 8-bytes for “result” with initial value 0

;;;;;;;;;;;Task 1 simple for loop adder;;;;;;;;;;;

			MOV 	R0,#0
			MOV 	R1,#0
			MOV 	R2,#num
			
Loop		ADD 	R0,R0,R1
			CMP 	R1,R2
			BEQ		Done
			ADD 	R1,R1,#1
			
			B 		Loop		

;;;;;;;;;;;Task 3 count for loop adderthe number of “1” bits in each of the first 10 instructions of your program code (starting from label “user_code”).;;;;;;;;;;;

Done
			

;;;;;;;;;;;Task 5 count for loop adderthe number of “1” bits in each of the first 10 instructions of your program code (starting from label “user_code”).;;;;;;;;;;;

Done
			MOV		R4,#0					;Bit counter
			MOV		R3,#0					;R3 # of 1s
			MOV		R2,#0					;R2 which instruction
			LDR		R0,=user_code
			
			LDR		R1,[R0,R2]
			MOVS	R1,R1,LSL#1				;OR LSLS R1,#1
			ADDCS	R3,R3,#1
			ADD		R4,R4,#1
stop		B		stop
			END