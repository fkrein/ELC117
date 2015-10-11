/*No país das maravilhas
Uma companhia de teatro está iniciando os ensaios para uma nova versão de Alice no País das
Maravilhas. Oito meninas, Lia, Mel, Nanda, Olga, Pilar, Rute, Sara e Tina, disputam o papel de Alice,
e vão realizar um teste para determinar qual é a escolhida. Os testes, com duração de uma hora, serão
feitos de segunda-feira a sexta-feira, em dois horários, 8:00 e 9:00 horas. Uma menina será testada
por vez, mas nenhuma menina será testada no horário de quarta-feira 8:00, pois já há uma reunião
do resto do elenco marcada para esse dia e horário. As seguintes condições devem ser obedecidas:
• Sara é testada terça-feira, 9:00.
• Pilar deve ser testada em algum momento antes de Nanda.
• Olga deve ser testada no mesmo dia que Mel.
• Se Lia é testada às 8:00 em algum dia, então Rute é testada às 8:00 em outro dia.*/

/*Questão 19. Qual das alternativas seguintes poderia
ser uma lista completa e correta das meninas
testadas no horário das 8:00, de segunda a sextafeira?
(A) Olga, Nanda, nenhuma, Pilar, Tina.
(B) Lia, Tina, nenhuma, Pilar, Rute.
(C) Olga, Pilar, nenhuma, Lia, Nanda.
(D) Rute, Tina, nenhuma, Pilar, Mel.
(E) Olga, Lia, nenhuma, Mel, Rute.*/

antes(A,B,List) :-
	(nth0(PosA,List,A), nth0(PosB,List,B), (PosA < PosB));
	(nth0(_,List,A), \+nth0(_,List,B));
	(\+nth0(_,List,A), nth0(PosB,List,B), PosB =\= 0);
	(\+nth0(_,List,A), \+nth0(_,List,B)).

mesmo_dia(A,B,List) :-
	(nth0(_,List,A), \+nth0(_,List,B));
	(\+nth0(_,List,A), nth0(_,List,B)).

mesma_hora(A,B,List) :-
	(nth0(_,List,A), nth0(_,List,B));
	(\+nth0(_,List,A)).

verif_quarta(A,List) :- nth0(2,List,A).

solution(List) :-
	verif_quarta(nenhuma,List),
	antes(pilar,nanda,List),
	mesmo_dia(olga,mel,List),
	mesma_hora(lia,rute,List).

/*	Consultas:

?- solution([olga, nanda, nenhuma, pilar, tina]).
false.

?- solution([lia, tina, nenhuma, pilar, rute]).
false.

?- solution([olga, pilar, nenhuma, lia, nanda]).
false.

?- solution([rute, tina, nenhuma, pilar, mel]).
true .

?- solution([olga, lia, nenhuma, mel, rute]).
false.

*/