		AREA question1, CODE, READONLY
		ENTRY	
		LDR 	r0, =UPC		; Load the momery to register r0
		LDRB 	r8, [r0,#11]	; Load the last digits
		SUB 	r8, #48
		MOV 	r3, #0			; Pointer to the odd number
		MOV 	r4, #1			; Pointer to the even number


ODD		LDRB 	r1, [r0,r3]	; Load the first UPC number into r1
		SUB 	r1, #48			; Convert ASCII value to the decimal
		ADD 	r5, r1			; calculate the sum of odd number
		ADD 	r3, #2			; Increment the pointer position
		CMP 	r3, #12			; check if we reach the end of odd number
		BNE		ODD				; Loop to calculate odd sum

EVEN 	LDRB 	r2, [r0,r4]	; Load the second UPC number into r2
		SUB 	r2, #48			; Convert ASCII value to the decimal
		ADD 	r6, r2			; calculate the sum of odd number
		ADD 	r4, #2			; Increment the pointer position
		CMP 	r4, #11			; check if we reach the end of odd number
		BNE		EVEN			; Loop to calculate even sum
		
MULI    ADD		r7, r5,r5, LSL #1 ;Multiply the odd sum by three
		ADD 	r7, r6			; Add previuos result and even sum
		SUB 	r7, #1			; Subtract previous result by 1
		
MOD		SUB 	r7, #10			; Calculate the remainder use subtraction
		CMP 	r7, #10			; If remainder is less than 10, than save results
		BPL 	MOD				; If not, continue to calculate remainder
		RSB 	r7,r7,#9		; Subtract remainder by 9
	
CHECK 	CMP 	r7, r8			; Check if last digit eqaul to r7
	
VALID	MOVEQ 	r0, #1		; If they are equal, than move r0 to 1
		B		EXIT			; Terminte the program

UNVALID	MOVNE 	r0, #2		; If they are not same, than move r0 to 1
EXIT    B		EXIT
		
UPC		DCB "013800150738"	;UPC data defined		
		END
		