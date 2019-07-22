function [imagem_preto_branco] = tratar_imagem(depthMap,limites)
% Esse script utiliza os dados das articula��es fornecidos pelo Kinect para gerar a imagem binarizada para classifica��o. 

% Utiliza��o da imagem de profundidade:
img_profundidade = double(depthMap(limites(1):limites(2),limites(3):limites(4)));

% Normaliza��o da imagem: 
min_matriz = min(min(img_profundidade));
img_profundidade = ((img_profundidade)-min_matriz);
max_matriz = max(max(img_profundidade));
img_profundidade =  img_profundidade / max_matriz;

% Cria��o da imagem em escala de cinza a partir da matriz
img = mat2gray(img_profundidade);

% Transforma��o em preto e branco utilizando o valor m�dio da imagem como limiar para binariza��o
imagem_preto_branco = im2bw(img,mean(mean(img)));
imagem_preto_branco = imresize(imagem_preto_branco, [70 70]);
end

