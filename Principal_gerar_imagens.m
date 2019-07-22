%% Gerando imagens para treinamento
% Esse script salva imagens que ser�o utilizadas posteriormente para
% treinamento do classificador de imagens.
% 
% Primeiramente, obt�m-se o ROI (regi�o de interesse) utilizando o ponto da
% m�o fornecido pelo Kinect.

clear all;
close all;
clc;

% N�mero de imagens para cada gesto
qte_imagens = 200;

% Iniciando o Kinect
[himg, colorVid, depthVid] = iniciar_kinect;

%%
cont = 0;   % Contador de imagens

% Loop 'while' para cada ciclo de leitura do Kinect
while(ishandle(himg))
    [depthMap,depthMetaData] = mostrar_video_profundidade(depthVid);
    
    % Verifica se � encontrado algum esqueleto
    if sum(depthMetaData.IsSkeletonTracked) > 0
        idx = find(depthMetaData.IsSkeletonTracked);
        % Podem ser encontrados at� seis pessoas
        % idx � o �ndice referente a pessoa encontrada
        
        if(idx~=0)
            % Obtendo regi�o de interesse a partir da imagem fornecida pelo
            % kinect
            limites = gerar_roi(depthMetaData,idx);
           
            % Tratando a imagem
            imagem = tratar_imagem(depthMap,limites);
            
            % Salva a imagem tratada no diret�rio
            salvar_imagem(imagem,depthMetaData);
            
            % Interrompe o loop quando s�o salvas o n�mero de imagens
            % desejadas
            cont = cont + 1;
            if(cont>=qte_imagens)
                break
            end
        end
    end
end
stop(depthVid);
