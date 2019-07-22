%%
%Função que mostra vídeo utilizando o stream de profundidade (depth)
%Devem ser passados como parâmetros [himg colorVid depthVid] que são
%obtidos:
%   [himg colorVid depthVid] = iniciar_kinect;

function [depthMap,depthMetaData] = mostrar_video_profundidade (depthVid)

trigger(depthVid);
[depthMap,~,depthMetaData] = getdata(depthVid);
imshow(depthMap, [0 4096]);
