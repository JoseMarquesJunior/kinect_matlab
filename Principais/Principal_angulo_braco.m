% PRINCIPAL_ANGULO_BRACO
%
% Calculando o ângulo formado entre o braço e o antebraço.
% Esse código obtém as posições das articulações da pessoa identificada e
% calcula o ângulo formado entre o braço e o antebraço.

clear all;
close all;
clc;

% Inicialização do sensor kinect; ver função "iniciar_kinect"
[himg, colorVid, depthVid] = iniciar_kinect;

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
            [angulo_cotovelo, vetor_angulo] = calcular_angulo(depthMetaData,idx,vetor_angulo);
            
            desenhar_braco(skeletonJoints);
            
            clc;
            disp(angulo_cotovelo);
        end
    end
end
stop(depthVid);
