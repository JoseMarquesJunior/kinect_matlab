function [classe] = classificar_imagem(imagem, modelo)

% Esse script recebe a imagem j� tratada e o modelo a ser utilizado na classifica��o. O retorno � a classe prevista pelo modelo.

% Transforma��o da imagem em uma matriz de double's.
imagem = double(imagem);

% Classifica��o
for k=1:length(modelo)
    if(svmclassify(modelo(k),imagem(:)'))
        break;
    end
end
classe = k;
end