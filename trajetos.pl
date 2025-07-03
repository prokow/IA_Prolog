% Consulta os dados das cidades e conexões do arquivo dados.pl
:- consult('dados.pl').


% Predicado principal para buscar caminhos entre duas cidades.
% Chama a recursão de busca com a cidade de origem já inserida na lista de visitadas.
pode_ir(CidadeOrigem, CidadeDestino, Caminho, Distancia) :-
    busca(CidadeOrigem, CidadeDestino, [CidadeOrigem], Caminho, 0, Distancia).


% Implementa uma busca em profundidade (DFS) no grafo de cidades. Caminho é construído de trás para frente (destino até origem).
% Evita repetir cidades utilizando a lista Visitadas.
% - Caso base: chegou ao destino, retorna o caminho e a distância acumulada.
busca(Cidade, Cidade, CaminhoAcumulado, CaminhoAcumulado, Dist, Dist).


% - Caso recursivo: tenta avançar para cidades conectadas não visitadas.
busca(CidadeAtual, CidadeDestino, Visitadas, CaminhoFinal, DistAcum, DistFinal) :-
    ligacao(CidadeAtual, ProxCidade, DistEntre),
    \+ member(ProxCidade, Visitadas),  % evita ciclo
    DistNova is DistAcum + DistEntre,
    busca(ProxCidade, CidadeDestino, [ProxCidade|Visitadas], CaminhoFinal, DistNova, DistFinal).


% Realiza a busca entre cidade_inicial e cidade_final (definidas em dados.pl).
% Encontra todos os caminhos possíveis, imprime cada um com a distância total, e destaca o caminho de menor distância.
mostrar_todos_os_caminhos :-
    cidade_inicial(I), cidade_final(F),
    findall([Caminho,Dist], pode_ir(I,F,Caminho,Dist), ListaTotal), %Encontre TODAS as soluções possíveis para pode_ir(I,F,Caminho,Dist). Para cada solução que encontrar, guarde o Caminho e a Dist em uma pequena lista [Caminho, Dist]. No final, junte todas essas pequenas listas em uma lista gigante chamada Lista.
    imprimir_caminhos(ListaTotal), 
    menor(ListaTotal, MenorCaminho, MenorDist),
    reverse(MenorCaminho, CaminhoCorreto), % Inverte o caminho para a ordem correta
    format('\n** Menor caminho: ~w com ~w km **\n', [CaminhoCorreto, MenorDist]).


% Recebe uma lista de pares [Caminho, Distancia] e imprime cada um no terminal.
% O caminho é invertido para exibir da origem ao destino.
imprimir_caminhos([]).
imprimir_caminhos([[Caminho,Dist]|T]) :-
    reverse(Caminho, CaminhoCorreto),
    format('Caminho: ~w --> Distancia: ~w km\n', [CaminhoCorreto, Dist]),
    imprimir_caminhos(T).


% Recebe uma lista de caminhos e distâncias, e retorna o caminho com a menor distância total.
menor([[Caminho,Dist]|Resto], MenorC, MenorD) :-
    menor_aux(Resto, Caminho, Dist, MenorC, MenorD).

menor_aux([], Caminho, Dist, Caminho, Dist).

menor_aux([[C,D]|T], CMin, DMin, CMF, DMF) :-
    ( D < DMin ->
        menor_aux(T, C, D, CMF, DMF)
    ;
        menor_aux(T, CMin, DMin, CMF, DMF)
    ).


% Inicia a busca e exibe os resultados necessários
iniciar :-
    nl, write('--------------Iniciando busca!--------------'), nl,
    mostrar_todos_os_caminhos,
    nl, write('--------------Busca concluida!--------------').