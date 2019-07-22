function [modelos] = svm_multiclasse(BancoTreinamento,RotulosTreinamento)
% Essa fun��o cria um modelo para classifica��o dado um conjunto de
% treinamento e seus grupos correspondentes. Utiliza um SVM de classe �nica
% para classifica��o multiclasse.

% Conta a quantidade de classe:
u=unique(RotulosTreinamento);
numClasses=length(u);

% Cria um modelo para cada classe:
options.MaxIter = 1000000;
for k=1:numClasses
    G1vAll=(RotulosTreinamento==u(k));
    modelos(k) = svmtrain(BancoTreinamento,G1vAll,'Options', options);
end
