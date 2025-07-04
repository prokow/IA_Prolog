% Consulta os dados das cidades e conexões do arquivo dados.pl
:- consult('dados.pl').

% Este predicado faz uma busca em profundidade diante os caminhos, logo, o caminho é construído de trás para frente (destino até origem).
% E evita repetir cidades utilizando a lista Visitadas.
% - Caso base: chegou ao destino, retorna o caminho e a distância acumulada.
busca(Cidade, Cidade, CaminhoAcumulado, CaminhoAcumulado, Dist, Dist).


% - Caso recursivo: tenta avançar para cidades conectadas não visitadas.
busca(CidadeAtual, CidadeDestino, Visitadas, CaminhoFinal, DistAcumulada, DistFinal) :-
    ligacao(CidadeAtual, ProxCidade, DistEntre), % encontra uma ligação entre a cidade atual e a próxima
    \+ member(ProxCidade, Visitadas),            % garante que ainda não passamos por essa cidade, e evita loops
    DistNova is DistAcumulada + DistEntre,       % calcula a nova distância acumulada
    busca(ProxCidade, CidadeDestino, [ProxCidade|Visitadas], CaminhoFinal, DistNova, DistFinal).  % chama recursivamente a busca com a nova cidade e distância acumulada


% Predicado principal para buscar caminhos entre duas cidades.
% Onde será chamado a recursão de busca com a cidade de origem já inserida na lista de visitadas.
pode_ir(CidadeOrigem, CidadeDestino, Caminho, Distancia) :-
    busca(CidadeOrigem, CidadeDestino, [CidadeOrigem], Caminho, 0, Distancia).


% Este predicado imprime todos os caminhos encontrados, junto com suas distâncias.
% Obs: O caminho é invertido(reverse) para exibir da origem ao destino.
imprimir_caminhos([]).
imprimir_caminhos([[Caminho,Dist]|T]) :-
    reverse(Caminho, CaminhoCorreto),          
    format('Caminho: ~w --> Distancia: ~w km\n', [CaminhoCorreto, Dist]), 
    imprimir_caminhos(T).


% Este predicado inicial que prepara a busca pelo menor, assim encontrando o trajeto com a menor distância. 
menor([[Caminho,Dist]|Resto], CaminhoMenorFinal, DistanciaMenorFinal) :-
    menor_aux(Resto, Caminho, Dist, CaminhoMenorFinal, DistanciaMenorFinal).

% Caso base: não há mais trajetos para verificar. O "menor atual" é o resultado final.
menor_aux([], Caminho, Dist, Caminho, Dist).

% Caso recursivo: compara o próximo trajeto da lista.
menor_aux([[C,D]|T], CMin, DMin, CMF, DMF) :-
    ( D < DMin ->                        
        menor_aux(T, C, D, CMF, DMF)       
    ;
        menor_aux(T, CMin, DMin, CMF, DMF)
    ).

% Encontra todos os caminhos possíveis, assim imprimindo cada um com a distância total, e destaca o caminho de menor distância.
mostrar_todos_os_caminhos :-
    cidade_inicial(I), cidade_final(F),
    findall([Caminho,Dist], pode_ir(I,F,Caminho,Dist), ListaTotal), % Encontra TODAS as soluções possíveis para pode_ir(I,F,Caminho,Dist). 
                                                                    % Para cada solução que encontrar, guarde o Caminho e a Dist em uma pequena lista [Caminho, Dist]. 
                                                                    % No final, junte todas essas pequenas listas em uma lista gigante chamada Lista.
    imprimir_caminhos(ListaTotal), 
    menor(ListaTotal, MenorCaminho, MenorDist),                     % Encontra o menor caminho e a menor distância na lista de caminhos encontrados
    reverse(MenorCaminho, CaminhoCorreto),                          % Inverte o caminho para a ordem correta
    format('\n*** Menor caminho: ~w --> Distancia: ~w km ***\n', [CaminhoCorreto, MenorDist]).


% Predicado que inicia a busca e exibe os resultados necessários.
iniciar :-
    write('\n--------------Iniciando busca!--------------\n'),
    mostrar_todos_os_caminhos,
    write('--------------Busca concluida!--------------').