IDENTIFICATION DIVISION.
PROGRAM-ID.   MAINPROG.
AUTHOR.       Dan Blossom

ENVIRONMENT DIVISION.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 A pic x(99) value space.
01 B pic 9(3)  value zeros.
01 C pic x(99) value space.
01 d pic x(9) value space.
01 e pic 9(3) value zeros.

PROCEDURE DIVISION.

MAINPROG.
move 'hal' to a
move 26 to b
call "Solve" using a, b

move 'This is a test string from Alan.' to a
move 8 to b
call "Encrypt" using a, b
display a

call "Decrypt" using a, b
display a

move 'the brown dog jumped over the lazy fox.' to a
call "Encrypt" using a, b
display a
call "Decrypt" using a, b
display a

move 'cobol makes me wish I just got a job at McDonalds' to a
call "Encrypt" using a, b
display a
call "Decrypt" using a, b
display a

stop run.


IDENTIFICATION DIVISION.
PROGRAM-ID.   Encrypt.
ENVIRONMENT DIVISION.
DATA DIVISION.
WORKING-STORAGE SECTION.

01 counter         pic 9(2)  value zeros.
01 point           pic 9(2)  value zeros.
01 currentChar     pic X(1)  value space.
01 charValue       pic 9(2)  value zeros.

LINKAGE SECTION.
01 encryptText     pic X(99) value space.
01 shiftAmt        pic 9(3)  value zeros.

PROCEDURE DIVISION USING encryptText, shiftAmt.
Encrypt.
    move Function Upper-case(encryptText) to encryptText

    INSPECT FUNCTION REVERSE(encryptText) TALLYING counter FOR LEADING SPACES
    COMPUTE counter = LENGTH OF encryptText - counter

    add 1 to counter
    move 1 to point

    Perform counter times
    
    	move encryptText(point:1) to currentChar
    	move function ord(currentChar) to charValue

    	if(charValue) less than 66 or greater than 91 then
    		move charValue to charValue
    	else
			add charValue to shiftAmt giving charValue
    	
			Perform until charValue < 92
				subtract 91 from charValue giving charValue
        		add 65 to charValue giving charValue
			end-perform
    	end-if
    
		move function char(charValue) to currentChar
  		move currentChar to encryptText(point:1)  
    	Subtract 1 from counter
    	add 1 to point
    end-perform
.
EXIT PROGRAM.

IDENTIFICATION DIVISION.
PROGRAM-ID.   Decrypt.
ENVIRONMENT DIVISION.
 DATA DIVISION.

WORKING-STORAGE SECTION.
01 decryptCounter  pic 9(2)  value zeros.
01 decryptPointer  pic 9(2)  value zeros.
01 decryptChar     pic X(1)  value space.
01 decCharVal      pic 9(2)  value zeros.

LINKAGE SECTION.
01 decryptText     pic x(99) value space.
01 decShiftAmt     pic 9(3)  value zeros.

PROCEDURE DIVISION USING decryptText, decShiftAmt.
DECRYPT.

    move function Upper-case(decryptText) to decryptText
    INSPECT FUNCTION REVERSE(decryptText) TALLYING decryptCounter FOR LEADING SPACES
    COMPUTE decryptCounter = LENGTH OF decryptText - decryptCounter
    
    add 1 to decryptCounter
    move 1 to decryptPointer

    Perform decryptCounter times
        move decryptText(decryptPointer:1) to decryptChar
        move function ord(decryptChar) to decCharVal
        
        if(decCharVal) less than 66 or greater than 91 then
            move decCharVal to decCharVal
        else
        	subtract decShiftAmt from decCharVal giving decCharVal
			Perform until decCharVal > 65
                subtract decCharVal from 66 giving decCharVal
                subtract decCharVal from 92 giving decCharVal
			end-perform
            
        end-if
    
        move function char(decCharVal) to decryptChar
        move decryptChar to decryptText(decryptPointer:1)
        add 1 to decryptPointer
        subtract 1 from decryptCounter
    END-PERFORM
.   
EXIT PROGRAM.

IDENTIFICATION DIVISION.
PROGRAM-ID.   Solve.
ENVIRONMENT DIVISION.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 shiftOne        pic 9(3) value zeros.
01 numberDisplay   pic 9(3) value zeros.

LINKAGE SECTION.
01 solveString     pic x(99) value space.
01 solveShift      pic 9(3)  value zeros.

PROCEDURE DIVISION USING solveString, solveShift.
SOLVE.
    move 1 to shiftOne
    add 1 to solveShift
    Perform solveShift times
        subtract 1 from solveShift giving numberDisplay
        display 'Caesar ', numberDisplay, ':', solveString
        call "Decrypt" using solveString, shiftOne
        subtract 1 from solveShift
    END-PERFORM
.
EXIT PROGRAM.

END PROGRAM Solve.
end program Decrypt.
end program Encrypt.
end program MAINPROG.
