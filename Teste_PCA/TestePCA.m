% Testes com PCA

clear;
close all;
clc;


load('dados_treinamento_mao.mat');

[coeff,matriz_treinamento_pca,latent,tsquared,explained,mu] = pca(double(matriz_treinamento_mao));
figure;
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

matriz_treinamento_pca = matriz_treinamento_mao*coeff(:,1:2);
matriz_teste_pca = matriz_teste_mao*coeff(:,1:2);
% figure;
% scatter3(matriz_teste_pca(:,1),matriz_teste_pca(:,2),matriz_teste_pca(:,3),[],rotulos_teste_mao(:),'LineWidth',2)
% axis equal
% xlabel('1st Principal Component')
% ylabel('2nd Principal Component')
% zlabel('3rd Principal Component')
% figure;
% scatter(matriz_teste_pca(:,1),matriz_teste_pca(:,2),[],rotulos_teste_mao(:),'LineWidth',2)
% axis equal
% xlabel('1st Principal Component')
% ylabel('2nd Principal Component')

% matriz_treinamento_pca = matriz_treinamento_mao;
% matriz_teste_pca = matriz_teste_mao;

whos('matriz_treinamento_pca')
whos('matriz_teste_pca')
% Cria��o dos modelos para classifica��o das imagens;
% ver fun��o "svm_multiclasse"
modelo = svm_multiclasse(matriz_treinamento_pca,rotulos_treinamento_mao);
[precisao_treinamento, matriz_confusao_treinamento] = calcular_precisao_mao(modelo,matriz_treinamento_pca,rotulos_treinamento_mao)
[precisao_teste, matriz_confusao_teste] = calcular_precisao_mao(modelo,matriz_teste_pca,rotulos_teste_mao)

