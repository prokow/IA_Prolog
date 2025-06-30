% Carrega os dados de outro arquivo
:- consult('dados.pl').

% Regra pode_ir define que o torcedor pode ir de A até B se existe uma ligacao entre elas
pode_ir(A, B, Dist) :- ligacao(A, B, Dist).
pode_ir(A, B, Dist) :- ligacao(B, A, Dist). % Considera que a ligação é bidirecional

% Regra principal para encontrar um caminho sem repetir cidades
caminho(Origem, Destino, Caminho, DistTotal) :-
    caminho(Origem, Destino, [Origem], CaminhoInvertido, 0, DistTotal),
    reverse(CaminhoInvertido, Caminho).

% Caso base: já chegou ao destino
caminho(Destino, Destino, Caminho, Caminho, Dist, Dist).

% Caso recursivo: tentar ir para próxima cidade não visitada
caminho(Atual, Destino, Visitadas, CaminhoFinal, DistAtual, DistFinal) :-
    pode_ir(Atual, Prox, Distancia),
    \+ member(Prox, Visitadas), % Garante que não voltamos para uma cidade já visitada
    DistNova is DistAtual + Distancia,
    caminho(Prox, Destino, [Prox|Visitadas], CaminhoFinal, DistNova, DistFinal).

% Encontra e mostra todos os caminhos possíveis entre cidade_inicial e cidade_final
mostrar_todos_os_caminhos :-
    cidade_inicial(I), cidade_final(F),
    findall([Caminho,Dist], caminho(I,F,Caminho,Dist), Lista),
    imprimir_caminhos(Lista),
    menor_caminho(Lista, MenorCaminho, MenorDist),
    format('\n** Menor caminho: ~w com ~w km **\n', [MenorCaminho, MenorDist]).

% Imprime todos os caminhos
imprimir_caminhos([]).
imprimir_caminhos([[Caminho,Dist]|Resto]) :-
    format('Caminho: ~w, Distância: ~w km\n', [Caminho, Dist]),
    imprimir_caminhos(Resto).

% Encontra o caminho de menor distância
menor_caminho([[C,D]|Resto], MenorCaminho, MenorDist) :-
    menor_caminho_aux(Resto, C, D, MenorCaminho, MenorDist).

menor_caminho_aux([], Caminho, Dist, Caminho, Dist).
menor_caminho_aux([[C,D]|Resto], CaminhoMin, DistMin, CaminhoFinal, DistFinal) :-
    ( D < DistMin ->
        menor_caminho_aux(Resto, C, D, CaminhoFinal, DistFinal)
    ;
        menor_caminho_aux(Resto, CaminhoMin, DistMin, CaminhoFinal, DistFinal)
    ).
