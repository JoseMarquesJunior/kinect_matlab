% Classificando imagens diretamente do kinect
% Esse script carrega os dados de imagens salvos anteriormente; inicia a captura do sensor Kinect; e classifica quantos dedos são mostrados.

clear all;
close all;
clc;

% Carregando dados para treinamento do modelo
load('dados_treinamento_dedos.mat');

% Criação dos modelos para classificação das imagens;
% ver função "multisvm_adaptado"
modelo = svm_multiclasse(matriz_treinamento_dedos,rotulos_treinamento_dedos);
[precisao_treinamento, matriz_confusao_treinamento] = calcular_precisao_dedos(modelo,matriz_treinamento_dedos,rotulos_treinamento_dedos);
[precisao_teste, matriz_confusao_teste] = calcular_precisao_dedos(modelo,matriz_teste_dedos,rotulos_teste_dedos);

% Inicialização do sensor kinect; ver função "iniciar_kinect"
[himg, colorVid, depthVid] = iniciar_kinect;

% Loop 'while' para cada imagem obtida pelo Kinect
while(ishandle(himg))
    % Capturando imagens em cores e de profundidade do kinect
    trigger([depthVid colorVid]);
    [depthMap,~,depthMetaData] = getdata(depthVid);
    [colorMap,~,colorMetaData] = getdata(colorVid);
    imshow(colorMap, [0 4096]);
    
    % Verifica se é encontrado algum esqueleto
    if sum(depthMetaData.IsSkeletonTracked) > 0
        idx = find(depthMetaData.IsSkeletonTracked);
        % Podem ser encontrados até seis pessoas
        % idx é o índice referente a pessoa encontrada
        if(idx~=0)
            % Obtendo região de interesse a partir da imagem fornecida pelo
            % kinect
            limites = gerar_roi(depthMetaData,idx);
           
            % Tratando a imagem
            imagem = tratar_imagem(depthMap,limites);
            
            % Classificando tal imagem com base nos modelos criados
            classe = classificar_imagem(imagem,modelos);
            
            % Mostrando na tela o valor obtido
            switch classe
                case 1
                    clc;
                    disp('1');
                case 2
                    clc;
                    disp('3');
                case 3
                    clc;
                    disp('5');
            end
        end
    end
end
stop(depthVid);
