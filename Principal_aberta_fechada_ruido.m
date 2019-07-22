%% Testando dados da m�o com ru�dos
% Utilizar o MATLAB 2013

% � necess�rio configurar o incremento de ru�do e quantidade amostras por
% ru�do nas linhas 28 e 29.

% As mesmas configura��es de 'porcentagem_ru�do' e 'num_amostras' devem ser
% as mesmas utilizadas na gera��o dos dados com ru�do.

clear all;
close all;
clc;

% Carregando dados para treinamento do modelo
load('dados_treinamento_mao_ruido_somente_teste_09_03_2018.mat');

matriz_treinamento_mao = double(matriz_treinamento_mao);
matriz_teste_mao = double(matriz_teste_mao);

% Configurando porcentagem de ru�do desejada (deve ser configurado da mesma
% forma que na gera��o dos dados com ru�dos)
porcentagem_ruido = 0:0.2:1;
num_amostras = 4;

% Cria��o dos modelos para classifica��o das imagens;
for j = 1:length(porcentagem_ruido)
    tic
    j
    for k = 1:num_amostras
        modelo = svm_multiclasse(matriz_treinamento_mao(:,:,k,j),rotulos_treinamento_mao(:,k,j));
        [precisao_treinamento(k,j), matriz_confusao_treinamento] = calcular_precisao_mao(modelo,matriz_treinamento_mao(:,:,k,j),rotulos_treinamento_mao(:,k,j));
        [precisao_teste(k,j), matriz_confusao_teste] = calcular_precisao_mao(modelo,matriz_teste_mao(:,:,k,j),rotulos_teste_mao(:,k,j));
    end
    toc
end

% Trocando parte dos r�tulos de treinamento para verificar precis�o
% 1/n ser� a parte do total em que os r�tulos ser�o invertidos
n = 4;
rotulos_treinamento_mao(1:round(end/n),:,:) = not(rotulos_treinamento_mao(1:round(end/n),:,:));


for j = 1:length(porcentagem_ruido)
    tic
    j
    for k = 1:num_amostras
        [precisao_treinamento_modificado(k,j), matriz_confusao_treinamento] = calcular_precisao_mao(modelo,matriz_treinamento_mao(:,:,k,j),rotulos_treinamento_mao(:,k,j));
    end
    toc
end


media_precisao_treinamento = mean(precisao_treinamento);
media_precisao_teste = mean(precisao_teste);
media_precisao_treinamento_modificado = mean(precisao_treinamento_modificado);



% Plotando m�dia das precis�es obtidas para cada quantidade de ru�do
figure();
p = plot(porcentagem_ruido,media_precisao_treinamento_modificado,porcentagem_ruido,media_precisao_teste);
axis([0 inf 0 100]);
legend('Treinamento','Teste');
xlabel('Ru�do');
ylabel('Precis�o [%]');
set(p(1),'LineWidth',4,'Color','b');
set(p(2),'LineWidth',4,'Color','g');
grid on;


save('resultados_mao_ruidos_somente_teste_10_03_2018','porcentagem_ruido','media_precisao_treinamento','media_precisao_teste');




