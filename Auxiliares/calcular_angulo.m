function [angulo_cotovelo, vetor_angulo] = calcular_angulo (depthMetaData,idx,vetor_angulo)
% Fun��o que retorna o �ngulo formando pelo cotovelo esquerdo e vetor que
% contem a sequ�ncia dos �ltimos �ngulos calculados.
% vetor_angulo � um vetor auxiliar para o c�lculo que deve ser passado como
% par�metro; possui o tamanho configurado na vari�vel buffer no programa
% principal; sua fun��o � suavizar a sa�da do �ngulo calculado; o resultado
% final � a m�dia dos elementos contido no vetor_angulo.

% Posi��es referentes ao ombro, cotovelo e pulso capturadas pelo Kinect.
pos_glob_ombro = depthMetaData.JointWorldCoordinates(5,:,idx);
pos_glob_cotovelo = depthMetaData.JointWorldCoordinates(6,:,idx);
pos_glob_pulso = depthMetaData.JointWorldCoordinates(7,:,idx);

% Estes vetores representam o bra�o e o antebra�o:
vetor1 = pos_glob_ombro-pos_glob_cotovelo;
vetor2 = pos_glob_pulso-pos_glob_cotovelo;

% C�lculo do �ngulo atual:
ang_cotovelo  = radtodeg(atan2(norm(cross(vetor1,vetor2)),dot(vetor1,vetor2)));

% Atualiza��o do vetor: � retirado o primeiro elemento (o mais antigo) e
% adicionado o novo �ngulo
vetor_angulo = [vetor_angulo(2:end) ang_cotovelo];

% O �ngulo de sa�da ser� a m�dia de todos os elementos do vetor, suavizando
% poss�veis mudan�as bruscas.
angulo_cotovelo = mean(vetor_angulo);
end