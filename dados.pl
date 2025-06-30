% ---- Adicione ao seu dados.pl substituindo ou expandindo ----

ligacao(atlanta, charlotte, 380).
ligacao(atlanta, nashville, 400).
ligacao(atlanta, orlando, 700).
ligacao(atlanta, miami, 1050).
ligacao(charlotte, washington, 630).
ligacao(charlotte, philadelphia, 850).
ligacao(charlotte, cincinnati, 670).
ligacao(nashville, cincinnati, 400).
ligacao(nashville, orlando, 1000).
ligacao(orlando, miami, 380).
ligacao(philadelphia, new_jersey, 150).
ligacao(philadelphia, washington, 220).
ligacao(washington, new_jersey, 300).
ligacao(cincinnati, seattle, 3700).        % conexão longa
ligacao(seattle, pasadena, 1800).
ligacao(pasadena, new_jersey, 4300).

% Origem e destino para o teste

cidade_inicial(atlanta).
cidade_final(new_jersey).
