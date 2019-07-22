function [modelos] = svm_multiclasse(BancoTreinamento,RotulosTreinamento)
% Essa função cria um modelo para classificação dado um conjunto de
% treinamento e seus grupos correspondentes. Utiliza um SVM de classe única
% para classificação multiclasse.

% Conta a quantidade de classe:
u=unique(RotulosTreinamento);
numClasses=length(u);

% Cria um modelo para cada classe:
options.MaxIter = 1000000;
for k=1:numClasses
    G1vAll=(RotulosTreinamento==u(k));
    modelos(k) = svmtrain(BancoTreinamento,G1vAll,'Options', options);
end
