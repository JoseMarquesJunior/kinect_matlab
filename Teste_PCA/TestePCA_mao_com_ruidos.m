% Testes com PCA

clear;
close all;
clc;


load('dados_treinamento_mao_15_03_2018.mat');

matriz_treinamento_mao = double(matriz_treinamento_mao);
matriz_teste_mao = double(matriz_teste_mao);

[coeff,score,latent,tsquared,explained,mu] = pca(matriz_treinamento_mao);
figure;
matriz_treinamento_pca = matriz_treinamento_mao*coeff;
scatter3(matriz_treinamento_pca(:,1),matriz_treinamento_pca(:,2),matriz_treinamento_pca(:,3),[],rotulos_treinamento_mao(:),'LineWidth',2)
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')
figure;
scatter(matriz_treinamento_pca(:,1),matriz_treinamento_pca(:,2),[],rotulos_treinamento_mao(:),'LineWidth',2)
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')


matriz_teste_pca = matriz_teste_mao*coeff;

figure;
scatter3(matriz_teste_pca(:,1),matriz_teste_pca(:,2),matriz_teste_pca(:,3),[],rotulos_teste_mao(:),'LineWidth',2)
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')
figure;
scatter(matriz_teste_pca(:,1),matriz_teste_pca(:,2),[],rotulos_teste_mao(:),'LineWidth',2)
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')

% n = size(coeff,2);
% for i = 1:n
%     % Criação dos modelos para classificação das imagens;
%     % ver função "svm_multiclasse"
%     i
%     tic
%     try
%         matriz_treinamento_pca = matriz_treinamento_mao*coeff(:,1:i);
%         matriz_teste_pca = matriz_teste_mao*coeff(:,1:i);
%         modelo = svm_multiclasse(matriz_treinamento_pca,rotulos_treinamento_mao);
%         [precisao_treinamento(i), ~] = calcular_precisao_mao(modelo,matriz_treinamento_pca,rotulos_treinamento_mao);
%         [precisao_teste(i), ~] = calcular_precisao_mao(modelo,matriz_teste_pca,rotulos_teste_mao);
%     catch
%         precisao_treinamento(i) = precisao_treinamento(i-1);
%         precisao_teste(i) = precisao_teste(i-1);
%         continue
%     end
%     toc
% end
% 
% vetor = 1:n;
% figure;
% p = plot(vetor,precisao_treinamento,vetor,precisao_teste);
% axis([1 60 0 100]);
% legend('Treinamento','Teste');
% xlabel('Dimensões');
% ylabel('Precisão [%]');
% set(p(1),'LineWidth',4,'Color','b');
% set(p(2),'LineWidth',4,'Color','g');
% grid on;


