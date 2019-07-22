%% Gerar dados da mão com ruído
% Utilizar o MATLAB 2017 (função 'imageDatastore' necessária)

% É necessário configurar o incremento de ruído e quantidade amostras por
% ruído nas linhas 31 e 32. Para cada quantidade de ruído são gerados k
% matrizes (onde k representa o número de amostras desejadas). Cada
% iteração seleciona imagens diferentes para o banco de treinamento e teste
% (utilizada a função 'shuffle' na linha 48). Para selecionar qual banco
% recebará ruído deve-se verificar a função 'imnoise'.

% As mesmas configurações de 'porcentagem_ruído' e 'num_amostras' devem ser
% utilizadas para verificar a precisão do modelo.

% Caso deseje visualizar uma prévia das imagens com ruídos, descomentar
% entre as linhas 38 e 44; também é necessário que o vetor
% 'porcentagem_ruido' seja compatível com o subplot na linha 42.

% Com o aumento do número de amostras e das divisões de incremento de ruído 
% o tempo de ciclo do programa pode aumentar consideravelmente.

close all;
clear;
clc;

% Criação do banco de imagens (imageDatastore):
rootfolder = 'C:\Users\MARQUES\Desktop\Engenharia\Iniciação Científica\Códigos\Banco_imagens_dedos';
banco_imagens = imageDatastore(rootfolder,'IncludeSubfolders',1,'LabelSource','foldernames');

% Configurando porcentagem de ruído desejada (0:0.1:1 representa
% incrementos de 10%, por exemplo)
porcentagem_ruido = 1;
num_amostras = 1;

for j=1:length(porcentagem_ruido)
    tic
    j
%%
%     banco_imagens = shuffle(banco_imagens);
%     img = readimage(banco_imagens,j);
%     img = imresize(img, [70 70]);
%     img = imnoise(double(img),'salt & pepper',porcentagem_ruido(j));
%     subplot(2,5,j);
%     imshow(img);
%     title(porcentagem_ruido(j));
%%
    for k=1:num_amostras
        % Muda a ordem das imagens de forma aleatória e cria dois novos bancos de imagens (o primeiro contendo 70% dos dados e o segundo, 30%):
        banco_imagens = shuffle(banco_imagens);
        [banco_treinamento,banco_teste] = splitEachLabel(banco_imagens,0.7);
        % Preenchimento da matriz de treinamento e do vetor de rótulos de treinamento:
        for i=1:length(banco_treinamento.Files)
            img = readimage(banco_treinamento,i);
            img = imresize(img, [70 70]);
            % Adicionando ruído ao banco de treinamento:
            img = logical(imnoise(double(img),'salt & pepper',porcentagem_ruido(j)));
            % Cada imagem corresponderá a uma linha na matriz de treinamento
            matriz_treinamento_dedos(i,:,k,j) = img(:)';
            % O grupo a que esta imagem pertecente é atribuído no trecho abaixo
            switch banco_treinamento.Labels(i)
                case 'um_dedo'
                    rotulos_treinamento_dedos(i,k,j) = 1;
                case 'tres_dedos'
                    rotulos_treinamento_dedos(i,k,j) = 3;
                case 'cinco_dedos'
                    rotulos_treinamento_dedos(i,k,j) = 5;
            end
        end
        
        % Preenchimento da matriz de teste e do vetor de rótulos de teste:
        for i=1:length(banco_teste.Files)
            img = readimage(banco_teste,i);
            img = imresize(img, [70 70]);
            % Adicionando ruído ao banco de teste
            img = logical(imnoise(double(img),'salt & pepper',porcentagem_ruido(j)));
            % Cada imagem corresponderá a uma linha na matriz de treinamento
            matriz_teste_dedos(i,:,k,j) = img(:)';
            % O grupo a que esta imagem pertecente é atribuído no trecho abaixo
            switch banco_teste.Labels(i)
                case 'um_dedo'
                    rotulos_teste_dedos(i,k,j) = 1;
                case 'tres_dedos'
                    rotulos_teste_dedos(i,k,j) = 3;
                case 'cinco_dedos'
                    rotulos_teste_dedos(i,k,j) = 5;
            end
        end
    end
    toc
end
matriz_treinamento_dedos = logical(matriz_treinamento_dedos);
matriz_teste_dedos = logical(matriz_teste_dedos);
% Salvando os dados gerados
save('dados_treinamento_dedos_ruidos_21_03_2018','matriz_treinamento_dedos','rotulos_treinamento_dedos','matriz_teste_dedos','rotulos_teste_dedos');


