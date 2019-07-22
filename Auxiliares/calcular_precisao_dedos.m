function [precisao, matriz_confusao] = calcular_precisao_dedos(modelos,BancoTeste,RotulosTeste)

RotulosTeste = single(RotulosTeste);

% Testando o modelo criado e gerando o vetor de resultados:
resultado_classificacao = 7*ones(length(RotulosTeste),1);
for i=1:length(RotulosTeste)
    for k=1:length(modelos)
        if(svmclassify(modelos(k),BancoTeste(i,:)))
            break;
        end
    end
    resultado_classificacao(i) = k;
end

% Acertando as classes (o modelo classifica entre classe 1, 2 e 3; no nosso
% caso, a classe 2 refere-se a 3 e classe 3 refere-se a 5:
resultado_classificacao = single(resultado_classificacao);
resultado_classificacao(resultado_classificacao==3) = 5;
resultado_classificacao(resultado_classificacao==2) = 3;

% Criando a matriz de confusão
matriz_confusao = confusionmat(RotulosTeste,resultado_classificacao);

% A precisão será a soma da diagonal principal dividido pelo total de
% elementos
precisao = 100*trace(matriz_confusao)/sum(sum(matriz_confusao));





