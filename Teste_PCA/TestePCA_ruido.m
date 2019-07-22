% Testes com PCA

clear;
close all;
clc;


load('dados_treinamento_mao_15_03_2018.mat');

[coeff,score,latent,tsquared,explained,mu] = pca(double(matriz_treinamento_mao));
figure;
scatter3(score(:,1),score(:,2),score(:,3),[],rotulos_treinamento_mao(:),'LineWidth',2)
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')
figure;
scatter(score(:,1),score(:,2),[],rotulos_treinamento_mao(:),'LineWidth',2)
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
