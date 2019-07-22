%% 
%
% Script que mostra v�deos de cor e profundidade ao mesmo tempo
clear all;
close all;
clc;

% Desconecta e deleta todos os objetos de aquisi��o de imagens
imaqreset

% Cria os objetos de entrada de v�deo - cor e profundidade
colorVid = videoinput('kinect',1);
depthVid = videoinput('kinect',2); 

% Configura��o das entradas de v�deos:
triggerconfig([colorVid depthVid],'manual');
depthVid.FramesPerTrigger = 1;
colorVid.FramesPerTrigger = 1;
depthVid.TriggerRepeat = inf;
colorVid.TriggerRepeat = inf;

% Inicia o streaming de v�deo:
start([colorVid depthVid]);             
himg = figure;

%%
% Loop 'while' para cada imagem obtida pelo Kinect
while(ishandle(himg))
    % Aciona o trigger simultaneamente
    trigger([colorVid depthVid]);       
    
    % Obtem os dados de imagem de cor e profundidade
    [depthMap,colorTimeData,depthMetaData] = getdata(depthVid);
    [colorMap,depthTimeData,colorMetaData] = getdata(colorVid);
    
    % Mostra na tela os v�deos obtidos
    subplot(1,2,1), imshow(depthMap, [0 4096]);
    subplot(1,2,2), imshow(colorMap, [0 4096]);
end