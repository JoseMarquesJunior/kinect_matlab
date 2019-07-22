%% Testando dados da mão com ruídos
% Utilizar o MATLAB 2013

% É necessário configurar o incremento de ruído e quantidade amostras por
% ruído nas linhas 28 e 29.

% As mesmas configurações de 'porcentagem_ruído' e 'num_amostras' devem ser
% as mesmas utilizadas na geração dos dados com ruído.

clear all;
close all;
clc;

% Carregando dados para treinamento do modelo
load('dados_treinamento_mao_ruido_somente_teste_09_03_2018.mat');

matriz_treinamento_mao = double(matriz_treinamento_mao);
matriz_teste_mao = double(matriz_teste_mao);

% Configurando porcentagem de ruído desejada (deve ser configurado da mesma
% forma que na geração dos dados com ruídos)
porcentagem_ruido = 0:0.2:1;
num_amostras = 4;

% Criação dos modelos para classificação das imagens;
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

% Trocando parte dos rótulos de treinamento para verificar precisão
% 1/n será a parte do total em que os rótulos serão invertidos
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



% Plotando média das precisões obtidas para cada quantidade de ruído
figure();
p = plot(porcentagem_ruido,media_precisao_treinamento_modificado,porcentagem_ruido,media_precisao_teste);
axis([0 inf 0 100]);
legend('Treinamento','Teste');
xlabel('Ruído');
ylabel('Precisão [%]');
set(p(1),'LineWidth',4,'Color','b');
set(p(2),'LineWidth',4,'Color','g');
grid on;


save('resultados_mao_ruidos_somente_teste_10_03_2018','porcentagem_ruido','media_precisao_treinamento','media_precisao_teste');




