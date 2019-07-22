%% Testando dados do contador de dedos com ru�do
% Utilizar o MATLAB 2013

% � necess�rio configurar o incremento de ru�do e quantidade amostras por
% ru�do nas linhas 28 e 29.

% As mesmas configura��es de 'porcentagem_ru�do' e 'num_amostras' devem ser
% as mesmas utilizadas na gera��o dos dados com ru�do.

clear all;
close all;
clc;

% Carregando dados para treinamento do modelo
load('dados_treinamento_dedos_ruidos_somente_teste_10_03_2018.mat');

matriz_treinamento_dedos = single(matriz_treinamento_dedos);
matriz_teste_dedos = single(matriz_teste_dedos);
rotulos_treinamento_dedos = single(rotulos_treinamento_dedos);
rotulos_teste_dedos = single(rotulos_teste_dedos);

% Configurando porcentagem de ru�do desejada (deve ser configurado da mesma
% forma que na gera��o dos dados com ru�dos)
porcentagem_ruido = 0:0.02:1;
num_amostras = 10;

% Cria��o dos modelos para classifica��o das imagens;
for j = 1:length(porcentagem_ruido)
    tic
    j
    for k = 1:num_amostras
        modelo = svm_multiclasse(matriz_treinamento_dedos(:,:,k,j),rotulos_treinamento_dedos(:,k,j));
        [precisao_treinamento(k,j), ~] = calcular_precisao_dedos(modelo,matriz_treinamento_dedos(:,:,k,j),rotulos_treinamento_dedos(:,k,j));
        [precisao_teste(k,j), ~] = calcular_precisao_dedos(modelo,matriz_teste_dedos(:,:,k,j),rotulos_teste_dedos(:,k,j));
    end
    toc
end

media_precisao_treinamento = mean(precisao_treinamento);
media_precisao_teste = mean(precisao_teste);

% Plotando m�dia das precis�es obtidas para cada quantidade de ru�do
figure();
p = plot(porcentagem_ruido,media_precisao_treinamento,porcentagem_ruido,media_precisao_teste);
axis([0 inf 0 100]);
legend('Treinamento','Teste');
xlabel('Ru�do');
 ylabel('Precis�o [%]');
set(p(1),'LineWidth',4,'Color','b');
set(p(2),'LineWidth',4,'Color','g');
grid on;


save('resultados_dedos_ruidos_somente_teste_10_03_2018','porcentagem_ruido','media_precisao_treinamento','media_precisao_teste');
