% Dan Blossom
% CMPT 331 Theory of programming languages
% Professor Labouseur

% cipher program

-module(cipher).
% export the only needed functions here
-export([encrypt/2, decrypt/2, solve/2]).

% encrypt: string to encrypt and number of times to move each char
encrypt(String, N) when N > 0 ->
	%call helper function incString x times until base case
	encrypt(incStringOne(string:to_upper(String)), (N - 1));

% if given a negative go the other way, this does not decrypt tho.
% just sorta experementing to see what the outcome would be.
encrypt(String, N) when N < 0 ->
	encrypt(incStringOne(string:to_upper(String)), (N + 1));

% base case for either
encrypt(String, 0) -> String.

% decrypt: string to decrypt number of times until correct letter is achived
decrypt(String, N) when N > 0 ->
	% call helper function dec string x times until base case
	decrypt(decStringOne(string:to_upper(String)), (N - 1));

% base case, spit out string
decrypt(String, 0) -> String.

% solve: string to solve an x times to print or call it
solve(String, N) when N > 1 ->
	% block statement, call helper print then call solve
	% again until base case is reached.	
	begin
		print(String, N),
		solve(decrypt(String, 1), (N-1))
	end
;

% base case: call helper function to print result
solve(String, 1) -> print(String, 1).

% print: string and number for display IE: Caesar 26: HAL
print(String, N) -> io:fwrite("Caesar ~w: ~s~n", [N, decrypt(String, 1)]).

% increments given string by one char
incStringOne(String) -> incStringOne(String, []).

% once zero is hit reverse list since we will be backwards
% this is because we are actually creating a new list
% so as we pop a head it goes to new list pushing element
% down one: IE: ABCD -> A then B then C then D or DCBA
incStringOne([], String) ->	lists:reverse(String);

% this is confusing ... so given a list and a string which is
% what we are building take the tail as the string being passed
% because we are still processing it, then pass as the string
% head (which we use a helper to increment by one and the string
% we are building as the tail - hence why we end up backwards - I
% wonder if that is what happened in spaceballs when is head was put
% on backwards from the teleport device ?
incStringOne([Head | Tail], String) when Head >= $A, Head =< $Z ->
	incStringOne(Tail, [incChar(Head) | String]);

% the base case
incStringOne([Head | Tail], String) ->
	incStringOne(Tail, [Head | String]).

% helper function, simple  if the head + 1 is > Z then 
% recurrsive subtract until we are not.
incChar(Head) when Head + ($B - $A) > $Z ->
	incChar(((Head + 1) - 90) + 63);

% a good value was passed to incChar and we spit out the next char
incChar(Head) -> Head + 1.

% the next 6 functions are the same as above so no need to retype 
% and make you read that all again! because decrypt does not depend
% on encrypt we need to make a set of functions do the opposite...
decStringOne(String) -> decStringOne(String, []).

decStringOne([], String) ->	lists:reverse(String);

decStringOne([Head | Tail], String) when Head >= $A, Head =< $Z ->
	decStringOne(Tail, [decChar(Head) | String]);

decStringOne([Head | Tail], String) ->
	decStringOne(Tail, [Head | String]).

decChar(Head) when Head - ($B - $A) < $A ->
	decChar(91 - (64 - (Head - ($B - $A))));

decChar(Head) -> Head - 1.
