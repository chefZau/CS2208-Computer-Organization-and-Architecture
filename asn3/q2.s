		AREA	problem2, CODE, READWRITE
		ENTRY

		ADR		r0, EoS							;set up r0 to point to end of string
		ADR		r1, STRING						;loads the memory of the string into r1 
		MOV		r2, #0x00						;Initialize the value of EoS into r2
		MOV		r4, #0							;Initialize the point counter into r4
Read
		LDRB	r3, [r1, r4]					;loads the memory from the begining of the string pointed by r4
		B		Case1							;branches to Check Case1
Case1	
		CMP		r3, #0x40						;Compare the first character with hexadicimal value 40, which equals to A
		BLE		Next							;If r3 is less than 0x40, not a alphabet, go to next character
		B		Case2							;Else, go to check case2
Case2		
		CMP		r3, #0x7B						;Compare the first character with hexadicimal value 7B, which equals to (
		BLE		Next							;If r3 is less than 0x7B, not a alphabet, go to next character
		B		Case3							;Else, go to check case3
Case3
		CMP		r3, #0x5A						;Compare the first character with hexadicimal value 5A, which equals to Z
		BLE		Lower							;If r3 is less than 0x5A, convert to lower case
		BGT		Case4							;Else, go to check case4

Case4
		CMP		r3, #0x61						;Compare the first character with hexadicimal value 61, which equals to a
		BLT		Next							;If r3 is less than 0x61, not a alphabet, go to next character
		BGE		Lower							;Else, convert to lower case

Lower
		CMP 	r3, #0x5B						;Check if r3 less than 5B
		ADDLT	r3, #0x20						;If it is, add 0x20 tto make it lower

Store
		STRB	r3, [r0, r5]					;Store valid alphabet from memory r0 to r3 and pointed by r5
		ADD		r5, #1							;Increase the pointer counter r5
Next
		ADD		r4, #1							;Increase the pointer counter r4 to next character
		LDRB	r6, [r1, r4]					;Load the next byte 
		CMP		r6, r2							;checks if itiis end of string
		BNE		Read							;if it is not equal to zero, then read again
	
		MOV		r1, r5							;Make r1 points to r5
		MOV		r2, #0							;Set r2 to zero
		SUB		r1, #1							;Decrease the pointer1
Compare
		LDRB 	r3, [r0, r2]					;Loads a byte from the beginning of string pointer by r2
		LDRB	r4, [r0, r1]					;Loads a byte from the end of string pointer by r1
		ADD		r2, #1							;Increase the pointer counter of r2
		SUB		r1, #1							;Decrease the pointer counter of r1
		CMP		r3, r4							;Compare these two pointer counter
		BEQ		Done							;if equal, then branch to done
		BNE		UNVALID							;if not, it branches to Unvalid
Done
		CMP		r2, r1							;Compare these two pointer counter, again
		BLT		Compare							;If less than zero, than not in the midlle of string, compare again
		B		VALID							;If not, branches to Valid

UNVALID
		MOV		r0, #2							;Fail. set r0 to 2
		B		Loop							;Finish exacute
VALID	
		MOV		r0, #1							;Success. set r0 to 1
Loop	B		Loop							;keep the result in r0
		

STRING 	DCB 	"He lived as a devil, eh?",00	;string
EoS		DCB		0x00							;End of string
		END