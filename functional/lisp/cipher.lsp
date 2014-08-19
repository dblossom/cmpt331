;;;; Dan Blossom
;;;; CMPT 331 Theory of programming Lang
;;;; Professor Labouseur

;;;;Cipher program

;;;; Main functions encrypter, decrypter, solve

;;; Could not call the function encrypt because of some similar libary
;;; issue so calling it encrypter. So this function takes a string
;;; and an int and while int != 1 uses helper function incString to
;;; encrypt the string. The cond statment is nice and this has some
;;; nice recursion to it with minimal guards or patterns but ugh
;;; the parens are just not fair.
(defun encrypter (string int)(cond((= int 1) (incString string))
							 ((< int 1) string) 
							 (t (encrypter(incString string)(- int 1)))))

;;; decrypter does the opposite of encrypter. no way I was figuring out
;;; negative encrypt with this sea of parens. I am just happy everything works.
(defun decrypter (string int)(cond((= int 1) (decString string))
							 ((< int 1) string) 
							 (t (decrypter(decString string)(- int 1)))))

;;; solve function takes a string and int and decrypts and prints the string
;;; as many times a int. it uses the helper function toString to print and
;;; decrypt to decrypt the string as we go along.
(defun solve (string int) (if (= 1 int) (toString( decrypter string 1 ) 1)
									(progn
									(toString( decrypter string 1) int)
									(solve(decrypter string 1) (- int 1)))))

;;;; Helper functions

;;; helper function pretty prints the Caesar x: some_string as we try and de-cipher
;;; the encrypted string! used in solve.
(defun toString (string int) (format t (concatenate 'string "Caesar " (write-to-string int) ": " string "~%")))

;;; given a string, incs every char by one - uses helper function incChar
;;; which deals with roll over support. the built in map function really
;;; becomes useful here.
(defun incString (string) (map 'string #'incChar (string-upcase string)))

;;; the helper incchar function will increment a char by 1 if it is
;;; greater then 90 and less then 65. Simple. If not between 65 or 90
;;; aka a upper-case char, just return that char.
(defun incChar (char) (cond((< (char-code char) 65)char)
							((> (char-code char) 90)char)
							;; here is an example of wasted brain cells.
							;; I wrote it and cannot read it.
							(t (code-char(rollover(+ 1 (char-code char)))))))

;;; a nice clean function that checks if a number is greater then 90, if so
;;; let us keep subtracting until we are no longer greater then 90.
(defun rollOver (n) (cond ((<= n 90) n)
					;; again, lisp is making this simple function overly
					;; difficult. Why must we apply operators as functioins
					;; I know why, because it is just silly.
				   ((>= n 91) (rollOver (+ (- n 90) 64)))))

;;; here are the decrypt functions which are the opposite of encrypter helper
;;; functions and no need to kep reading...or writing.

;;; decString function, just like incString only ... decrements by 1
(defun decString (string) (map 'string #'decChar (string-upcase string)))

;;; decs a char by 1 if not an uppercase
(defun decChar (char) (cond((< (char-code char) 65)char)
							((> (char-code char) 90)char)
							(t (code-char(rollUnder(- (char-code char) 1))))))

;;; ensures we do not hit 64 but rather 90... 65 to 90 or A to Z.
(defun rollUnder (n) (cond ((>= n 65) n)
				   ((<= n 64) (rollUnder (- 91 (- 65 n))))))
