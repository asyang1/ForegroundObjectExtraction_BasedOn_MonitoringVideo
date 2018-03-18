clear;
DIR='D:\数学建模\比赛\data\question3\people1\pre-picture\';        %图片所在文件夹
file=dir(strcat(DIR,'*.jpg'));                %读取所有jpg文件
filenum=size(file,1);                         %图片总数

change = cell(filenum,1);
%1-10张背景图
N = 20;
for current = 1:10
    fname = strcat(DIR, num2str(current), '.jpg');
    frame = imread(fname);
    changeframe  = frame;
%     imshow(changeframe);
    fname = strcat(DIR, num2str(30), '.jpg');
    frame = imread(fname);
    exampleframe = frame;
%     imshow(exampleframe);
            for i = 80 :183
                for j = 120:210
                    changeframe(i,j) = exampleframe(i+3,j+70);
                end
            end
%     imshow(changeframe);
    change{current} = changeframe;
end

%11-20张
move = 1;
for current = 11:20
    fname = strcat(DIR, num2str(current), '.jpg');
    frame = imread(fname);
    changeframe  = frame;
%     imshow(changeframe);
    fname = strcat(DIR, num2str(40), '.jpg');
    frame = imread(fname);
    exampleframe = frame;
%     imshow(exampleframe);
    
    for i = 77 :180
        for j = 125:184
            changeframe(i,j) = exampleframe(i+10+fix(move),j+20) ;
        end
    end
%     imshow(changeframe);
    change{current} = changeframe;
    move = move +0.3;
end

%21到30张
move = 0;
for current = 21:30
    fname = strcat(DIR, num2str(current), '.jpg');
    frame = imread(fname);
    changeframe  = frame;
%     imshow(changeframe);
    fname = strcat(DIR, num2str(1), '.jpg');
    frame = imread(fname);
    exampleframe = frame;
%     imshow(exampleframe);
    for i = 75 :172
        for j = 120:179
            changeframe(i,j) = exampleframe(i+2 - fix(move),j-65) ;
        end
    end
%     imshow(changeframe);
    change{current} = changeframe;
    move = move +0.6
end


%31到40张
move = 0;
move1 = 0;
for current = 31:40
    fname = strcat(DIR, num2str(current), '.jpg');
    frame = imread(fname);
    changeframe  = frame;
%     imshow(changeframe);
    fname = strcat(DIR, num2str(1), '.jpg');
    frame = imread(fname);
    exampleframe = frame;
%     imshow( exampleframe);
    for i = 80 :180
        for j = 91:160
            changeframe(i+fix(move),j-fix(move1)) = exampleframe(i-5,j-76) ;
        end
    end
    imshow(changeframe);
    change{current} = changeframe;
    move = move+0.7;
    move1 =move1+3; 
end

% mean = (changeframe1+changeframe2+changeframe3)/3;

DIR2='D:\数学建模\比赛\data\question3\people1\increase\';     %单帧图片所在文件夹
for i = 1:N
    for num = 1:filenum
        fname = strcat(DIR2, num2str(num+filenum*2*(i-1)), '.jpg');
        imwrite(change{num,1},fname);
    end
    back = 1;
     for num = filenum:-1:1
        fname = strcat(DIR2, num2str(back+filenum+filenum*2*(i-1)), '.jpg');
        imwrite(change{num,1},fname);
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
for num = 2*filenum*N +1:2*filenum*N+ filenum
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

obj_gray = VideoWriter('D:\数学建模\比赛\data\question3\people1\increase-person1.avi');   %所转换成的视频名称
writerFrames = filenum;                       %视频帧数

%将单张图片存在avi文件
open(obj_gray);
for k = 1: writerFrames 
    fname = strcat(DIR2, num2str(k), '.jpg');
    frame = imread(fname);
    writeVideo(obj_gray, frame);
end
close(obj_gray);
