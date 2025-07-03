% Consulta os dados das cidades e conexões do arquivo dados.pl
:- consult('dados.pl').



% Predicado principal para encontrar caminhos entre cidades
% Pré-condição: Origem e Destino são átomos representando cidades existentes.
% Pós-condição:
%   - Caminho é uma ListaTotal de cidades (em ordem reversa) conectando Origem a Destino.
%   - Distancia é a soma total das distâncias do caminho.
pode_ir(CidadeOrigem, CidadeDestino, Caminho, Distancia) :-
    busca(CidadeOrigem, CidadeDestino, [CidadeOrigem], Caminho, 0, Distancia).


% Caso base: CidadeOrigem = CidadeDestino
busca(Cidade, Cidade, CaminhoAcumulado, CaminhoAcumulado, Dist, Dist).


% Caso recursivo: procurar próxima cidade conectada
busca(CidadeAtual, CidadeDestino, Visitadas, CaminhoFinal, DistAcum, DistFinal) :-
    ligacao(CidadeAtual, ProxCidade, DistEntre),
    \+ member(ProxCidade, Visitadas),  % evita ciclo
    DistNova is DistAcum + DistEntre,
    busca(ProxCidade, CidadeDestino, [ProxCidade|Visitadas], CaminhoFinal, DistNova, DistFinal).


% Mostra todos os caminhos entre a cidade inicial e a final
mostrar_todos_os_caminhos :-
    cidade_inicial(I), cidade_final(F),
    findall([Caminho,Dist], pode_ir(I,F,Caminho,Dist), ListaTotal), %Encontre TODAS as soluções possíveis para pode_ir(I,F,Caminho,Dist). Para cada solução que encontrar, guarde o Caminho e a Dist em uma pequena lista [Caminho, Dist]. No final, junte todas essas pequenas listas em uma lista gigante chamada Lista.
    imprimir_caminhos(ListaTotal), 
    menor(ListaTotal, MenorCaminho, MenorDist),
    reverse(MenorCaminho, CaminhoCorreto), % Inverte o caminho para a ordem correta
    format('\n** Menor caminho: ~w com ~w km **\n', [CaminhoCorreto, MenorDist]).

% Impressão
imprimir_caminhos([]).
imprimir_caminhos([[Caminho,Dist]|T]) :-
    reverse(Caminho, CaminhoCorreto),
    format('Caminho: ~w --> Distancia: ~w km\n', [CaminhoCorreto, Dist]),
    imprimir_caminhos(T).

% Menor caminho com distância mínima
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