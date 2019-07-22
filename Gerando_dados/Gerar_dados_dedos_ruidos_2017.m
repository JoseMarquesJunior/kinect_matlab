%% Gerar dados da m�o com ru�do
% Utilizar o MATLAB 2017 (fun��o 'imageDatastore' necess�ria)

% � necess�rio configurar o incremento de ru�do e quantidade amostras por
% ru�do nas linhas 31 e 32. Para cada quantidade de ru�do s�o gerados k
% matrizes (onde k representa o n�mero de amostras desejadas). Cada
% itera��o seleciona imagens diferentes para o banco de treinamento e teste
% (utilizada a fun��o 'shuffle' na linha 48). Para selecionar qual banco
% recebar� ru�do deve-se verificar a fun��o 'imnoise'.

% As mesmas configura��es de 'porcentagem_ru�do' e 'num_amostras' devem ser
% utilizadas para verificar a precis�o do modelo.

% Caso deseje visualizar uma pr�via das imagens com ru�dos, descomentar
% entre as linhas 38 e 44; tamb�m � necess�rio que o vetor
% 'porcentagem_ruido' seja compat�vel com o subplot na linha 42.

% Com o aumento do n�mero de amostras e das divis�es de incremento de ru�do 
% o tempo de ciclo do programa pode aumentar consideravelmente.

close all;
clear;
clc;

% Cria��o do banco de imagens (imageDatastore):
rootfolder = 'C:\Users\MARQUES\Desktop\Engenharia\Inicia��o Cient�fica\C�digos\Banco_imagens_dedos';
banco_imagens = imageDatastore(rootfolder,'IncludeSubfolders',1,'LabelSource','foldernames');

% Configurando porcentagem de ru�do desejada (0:0.1:1 representa
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
        % Muda a ordem das imagens de forma aleat�ria e cria dois novos bancos de imagens (o primeiro contendo 70% dos dados e o segundo, 30%):
        banco_imagens = shuffle(banco_imagens);
        [banco_treinamento,banco_teste] = splitEachLabel(banco_imagens,0.7);
        % Preenchimento da matriz de treinamento e do vetor de r�tulos de treinamento:
        for i=1:length(banco_treinamento.Files)
            img = readimage(banco_treinamento,i);
            img = imresize(img, [70 70]);
            % Adicionando ru�do ao banco de treinamento:
            img = logical(imnoise(double(img),'salt & pepper',porcentagem_ruido(j)));
            % Cada imagem corresponder� a uma linha na matriz de treinamento
            matriz_treinamento_dedos(i,:,k,j) = img(:)';
            % O grupo a que esta imagem pertecente � atribu�do no trecho abaixo
            switch banco_treinamento.Labels(i)
                case 'um_dedo'
                    rotulos_treinamento_dedos(i,k,j) = 1;
                case 'tres_dedos'
                    rotulos_treinamento_dedos(i,k,j) = 3;
                case 'cinco_dedos'
                    rotulos_treinamento_dedos(i,k,j) = 5;
            end
        end
        
        % Preenchimento da matriz de teste e do vetor de r�tulos de teste:
        for i=1:length(banco_teste.Files)
            img = readimage(banco_teste,i);
            img = imresize(img, [70 70]);
            % Adicionando ru�do ao banco de teste
            img = logical(imnoise(double(img),'salt & pepper',porcentagem_ruido(j)));
            % Cada imagem corresponder� a uma linha na matriz de treinamento
            matriz_teste_dedos(i,:,k,j) = img(:)';
            % O grupo a que esta imagem pertecente � atribu�do no trecho abaixo
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


