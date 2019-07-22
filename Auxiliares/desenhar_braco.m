function desenhar_braco(skeletonJoints)
% Essa função desenha no vídeo as posições do braço e do antebraço

% Posições das articulações
posicao_ombro = skeletonJoints(5,:);
posicao_cotovelo = skeletonJoints(6,:);
posicao_pulso = skeletonJoints(7,:);

% Primeira linha
X1 = [posicao_ombro(1,1) posicao_cotovelo(1,1)];
Y1 = [posicao_ombro(1,2) posicao_cotovelo(1,2)];
line(X1,Y1, 'LineWidth', 5, 'LineStyle', '-', 'Marker', '+', 'Color', 'r');

% Segunda linha
X1 = [posicao_cotovelo(1,1) posicao_pulso(1,1)];
Y1 = [posicao_cotovelo(1,2) posicao_pulso(1,2)];
line(X1,Y1, 'LineWidth', 5, 'LineStyle', '-', 'Marker', '+', 'Color', 'g');
end