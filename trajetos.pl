% Fará a consulta dos dados de trajetos entre cidades no arquivo dados.pl
:- consult('dados.pl').

% Regra para percorrer caminhos sem repetir cidades
caminho(Origem, Destino, Caminho, Distancia) :-
    caminho(Origem, Destino, [Origem], CaminhoInvertido, 0, Distancia),
    reverse(CaminhoInvertido, Caminho).

caminho(Destino, Destino, Caminho, Caminho, Dist, Dist).
caminho(Atual, Destino, Visitadas, CaminhoFinal, DistAtual, DistFinal) :-
    ligacao(Atual, Prox, Distancia),
    \+ member(Prox, Visitadas),
    DistNova is DistAtual + Distancia,
    caminho(Prox, Destino, [Prox|Visitadas], CaminhoFinal, DistNova, DistFinal).


% Mostrar todos os caminhos
mostrar_todos_os_caminhos :-
    cidade_inicial(I), cidade_final(F),
    findall([Caminho,Dist], caminho(I,F,Caminho,Dist), Lista),
    imprimir_caminhos(Lista),
    menor_caminho(Lista, MenorCaminho, MenorDist),
    format('\n *- Menor caminho: ~w --> ~w km -* \n', [MenorCaminho, MenorDist]).



% Imprimir caminhos
imprimir_caminhos([]).
imprimir_caminhos([[Caminho, Distancia]|Resto]) :-
    format('Caminho: ~w  --> Distancia: ~w km\n', [Caminho, Distancia]),
    imprimir_caminhos(Resto).



% Encontrar menor caminho
menor_caminho([[C,D]|Resto], MenorCaminho, MenorDist) :-
    menor_caminho_aux(Resto, C, D, MenorCaminho, MenorDist).


menor_caminho_aux([], Caminho, Dist, Caminho, Dist).
menor_caminho_aux([[C,D]|Resto], CaminhoMin, DistMin, CaminhoFinal, DistFinal) :-
    ( D < DistMin ->
        menor_caminho_aux(Resto, C, D, CaminhoFinal, DistFinal)
    ;
        menor_caminho_aux(Resto, CaminhoMin, DistMin, CaminhoFinal, DistFinal)
    ).
