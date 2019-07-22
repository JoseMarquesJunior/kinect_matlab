%% Classificando imagens diretamente do kinect
% Esse script carrega os dados de imagens salvos anteriormente;
% inicia a captura do sensor Kinect;
% e classifica a mão entre aberta e fechada.
clear all;
close all;
clc;

% Carregando dados para treinamento do modelo
load('dados_treinamento_mao.mat');

% Criação dos modelos para classificação das imagens;
% ver função "multisvm_adaptado"
models = multisvm_adaptado(matriz_imagens_mao,grupo_imagens_mao,matriz_teste_mao);

% Inicialização do sensor kinect; ver função "iniciar_kinect"
[himg, colorVid, depthVid] = iniciar_kinect;

SkeletonConnectionMap = [[1 2]; % Spine
    [2 3];
    [3 4];
    [3 5]; %Left Hand
    [5 6];
    [6 7];
    [7 8];
    [3 9]; %Right Hand
    [9 10];
    [10 11];
    [11 12];
    [1 17]; % Right Leg
    [17 18];
    [18 19];
    [19 20];
    [1 13]; % Left Leg
    [13 14];
    [14 15];
    [15 16]];

buffer = 5;                                                                %buffer para suavizar as saídas de ângulo e porcentagem
vetor_angulo = 180*ones(1,buffer);

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
        
        skeletonJoints = depthMetaData.JointImageIndices(:,:,idx);
        if(idx~=0)
            % Obtendo região de interesse a partir da imagem fornecida pelo
            % kinect
            limites = gerar_roi(depthMetaData,idx);
           
            % Tratando a imagem
            imagem = tratar_imagem(depthMap,limites);
            
            %classificando
            classe = classificar_imagem(imagem,models);
            if(classe == 1)
                clc;
                disp('CLOSED');
            else               
                [angulo_cotovelo, vetor_angulo] = calcular_angulo(depthMetaData,idx,vetor_angulo);
                clc;
                disp(round(angulo_cotovelo));
                %disp('ABERTA');
                desenhar_braco(skeletonJoints);
            end
        end
    end
end
stop(depthVid);