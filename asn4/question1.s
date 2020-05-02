		AREA question1,  CODE, READWRITE
		ENTRY
		LDR r9, =STRING1 	;because arm store does not supoort register to memory directly
		LDR r10, =STRING2 	;we need to use a medium point to string1 and string2 which is r9 and r10
		
		MOV r1, #0x74  		;load r1 with letter 't' it will use to store to memory later on
		MOV r2, #0x68		;load r2 with letter 'h' it will use to store to memory later on
		MOV r3, #0x65		;load r3 with letter 'e' it will use to store to memory later on
		
MAIN	LDRB r0, [r9], #1   ;load the content from r9 to r0 and then increment r9 by one(pointing to the next element)
		CMP r0, #0x00	    ;compare the content with '\0', while the content is not the null char keep reading
		STRBEQ r4, [r10], #1 ;null terminating therefore we need to store back \0, r4 has nothing therfore is 0
		BEQ EXIT		    ;it is the null char, exit no need to keep reading
	
		CMP r0, #Letter_t   ;it is not null char, comapre it with 't'
		BNE STORE		    ;if it is not t store it
		
		LDRB r0, [r9], #1	;ok now, it is t, point to the next element and 
		CMP r0, #Letter_h	; check if it is h
		BNE STORE			; it is not 'h' store it! is not 'the'
		
		LDRB r0, [r9], #1	;no, it is 'h', point to the next element and 
		CMP r0, #Letter_e	; check if it is e
		BNE STORE			;is not e, therefore the wor is not 'the' store it
		
		LDRB r0, [r9], #1   ;is letter e then, get a new index. if it is space skip it
		CMP r0, #isSpace	;check id it is space or not
		STRBEQ r0,[r10],#1	;is spacce! store the space, and no need to care about the 'the' we dont want them
		BEQ MAIN			;and jump backward to keep looping
		
		CMPNE r0, #0x00			;it is not a space! check the current position is the \0 or not
		STRBEQ r0, [r10], #1	;it is the \0, we dont want 'the', dont care about them store the 0x00 and leave
		BEQ EXIT				;if it equal to the null char exit
		
		STRBNE r1, [r10], #1	;it is not the \0! therfore the word is useful we want 'the' to stay
		STRBNE r2, [r10], #1	;store back 't' 'h' and 'e'
		STRBNE r3, [r10], #1	;that is the e	
		B STORE					;not equal, store it r10 is pointing to the next position nno effect to store new content		

STORE	STRB r0, [r10],#1		;the step to store the value, store r0 to r10 and r10 point to the next position
		B MAIN



EXIT	B EXIT					
		AREA question1,  DATA, READWRITE
STRING1 DCB "and the man said they must go" ;string
EoS		DCB 0x00							;end of string1
STRING2 space 0xFF							;just allocating 255 bytes
	
Letter_t EQU 0x74 		;is lower case t
Letter_h EQU 0x68		;is lower case h
Letter_e EQU 0x65		;is lower case e
isSpace  EQU 0x20		;is space
		END