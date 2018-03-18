%将所有单帧图片转换为向量存储为mat文件
clear
clc

DIR='D:\数学建模\比赛\data\question2\waterSurface\modified\';     %单帧图片所在文件夹
file=dir(strcat(DIR,'*.jpg'));             %读取图片所在文件所有jpg文件
filenum=size(file,1);                      %图片个数

fname = strcat(DIR, num2str(1), '.jpg');   %第一张图片的文件名
frame = imread(fname);                     %读取第一张图片
rows = size(frame(:),1);                   %单张图片的总像素个数
XX = zeros(rows, filenum);                 %将所有图片拉成矩阵时的维数
%将所有图片存为一矩阵
for k = 1: filenum
    fname = strcat(DIR, num2str(k), '.jpg');
    frame = imread(fname);
    x = frame(:);
    XX(:, k) = x;
    %writeVideo(obj_gray, frame);
end
%将视频矩阵及其行列数存在obj对象
obj.XX = uint8(XX);
obj.siz = size(frame);
% save campus5 obj                           %将obj对象存为mat文件