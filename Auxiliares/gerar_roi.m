function [roi] = gerar_roi (depthMetaData,idx)
% Essa função retorna os limites da região de interesse (mão). Recebe como
% parâmetros os metadados fornecidos pelo Kinect e o índice da pessoa
% localizada. É realizada uma compensasão do tamanho em função da
% profundidade da mão (distância da mão até o sensor).

% variável 'mao_direita' recebe o pixel referente à posição da mão
mao_direita = depthMetaData.JointImageIndices(12,:,idx);

% coordenada global da mão
mao_direita_coord_glob = depthMetaData.JointWorldCoordinates(12,:,idx); 
profundidade = norm(mao_direita_coord_glob);
raio = round(90-profundidade / 50);

% limites gerados para a região de interesse
roi = round([mao_direita(2)-1*raio; mao_direita(2)+0.25*raio; ...
    mao_direita(1)-0.25*raio; mao_direita(1)+0.75*raio]);
roi(roi<=0) = 1;
end