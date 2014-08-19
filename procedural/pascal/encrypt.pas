//Author: Dan Blossom

program cipher;
Uses sysutils;

var
    //some test variables to mess with
    testEncrypt: string;
    testLen: integer;
    testDecrypt: string;

//this function will encrypt a string... it will only encrypt a - z
//and a neg num is converted to its absolute
function encrypt(stringToEncrypt: string; shiftAmt: integer): string;
var
    //variables needed to ya know, change the string :)
    len, i, charCheck: integer;
    
begin
    stringToEncrypt := UpperCase(stringToEncrypt); //let us just deal with upper
    len := length(StringToEncrypt); //how long is this guy
    
    //if neg, let us just make it pos.
    if(shiftAmt < 0) then
        begin
            shiftAmt := shiftAmt * -1;
			//a message letting the caller know, we did what we wanted with
			//their variable
            writeln('Neg number passed, using absolute value sorry');
        end;
        
    //start at first position in string and inc each char 
    for i := 1 to len do
    begin
        //gets the numerical value of the char at i location
        charCheck := ord(stringToEncrypt[i]);
        //not a letter just leave it alone.
        if ((charCheck < 65) or (charCheck > 90)) then
            stringToEncrypt[i] := chr(charCheck)
        else
			// so - we inc the char's value by the shift amount then if over 90
			// we keep adjusting until we are less than 90, that should be correct
            begin
                charCheck := charCheck + shiftAmt;
                while(charCheck > 90) do
                begin
                    charCheck := charCheck - 90;
                    charCheck := 64 + charCheck;
                end;
				//update the string
                stringToEncrypt[i] := chr(charCheck);
            end;
    end;
	//interesting way to make a return statement
    encrypt := stringToEncrypt;
end;

//this will decrypt a string, working the same as encrpyt only backwards.
function decrypt(stringToDecrypt: string; shiftAmt: integer): string;
var
    len, i, charCheck: integer;
    
begin
    stringToDecrypt := UpperCase(stringToDecrypt);
    len := length(stringToDecrypt);
    
    //if neg, let us just make it pos.
    if(shiftAmt < 0) then
        begin
            shiftAmt := shiftAmt * -1;
            writeln('Neg number passed, using absolute value sorry');
        end;
    
    for i := 1 to len do
    begin
        //gets the numerical value of the char at location i
        charCheck := ord(stringToDecrypt[i]);
        //if the value is not a letter, let us just leave it alone.
        if((charCheck < 65) or (charCheck > 90)) then
            stringToDecrypt[i] := chr(charCheck)
        else
			//the same as encrypt
            begin
                charCheck := charCheck - shiftAmt;
                while(charCheck < 65) do
                begin
                    charCheck := 65 - charCheck;
                    charCheck := 91 - charCheck;
                end;
                stringToDecrypt[i] := chr(charCheck);
            end;
    end;
    //return value
    decrypt := stringToDecrypt;
end;

//the solve procedure basically calls decrypt X times ... no magic here.
procedure solve(inputString: string; maxShiftAmt: integer);
var
    i: integer;
    result: string;

begin

    //if neg, let us just make it pos.
    if(maxShiftAmt < 0) then
        begin
            maxShiftAmt := maxShiftAmt * -1;
            writeln('Neg number passed, using absolute value sorry');
        end;

    for i := 0 to maxShiftAmt do
    begin
        result := decrypt(inputString, i);
        writeln('Caesar ', maxShiftAmt - i, ': ', result);
    end;
end;
    
//testing area of main program.
begin
    //TEST 1
    testEncrypt := 'This is a test string from Alan.';
    testLen := 8;
    writeln(testEncrypt);
    testEncrypt := encrypt(testEncrypt, testLen);
    writeln(testEncrypt);
    testDecrypt := decrypt(testEncrypt, testLen);
    writeln(testDecrypt);
    writeln('*****************************************');
    
    //TEST 2
    testEncrypt := 'Another wacky string %^%&%& did they stay?';
    testLen := 768;
    writeln(testEncrypt);
    testEncrypt := encrypt(testEncrypt, testLen);
    writeln(testEncrypt);
    testDecrypt := decrypt(testEncrypt, testLen);
    writeln(testDecrypt);
    writeln('*****************************************');
    
    //TEST 3
    testEncrypt := 'the brown dog jumped over the lazy fox';
    testLen := 42;
    writeln(testEncrypt);
    testEncrypt := encrypt(testEncrypt, testLen);
    writeln(testEncrypt);
    testDecrypt := decrypt(testEncrypt, testLen);
    writeln(testDecrypt);
    writeln('*****************************************');
    
    //TEST 4
    testEncrypt := 'Sean Connery IS ... Bond!!';
    testLen := 007;
    writeln(testEncrypt);
    testEncrypt := encrypt(testEncrypt, testLen);
    writeln(testEncrypt);
    testDecrypt := decrypt(testEncrypt, testLen);
    writeln(testDecrypt);
    writeln('*****************************************');
    
    //Some solve tests
    solve('hal', -26);
    writeln('*****************************************');
    solve('the brown dog jumped over the lazy fox', 26);
    writeln('*****************************************');
    solve('LZW TJGOF VGY BMEHWV GNWJ LZW DSRQ XGP', 18);

end.
