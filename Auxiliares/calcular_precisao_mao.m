function [precisao, matriz_confusao] = calcular_precisao_mao(modelos,BancoTeste,RotulosTeste)

% Testando o modelo criado e gerando o vetor de resultados:
resultado_classificacao = 7*ones(length(RotulosTeste),1);
for i=1:length(RotulosTeste)
    for k=1:length(modelos)
        if(svmclassify(modelos(k),BancoTeste(i,:)))
            break;
        end
    end
    resultado_classificacao(i) = k-1;
end

% Criando a matriz de confusão
matriz_confusao = confusionmat(RotulosTeste,resultado_classificacao);


% A precisão será a soma da diagonal principal dividido pelo total de
% elementos
precisao = 100*trace(matriz_confusao)/sum(sum(matriz_confusao));

