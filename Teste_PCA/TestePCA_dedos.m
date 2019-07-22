% Testes com PCA

clear;
close all;
clc;


load('dados_treinamento_dedos.mat');

[coeff,matriz_treinamento_pca,latent,tsquared,explained,mu] = pca(double(matriz_treinamento_dedos));
figure;
scatter3(matriz_treinamento_pca(:,1),matriz_treinamento_pca(:,2),matriz_treinamento_pca(:,3),[],rotulos_treinamento_dedos(:),'LineWidth',2)
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')
figure;
scatter(matriz_treinamento_pca(:,1),matriz_treinamento_pca(:,2),[],rotulos_treinamento_dedos(:),'LineWidth',2)
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')

matriz_teste_pca = matriz_teste_dedos*coeff;
figure;
scatter3(matriz_teste_pca(:,1),matriz_teste_pca(:,2),matriz_teste_pca(:,3),[],rotulos_teste_dedos(:),'LineWidth',2)
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')
figure;
scatter(matriz_teste_pca(:,1),matriz_teste_pca(:,2),[],rotulos_teste_dedos(:),'LineWidth',2)
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
