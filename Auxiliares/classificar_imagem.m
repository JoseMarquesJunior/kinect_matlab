function [classe] = classificar_imagem(imagem, modelo)

% Esse script recebe a imagem já tratada e o modelo a ser utilizado na classificação. O retorno é a classe prevista pelo modelo.

% Transformação da imagem em uma matriz de double's.
imagem = double(imagem);

% Classificação
for k=1:length(modelo)
    if(svmclassify(modelo(k),imagem(:)'))
        break;
    end
end
classe = k;
end