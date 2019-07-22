%% GERAR_DADOS_MAO_2017

close all;
clear;
clc;

% GERAR_DADOS_MAO_2017
% Esse script gera os dados para o treinamento do modelo que reconhece o n�mero de dedos mostrados.
% Deve ser executado no MATLAB 2017 pois utiliza a fun��o imageDatastore para facilitar a cria��o dos dados.

% Cria��o do banco de imagens (imageDatastore):
rootfolder = 'C:\Users\MARQUES\Desktop\Engenharia\Inicia��o Cient�fica\C�digos\Banco_imagens_mao';
banco_imagens = imageDatastore(rootfolder,'IncludeSubfolders',1,'LabelSource','foldernames');

% Muda a ordem das imagens de forma aleat�ria e cria dois novos bancos de imagens (o primeiro contendo 70% dos dados e o segundo, 30%):
banco_imagens = shuffle(banco_imagens);                   
[banco_treinamento,banco_teste] = splitEachLabel(banco_imagens,0.7);

% Mostra quatro imagens como exemplo do conte�do do banco de imagens:
figure();
for i=1:4
    img = readimage(banco_treinamento,i);
    img = imresize(img, [70 70]);
    subplot(2,2,i);
    imshow(img);
    if(banco_treinamento.Labels(i)=='aberta')
        title('ABERTA');
    else
        title('FECHADA');
    end
end

% Aloca��o das matrizes de treinamento e do vetores de r�tulos. Cada imagem
% � transformada em uma linha da matriz e cada r�tulo refere-se a classe a 
% qual essa linha pertence. Esses dados foram alocados inicialmente com o 
% n�mero 7 para facilitar a verifica��o em caso de falhas na aloca��o.
matriz_treinamento_mao = 7*ones(length(banco_treinamento.Files),length(img(:)'));
rotulos_treinamento_mao = 7*ones(length(banco_treinamento.Files),1);
matriz_teste_mao = 7*ones(length(banco_teste.Files),length(img(:)'));
rotulos_teste_mao = 7*ones(length(banco_teste.Files),1);

% Preenchimento da matriz de treinamento e do vetor de r�tulos de treinamento:
for i=1:length(banco_treinamento.Files)
    img = readimage(banco_treinamento,i);
    img = imresize(img, [70 70]);
    matriz_treinamento_mao(i,:) = img(:)';
    if(banco_treinamento.Labels(i)=='aberta')
        rotulos_treinamento_mao(i) = 1;
    else
        rotulos_treinamento_mao(i) = 0;
    end
end

% Preenchimento da matriz de teste e do vetor de r�tulos de teste:
for i=1:length(banco_teste.Files)
    img = readimage(banco_teste,i);
    img = imresize(img, [70 70]);
    matriz_teste_mao(i,:) = img(:)';
    if(banco_teste.Labels(i)=='aberta')
        rotulos_teste_mao(i) = 1;
    else
        rotulos_teste_mao(i) = 0;
    end
end

% Salvando os dados gerados
save('dados_treinamento_mao','matriz_treinamento_mao','rotulos_treinamento_mao','matriz_teste_mao','rotulos_teste_mao');