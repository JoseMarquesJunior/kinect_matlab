
close all;
clear;
clc;

% GERAR DADOS DEDOS

% Esse script gera os dados para o treinamento do modelo que reconhece o n�mero de dedos mostrados. 
% Deve ser executado no MATLAB 2017 pois utiliza a fun��o imageDatastore para facilitar a manipula��o das imagens.

% Cria��o do banco de imagens (imageDatastore):
rootfolder = 'C:\Users\MARQUES\Desktop\Engenharia\Inicia��o Cient�fica\C�digos\Banco_imagens_dedos';
banco_imagens = imageDatastore(rootfolder,...
    'IncludeSubfolders',1,'LabelSource','foldernames');

% Muda a ordem das imagens de forma aleat�ria e cria dois novos bancos de imagens (o primeiro contendo 70% dos dados e o segundo, 30%):
banco_imagens = shuffle(banco_imagens);                   
[banco_treinamento,banco_teste] = splitEachLabel(banco_imagens,0.7);

% Mostra quatro imagens como exemplo do conte�do do banco de imagens imds:
figure();                               
for i=1:4
    img = readimage(banco_treinamento,i);
    img = imresize(img, [70 70]);
    subplot(2,2,i); 
    imshow(img);
    switch banco_treinamento.Labels(i)
        case 'um_dedo'
            title(1);
        case 'tres_dedos'
            title(3);
        case 'cinco_dedos'
            title(5);
    end
end

% Aloca��o das matrizes de treinamento e do vetores de r�tulos. Cada imagem � transformada em uma linha da matriz e cada r�tulo refere-se a classe a qual essa linha pertence. Esses dados foram alocados inicialmente com o n�mero 7 para facilitar a verifica��o em caso de falhas na aloca��o.
matriz_treinamento_dedos = 7*ones(length(banco_treinamento.Files),length(img(:)'));
rotulos_treinamento_dedos = 7*ones(length(banco_treinamento.Files),1);
matriz_teste_dedos = 7*ones(length(banco_teste.Files),length(img(:)'));
rotulos_teste_dedos = 7*ones(length(banco_teste.Files),1);

% Preenchimento da matriz de treinamento e do vetor de r�tulos de treinamento:
for i=1:length(banco_treinamento.Files)
    img = readimage(banco_treinamento,i);
    img = imresize(img, [70 70]);
    % Cada imagem corresponder� a uma linha na matriz de treinamento
    matriz_treinamento_dedos(i,:) = img(:)';
    % O grupo a que esta imagem pertecente � atribu�do no trecho abaixo
    switch banco_treinamento.Labels(i)
        case 'um_dedo'
            rotulos_treinamento_dedos(i) = 1;
        case 'tres_dedos'
            rotulos_treinamento_dedos(i) = 3;
        case 'cinco_dedos'
            rotulos_treinamento_dedos(i) = 5;
    end
end

% Preenchimento da matriz de teste e do vetor de r�tulos de teste:
for i=1:length(banco_teste.Files)
    img = readimage(banco_teste,i);
    img = imresize(img, [70 70]);
    % Cada imagem corresponder� a uma linha na matriz de treinamento
    matriz_teste_dedos(i,:) = img(:)';
    % O grupo a que esta imagem pertecente � atribu�do no trecho abaixo
    switch banco_teste.Labels(i)
        case 'um_dedo'
            rotulos_teste_dedos(i) = 1;
        case 'tres_dedos'
            rotulos_teste_dedos(i) = 3;
        case 'cinco_dedos'
            rotulos_teste_dedos(i) = 5;
    end
end
 
% Salvando os dados gerados
save('dados_treinamento_dedos','matriz_treinamento_dedos','rotulos_treinamento_dedos','matriz_teste_dedos','rotulos_teste_dedos');