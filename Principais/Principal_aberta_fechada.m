% Classificando imagens diretamente do kinect
% Esse script: 
% 
% * carrega os dados de imagens salvos anteriormente;
% * inicia a captura do sensor Kinect;
% * e classifica a mão entre aberta e fechada.

clear all;
close all;
clc;

% Carregando dados para treinamento do modelo
load('dados_treinamento_mao.mat');

% Criação dos modelos para classificação das imagens;
% ver função "svm_multiclasse"
modelo = svm_multiclasse(matriz_treinamento_mao,rotulos_treinamento_mao);
[precisao_treinamento, matriz_confusao_treinamento] = calcular_precisao_mao(modelo,matriz_treinamento_mao,rotulos_treinamento_mao)
[precisao_teste, matriz_confusao_teste] = calcular_precisao_mao(modelo,matriz_teste_mao,rotulos_teste_mao)
pause;
%%
%
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
            
            % Classificando a imagem obtida
            classe = classificar_imagem(imagem,modelo);
            if(classe == 1)
                clc;
                disp('FECHADA');
            else
                clc;
                disp('ABERTA');
            end
        end
    end
    break
end
stop(depthVid);
