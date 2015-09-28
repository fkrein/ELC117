pred([],[]).
pred([H|T],[H1|T1]) :- H1 is H + 1, pred(T,T1).

/*
Este predicado percorre recursivamente uma lista recebida como parâmetro e armazena em uma 
segunda lista o resultado da adição de uma unidade aos respectivos membros da primeira

	?- pred([1,2,3],[a,b,c]).
	false.

O interpretador realiza o cálculo dos valores esperados da segunda lista e compara com a lista de entrada
Como os dados são diferentes ele imprime "false"

	?- pred([8,9],L).
	L = [9, 10].

O interpretador realiza o cálculo dos valores esperados da segunda lista e armazena-os na variável "L"

	?- pred([1,2,3],[2,L]).
	false.

O interpretador realiza o cálculo dos valores esperados da segunda lista e compara com a lista de entrada
Para o valor 2 e a variável "L" ele obtém correspondência mas falta um membro na segunda lista e ele retorna "false"

	?- pred([1,2],[2,X]).
	X = 3.

O interpretador realiza o cálculo dos valores esperados da segunda lista e compara com a lista de entrada
Ele obtém correspondência para o valor 2 e armazena na variável X o valor esperado, imprimindo-o

*/

ziplus([],[],[]).
ziplus([H1|T1],[H2|T2],[H3|T3]) :- H3 is H1 + H2, ziplus(T1,T2,T3).

countdown(0,[]).
countdown(N,[H|T]) :- H is N, P is N - 1, countdown(P,T), !.

potencias(N,L) :- potencias_aux(N,0,L).

potencias_aux(N1,N2,[]) :- N1 =:= N2.
potencias_aux(N1,N2,[H|T]) :- H is (2^N2), P is N2 + 1, potencias_aux(N1,P,T), !.

positivos([],[]).
positivos([H1|T1],[H2|T2]) :- H1 > 0, H2 is H1, positivos(T1,T2), !.
positivos([_|T1],L) :- positivos(T1,L), !.

mesmaPosicao(_,[],[]) :- false.
mesmaPosicao(A,[H1|_],[H2|_]) :- A = H1, H1 = H2, true.
mesmaPosicao(A,[_|T1],[_|T2]) :- mesmaPosicao(A,T1,T2), !.

intercala(_,[],[]) :- [], !.
intercala(X,[H1|T1],[H2|T2]) :- H2 is H1, intercala_aux(X,T1,T2), !.

intercala_aux(_,[],[]).
intercala_aux(X,[H1|T1],[H2A,H2B|T2]) :- H2A is X, H2B is H1, intercala_aux(X,T1,T2), !.
%% Só funciona se X for um valor numérico

comissao(0, _, []) :- !.
comissao(N, L, [H|T]) :- N > 0, P is N - 1, comissao_aux(H, L, Restantes), comissao(P, Restantes, T).

comissao_aux(H,[H|T],T).
comissao_aux(H,[_|T],Restantes) :- comissao_aux(H,T,Restantes).

azulejos(NA, NQ):- azulejos_aux(NA,N), length(N,NQ).

azulejos_aux(0,[]) :- !.
azulejos_aux(NA,[H|T]) :- sqrt(NA, SQRT), floor(SQRT, FLOOR), H is FLOOR^2, RESTO is NA - H, azulejos_aux(RESTO, T).