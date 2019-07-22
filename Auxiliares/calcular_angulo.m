function [angulo_cotovelo, vetor_angulo] = calcular_angulo (depthMetaData,idx,vetor_angulo)
% Função que retorna o ângulo formando pelo cotovelo esquerdo e vetor que
% contem a sequência dos últimos ângulos calculados.
% vetor_angulo é um vetor auxiliar para o cálculo que deve ser passado como
% parâmetro; possui o tamanho configurado na variável buffer no programa
% principal; sua função é suavizar a saída do ângulo calculado; o resultado
% final é a média dos elementos contido no vetor_angulo.

% Posições referentes ao ombro, cotovelo e pulso capturadas pelo Kinect.
pos_glob_ombro = depthMetaData.JointWorldCoordinates(5,:,idx);
pos_glob_cotovelo = depthMetaData.JointWorldCoordinates(6,:,idx);
pos_glob_pulso = depthMetaData.JointWorldCoordinates(7,:,idx);

% Estes vetores representam o braço e o antebraço:
vetor1 = pos_glob_ombro-pos_glob_cotovelo;
vetor2 = pos_glob_pulso-pos_glob_cotovelo;

% Cálculo do ângulo atual:
ang_cotovelo  = radtodeg(atan2(norm(cross(vetor1,vetor2)),dot(vetor1,vetor2)));

% Atualização do vetor: é retirado o primeiro elemento (o mais antigo) e
% adicionado o novo ângulo
vetor_angulo = [vetor_angulo(2:end) ang_cotovelo];

% O ângulo de saída será a média de todos os elementos do vetor, suavizando
% possíveis mudanças bruscas.
angulo_cotovelo = mean(vetor_angulo);
end