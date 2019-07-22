%% Testando dados do contador de dedos com ruído
% Utilizar o MATLAB 2013

% É necessário configurar o incremento de ruído e quantidade amostras por
% ruído nas linhas 28 e 29.

% As mesmas configurações de 'porcentagem_ruído' e 'num_amostras' devem ser
% as mesmas utilizadas na geração dos dados com ruído.

clear all;
close all;
clc;

% Carregando dados para treinamento do modelo
load('dados_treinamento_dedos_ruidos_somente_teste_10_03_2018.mat');

matriz_treinamento_dedos = single(matriz_treinamento_dedos);
matriz_teste_dedos = single(matriz_teste_dedos);
rotulos_treinamento_dedos = single(rotulos_treinamento_dedos);
rotulos_teste_dedos = single(rotulos_teste_dedos);

% Configurando porcentagem de ruído desejada (deve ser configurado da mesma
% forma que na geração dos dados com ruídos)
porcentagem_ruido = 0:0.02:1;
num_amostras = 10;

% Criação dos modelos para classificação das imagens;
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

% Plotando média das precisões obtidas para cada quantidade de ruído
figure();
p = plot(porcentagem_ruido,media_precisao_treinamento,porcentagem_ruido,media_precisao_teste);
axis([0 inf 0 100]);
legend('Treinamento','Teste');
xlabel('Ruído');
 ylabel('Precisão [%]');
set(p(1),'LineWidth',4,'Color','b');
set(p(2),'LineWidth',4,'Color','g');
grid on;


save('resultados_dedos_ruidos_somente_teste_10_03_2018','porcentagem_ruido','media_precisao_treinamento','media_precisao_teste');
