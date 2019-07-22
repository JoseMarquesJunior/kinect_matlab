% PRINCIPAL_ANGULO_BRACO
%
% Calculando o �ngulo formado entre o bra�o e o antebra�o.
% Esse c�digo obt�m as posi��es das articula��es da pessoa identificada e
% calcula o �ngulo formado entre o bra�o e o antebra�o.

clear all;
close all;
clc;

% Inicializa��o do sensor kinect; ver fun��o "iniciar_kinect"
[himg, colorVid, depthVid] = iniciar_kinect;

buffer = 5;                                                                %buffer para suavizar as sa�das de �ngulo e porcentagem
vetor_angulo = 180*ones(1,buffer);

while(ishandle(himg))
    % Capturando imagens em cores e de profundidade do kinect
    trigger([depthVid colorVid]);
    [depthMap,~,depthMetaData] = getdata(depthVid);
    [colorMap,~,colorMetaData] = getdata(colorVid);
    imshow(colorMap, [0 4096]);
    
    % Verifica se � encontrado algum esqueleto
    if sum(depthMetaData.IsSkeletonTracked) > 0
        idx = find(depthMetaData.IsSkeletonTracked);
        % Podem ser encontrados at� seis pessoas
        % idx � o �ndice referente a pessoa encontrada
        
        skeletonJoints = depthMetaData.JointImageIndices(:,:,idx);
        
        if(idx~=0)
            % Obtendo regi�o de interesse a partir da imagem fornecida pelo
            % kinect
            [angulo_cotovelo, vetor_angulo] = calcular_angulo(depthMetaData,idx,vetor_angulo);
            
            desenhar_braco(skeletonJoints);
            
            clc;
            disp(angulo_cotovelo);
        end
    end
end
stop(depthVid);