clear; clc; close all;
DIR='D:\数学建模\比赛\data\question4\overpass\aft-picture\';        %图片所在文件夹
file=dir(strcat(DIR,'*.jpg'));                %读取所有jpg文件
filenum=size(file,1);                         %图片总数

flag= 1;
for num = 1:filenum 
    fname = strcat(DIR, num2str(num), '.jpg');
    frame = imread(fname);
    
    %使用中值滤波去噪
    for i = 1:20 
        modified_frame= medfilt2(frame,[3,3]);
    end
    
    %膨胀
    for i = 1:3
        se = strel('square',2);  
        modified_frame =imdilate(modified_frame,se);
    end
    
    %除去小面积
    modified_frame = bwareaopen(modified_frame/256,150);  
    
    %填洞
    modified_frame=imfill( modified_frame,'holes');
    
    imshow(modified_frame);
    imwrite(modified_frame,strcat('D:\数学建模\比赛\data\question4\overpass\modified\',num2str(flag),'.jpg'),'jpg');
    flag = flag+1;
end