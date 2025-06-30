Trabalho 1 de IA - Sistema Prolog para auxiliar torcedores no Mundial de Clubes de 2025

📁 Arquivos do Projeto:
1. dados.pl       → Contém as cidades, conexões e distâncias.
2. trajetos.pl    → Lógica para encontrar e mostrar caminhos possíveis.
3. readme.txt     → Este arquivo, com instruções para uso.

🔧 Como Executar:
1. Instale o SWI-Prolog (https://www.swi-prolog.org/).
2. Coloque todos os arquivos (.pl) na mesma pasta.
3. Abra o SWI-Prolog e carregue o sistema com:
    ?- [trajetos].

🚀 Como Usar:
- Para ver todos os caminhos possíveis entre a cidade_inicial e a cidade_final:
    ?- mostrar_todos_os_caminhos.

📌 O que o sistema faz:
- Encontra todos os trajetos possíveis entre a cidade de origem e destino.
- Exibe cada caminho com a sequência de cidades e a distância total.
- Indica qual é o menor caminho (em distância) entre os possíveis.

📄 Exemplo de saída esperada:

Caminho: [miami, atlanta, dallas, los_angeles], Distância: 4630 km  
Caminho: [miami, houston, los_angeles], Distância: 4300 km  
** Menor caminho: [miami, houston, los_angeles] com 4300 km **

✍️ Sobre os predicados principais:
- `pode_ir(X, Y, D)` → Verifica se existe ligação direta entre X e Y com distância D.
- `caminho(Origem, Destino, Caminho, Dist)` → Encontra caminhos sem repetir cidades.
- `mostrar_todos_os_caminhos` → Mostra todos os caminhos e o menor.

Aluno: Matheus Prokopowiski dos Santos
