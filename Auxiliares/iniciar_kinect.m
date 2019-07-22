function [himg, colorVid, depthVid] = iniciar_kinect ()

% Fun��o para iniciar o kinect. Retorna himg (auxiliar para tratamento dos
% dados) e os streamins de cor e profundidade.

% Desconecta e reseta todos os dispositivos de aquisi��o de imagens
imaqreset

% Configura��es para obten��o dos dados do Kinect
colorVid = videoinput('kinect',1);
depthVid = videoinput('kinect',2);
triggerconfig([colorVid depthVid],'manual');

depthVid.FramesPerTrigger = 1;
colorVid.FramesPerTrigger = 1;
depthVid.TriggerRepeat = inf;
colorVid.TriggerRepeat = inf;

set(getselectedsource(depthVid), 'TrackingMode', 'Skeleton');

start(depthVid);
start(colorVid);

% Retorna objeto de imagem
himg = figure;
end