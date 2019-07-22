%%
%Fun��o que mostra v�deo utilizando o stream de profundidade (depth)
%Devem ser passados como par�metros [himg colorVid depthVid] que s�o
%obtidos:
%   [himg colorVid depthVid] = iniciar_kinect;

function [depthMap,depthMetaData] = mostrar_video_profundidade (depthVid)

trigger(depthVid);
[depthMap,~,depthMetaData] = getdata(depthVid);
imshow(depthMap, [0 4096]);
