AREA question2, CODE, READONLY
			ENTRY
			MOV r0,#1 			; set the flag to 1, representign true
			LDR r1, =STRING - 1 ; set r1 to be right before the beginning of the string
			LDR r2, =EoS 		; set r2 to be right after the end of the string 
		
								
LeftLetter	LDRB r3,[r1, #1]! 	; Load the next letter from the left of the string in r3
			CMP r3,#LetterZ		; compare the letter with ascii code of Z to see if it is not in lower case
			ADDLT r3,#Offset 	; if it is lower, add the offset to make it lower case
			CMP r3,#Letterz		; compare the letter with lower case z
			BGT LeftLetter		; if it is larger than z, it is not a valid letter then we start again
			CMP r3, #Lettera	; compare the letter with lower case a
			BLT LeftLetter		; if it is smaller than a, it is not a valid letter then we start again as well
								; if not, we move on to pick the next valid letter from the right
			

RightLetter	LDRB r4,[r2, #-1]! 	; Load the next letter from the right of the string in r4
			CMP r4, #LetterZ	; compare the letter with ascii code of Z to see if it is not in lower case
			ADDLT r4,#Offset 	; if it is lower, add the offset to make it lower case
			CMP r4,#Letterz	 	; compare the letter with lower case z
			BGT RightLetter 	; if it is larger than z, it is not a valid letter then we start again
			CMP r4, #Lettera	; compare the letter with lower case a
			BLT RightLetter		; if it is smaller than a, it is not a valid letter then we start again as well
								; if not, we compare the right and left letter
								
			CMP r3,r4 			; Compare the two letters from the left and from the right
			MOVNE r0,#2 		; if any of the comparison turns false - the two letters are different - it is not a palindrome
			CMP r1,r2			; check to see if the next left letter is before the next right letter
			BLT LeftLetter		; if it is smaller, then we still need to keep checking
			
Done 		B Done				; end of the program

STRING 		DCB "abb" ;string
EoS 		DCB 0x00 
LetterA		EQU 65
LetterZ		EQU 90
Letterz		EQU 122
Lettera		EQU 97
Offset		EQU 0x20 
			END