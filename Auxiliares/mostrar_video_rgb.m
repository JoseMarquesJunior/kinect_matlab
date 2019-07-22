%%
%Função que mostra vídeo utilizando o stream de profundidade (depth)
%Devem ser passados como parâmetros [himg colorVid depthVid] que são
%obtidos:
%   [himg colorVid depthVid] = iniciar_kinect;

function [colorMap,colorMetaData] = mostrar_video_rgb (colorVid)

trigger(colorVid);
[colorMap,~,colorMetaData] = getdata(colorVid);
imshow(colorMap, [0 4096]);