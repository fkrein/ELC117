/*Torneio
Brasil, Chile, Dinamarca, Espanha, Finlândia, Guatemala, Holanda e Irlanda são 
os únicos participantes de um torneio internacional de futebol. Os três times com 
maior número de pontos ao final do torneio recebem troféus. Não há times com a 
mesma pontuaçÂão final e as seguintes condições ocorrem:
• A Finlândia tem mais pontos do que a Espanha, mas menos pontos do que a Holanda.
• A Irlanda tem mais pontos do que a Espanha mas menos pontos do que a Guatemala.
• Tanto o Brasil como o Chile têm mais pontos do que a Holanda.
• Se a Dinamarca recebe troféu, então a Irlanda não recebe troféu.
• Se o Brasil recebe troféu, então a Holanda também recebe troféu.*/

/*Questão 1. Qual dos seguintes é um time que necessariamente recebe troféu?
(A) Dinamarca
(B) Brasil
(C) Chile
(D) Irlanda
(E) Guatemala*/

antes(X,Y,L) :- nth0(PosX,L,X), nth0(PosY,L,Y), PosX < PosY.

recebe_nrecebe(X,Y,L) :- nth0(PosX,L,X), nth0(PosY,L,Y), ((PosX < 3, PosY >= 3); (PosX >= 3)).

recebe_recebe(X,Y,L) :- nth0(PosX,L,X), nth0(PosY,L,Y), ((PosX < 3, PosY < 3); (PosX >= 3)).

recebeTrofeu(X) :-
	antes(holanda,finlandia,L),
	antes(finlandia,espanha,L),
	antes(guatemala,irlanda,L),
	antes(irlanda,espanha,L),
	antes(brasil,holanda,L),
	antes(chile,holanda,L),
	recebe_nrecebe(dinamarca,irlanda,L),
	recebe_recebe(brasil,holanda,L),
	nth0(PosX,L,X), PosX < 3.