function [roi] = gerar_roi (depthMetaData,idx)
% Essa fun��o retorna os limites da regi�o de interesse (m�o). Recebe como
% par�metros os metadados fornecidos pelo Kinect e o �ndice da pessoa
% localizada. � realizada uma compensas�o do tamanho em fun��o da
% profundidade da m�o (dist�ncia da m�o at� o sensor).

% vari�vel 'mao_direita' recebe o pixel referente � posi��o da m�o
mao_direita = depthMetaData.JointImageIndices(12,:,idx);

% coordenada global da m�o
mao_direita_coord_glob = depthMetaData.JointWorldCoordinates(12,:,idx); 
profundidade = norm(mao_direita_coord_glob);
raio = round(90-profundidade / 50);

% limites gerados para a regi�o de interesse
roi = round([mao_direita(2)-1*raio; mao_direita(2)+0.25*raio; ...
    mao_direita(1)-0.25*raio; mao_direita(1)+0.75*raio]);
roi(roi<=0) = 1;
end