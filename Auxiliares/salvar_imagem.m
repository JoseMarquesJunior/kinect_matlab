function salvar_imagem(imagem,depthMetaData)
% Essa fun��o grava a imagem passada como par�metro no diret�rio de
% execu��o. Os metadados s�o utilizados para nomear o arquivo (o nome da
% imagem salva � referente a data e a hora).

figure(2);
imshow(imagem);
abs_time = depthMetaData.AbsTime;
imwrite(imagem,['img_' num2str(round(abs_time(1))) num2str(round(abs_time(2))) num2str(round(abs_time(3))) num2str(round(abs_time(4))) num2str(round(abs_time(5))) num2str(round(100*abs_time(6))) '.png']);
delete(figure(2));
end

