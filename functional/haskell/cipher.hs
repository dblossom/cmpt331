-- Dan Blossom
-- CMPT 331 Theory of programming languages
-- Professor Labouseur

-- cipher program

import Data.Char
import System.IO

-- Encrypt xs n
-- Given a string and number it returns a new string with the 
-- characters shifted by 'n' rolling over for z. This only
-- supports the American Alphabet, all other char ignored. 
encrypt [] n = []
encrypt xs n = (incChar (head xs) n) : encrypt (tail xs) n

-- Decrypt xs n
-- Given a string and number it returns a new string with the 
-- characters shifted by 'n' rolling over for a. This only
-- supports the American Alphabet, all other char ignored. 
decrypt [] n = []
decrypt xs n = (decChar (head xs) n) : decrypt (tail xs) n

-- Solve xs n:
-- just calls decrypt n timed printing to terminal the result
-- in a pretty format from helper function toString.
solve xs n
	| n > 1 = toString(decrypt xs 1) n ++ solve (decrypt xs 1) (n-1)
	| otherwise = toString(decrypt xs 1) n


-- toString: prints Caesar n: "string being decrypted"
toString xs n = "Caesar " ++ (show n) ++ ": " ++ xs ++ "\n"

-- incOrd x n
-- x = char; n = number
-- given a char and number it will increment
-- the int value of the char. Only A to Z 
-- forcing lowercase to upper. Also if char is
-- not a..z or A..Z it will return the value of
-- the passed char..IE: incOrd & 3 = 38 NOT: 41
incOrd x n
	| ord (toUpper x) < 65 = ord x
	| ord (toUpper x) > 90 = ord x
	| (ord (toUpper x) + n) > 90 = adjustIncOrd (ord (toUpper x) + n)
	| otherwise = ord (toUpper x) + n

-- decOrd x n
-- x = char; n = number
-- same as incOrd only in reverse no need to read twice
decOrd x n
	| ord (toUpper x) < 65 = ord x
	| ord (toUpper x) > 90 = ord x
	| (ord (toUpper x) - n) < 65 = adjustDecOrd (ord (toUpper x) - n)
	| otherwise = ord (toUpper x) - n

-- incChar x n -> x is char, n increment value
-- This function takes a char and returns the newly
-- created char after calling incOrd which given a
-- char returns that chars value + n. Enjoy.
incChar x n = chr (incOrd x n)

-- decChar x n
-- same as incChar but in reverse
decChar x n = chr (decOrd x n)

-- adjustIncOrd x -> x number to adjust for rollover
-- This will help roll over z to a ...
-- "while x is greater than 90" 
-- subtract x from 90 then add 64
adjustIncOrd x
	| x > 90 = adjustIncOrd ((x - 90) + 64)
	| otherwise = x

-- adjustDecOrd x -> number to adjust for rollover
-- This will help roll over z to z
-- while x is less than 65
-- subtract 65 from x then from 91
adjustDecOrd x
	| x < 65 = adjustDecOrd (91 - (65 - x))
	| otherwise = x
