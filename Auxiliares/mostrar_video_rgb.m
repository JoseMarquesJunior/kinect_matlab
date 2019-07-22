%%
%Fun��o que mostra v�deo utilizando o stream de profundidade (depth)
%Devem ser passados como par�metros [himg colorVid depthVid] que s�o
%obtidos:
%   [himg colorVid depthVid] = iniciar_kinect;

function [colorMap,colorMetaData] = mostrar_video_rgb (colorVid)

trigger(colorVid);
[colorMap,~,colorMetaData] = getdata(colorVid);
imshow(colorMap, [0 4096]);