clear;
DIR='D:\数学建模\比赛\data\question5\pre-picture\';        %图片所在文件夹
% file=dir(strcat(DIR,'*.jpg'));                %读取所有jpg文件
filenum1= 30;                         %背景图片总数

DIR2='D:\数学建模\比赛\data\question5\background\';     %单帧图片所在文件夹
N = 30;

for i = 1:N
     for num = 1:filenum1
        fname = strcat(DIR, num2str(num), '.jpg');
        frame = imread(fname); 
        fname = strcat(DIR2, num2str(num+filenum1*2*(i-1)), '.jpg');
        imwrite(frame,fname);
     end
     back = 1;
     for num = filenum1:-1:1
        fname = strcat(DIR, num2str(num), '.jpg');
        frame = imread(fname); 
        fname = strcat(DIR2, num2str(back+30+filenum1*2*(i-1)), '.jpg');
        imwrite(frame,fname);
        back = back+1;
     end
end

% fname = strcat(DIR2, '0.jpg');
% imwrite(mean,fname);


% % DIR2='D:\数学建模\比赛\data\question3\cars6\aft-picture\';     %单帧图片所在文件夹
% for i = N*(sample-1) +1:N*(sample-1) + N
%     fname = strcat(DIR2, num2str(i), '.jpg');
%     imwrite(changeframe,fname);
% end
% 
% 
% 
% % DIR2='D:\数学建模\比赛\data\question3\cars6\aft-picture\';     %单帧图片所在文件夹
% for i = N*(sample-1) +1:N*(sample-1) + N
%     fname = strcat(DIR2, num2str(i), '.jpg');
%     imwrite(changeframe,fname);
% end



% DIR2='D:\数学建模\比赛\data\question3\cars6\aft-picture\';     %单帧图片所在文件夹
i = 1;
file=dir(strcat(DIR,'*.jpg'));                %读取所有jpg文件
filenum=size(file,1);                         %图片总数
for num = 2*filenum1*N +1:2*filenum1*N+ filenum
    fname = strcat(DIR, num2str(i), '.jpg');
    frame = imread(fname);
    fname = strcat(DIR2, num2str(num), '.jpg');
    imwrite(frame,fname);
    i = i+1;
end

%将所有单帧图片转换为视频
% DIR2='D:\数学建模\比赛\data\question3\cars6\increase\';        %图片所在文件夹
file=dir(strcat(DIR2,'*.jpg'));                %读取所有jpg文件
filenum=size(file,1);                         %图片总数

obj_gray = VideoWriter('D:\数学建模\比赛\data\question5\increase_boom.avi');   %所转换成的视频名称
writerFrames = filenum;                       %视频帧数

%将单张图片存在avi文件
open(obj_gray);
for k = 1: writerFrames 
    fname = strcat(DIR2, num2str(k), '.jpg');
    frame = imread(fname);
    writeVideo(obj_gray, frame);
end
close(obj_gray);
