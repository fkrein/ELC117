%% Olimpíada Brasileira de Informática – OBI2013
%% http://olimpiada.ic.unicamp.br/pdf/provas/ProvaOBI2013_inic_f2n2.pdf
%% Pág 5 - No país das maravilhas

%%-------------------------Questão 19-------------------------%%

/*
Consultas:
?- solution19([olga, nanda, nenhuma, pilar, tina]).
false.

?- solution19([lia, tina, nenhuma, pilar, rute]).
false.

?- solution19([olga, pilar, nenhuma, lia, nanda]).
false.

?- solution19([rute, tina, nenhuma, pilar, mel]).
true.

?- solution19([olga, lia, nenhuma, mel, rute]).
false.
*/


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

solution19(List) :-
	verif_quarta(nenhuma,List),
	antes(pilar,nanda,List),
	mesmo_dia(olga,mel,List),
	mesma_hora(lia,rute,List), !.


%%-------------------------Questão 20-------------------------%%

/*
Consultas:
?- solution20(quinta,8).
false.

?- solution20(quarta,9).
false.

?- solution20(quinta,9).
true.

?- solution20(sexta,9).
false.

?- solution20(segunda,9).
false.
*/

gera_lista(_,[],[]).
gera_lista(Hora,[Dia|T1],[(Dia,Hora)|T2]) :- gera_lista(Hora,T1,T2).

verif_dia(sara,terca,9).
verif_dia(nanda,sexta,8).
verif_dia(mel,MelD,_) :- MelD \== quarta, verif_dia(sara,SaraD,_), MelD \== SaraD, verif_dia(nanda,NandaD, _), MelD \== NandaD.

verif_lista(_,[],_) :- !.
verif_lista(Nome,[(Dia,Hora)|T], Lista) :- verif_dia(Nome,Dia,_), member((Dia,Hora),Lista), verif_lista(Nome,T,Lista), !.
verif_lista(Nome,[(_,_)|T], Lista) :- verif_lista(Nome,T,Lista), !.

converte(segunda,0).
converte(terca,1).
converte(quinta,2).
converte(sexta,3).

mais_tarde(_,_,[]) :- !.
mais_tarde(Dia,Hora,[(D,H)|T]) :- 
	Dia \== sexta, converte(Dia,DiaV), converte(D,DV), 
	DiaV >= DV, Hora >= H, mais_tarde(Dia,Hora,T).

solution20(Dia,Hora) :-
    gera_lista(8,[segunda,terca,quarta,quinta,sexta],Lista8),
    gera_lista(9,[segunda,terca,quarta,quinta,sexta],Lista9),
    append(Lista8,Lista9,ListaApp),
    verif_lista(mel,ListaApp,Lista),
    mais_tarde(Dia,Hora,Lista), !.