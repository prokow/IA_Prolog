# Trabalho 1 de IA - Sistema Prolog para auxiliar torcedores no Mundial de Clubes de 2025

## Arquivos do Projeto

1. `main.pl` – Contém as cidades, ligações e distâncias.
2. `trajetos.pl` – Lógica para encontrar, mostrar caminhos possíveis e o menor caminho desta busca.
3. `readme.md` – Este arquivo, com instruções para uso.

## Para executar basta:
1. Abrir o SWI-Prolog
2. Fazer o `Consult` do arquivo `main.pl`, e depois, faça o `Consult` no arquivo `trajetos.pl`
3. Carregue o sistema com:
    ?- iniciar.

ou caso queira usar no VS Code:
1. Abra o VS Code na pasta onde está o arquivo do trabalho
2. Instale a extensão do Prolog, caso não tenha
3. Abra o terminal e digite `swipl` pressione Enter
4. Carregue o arquivo com:
    ?- [trajetos].
5. E na sequência, basta digitar o comando para iniciar o sistema:
    ?- iniciar.

## Execução
Quando for feito a execução do sistema será mostrado uma imagem que a busca do caminho inicial até o caminho final
está sendo iniciada, e na sequência será mostrado cada caminho possível com sua distância, e por fim de todos os 
caminhos feitos, será mostrado o menor caminho que é possível, junto com sua distância em KM.
Assim auxiliando os torcedores em questão dos caminhos a serem feitos para cada cidade para que cada um possa
acompanhar os jogos do Mundial de Clubes de 2025 sem nenhum problema.

Aluno: Matheus Prokopowiski dos Santos
