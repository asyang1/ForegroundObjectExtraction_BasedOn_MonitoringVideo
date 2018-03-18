DIR='D:\数学建模\比赛\data\question4\overpass\';        %图片所在文件夹
fname = strcat(DIR, 'pre-228.jpg');
a1 = imread(fname);
fname = strcat(DIR, '228.jpg');
a2 = imread(fname);
fname = strcat(DIR, 'pre-604.jpg');
b1 = imread(fname);
fname = strcat(DIR, '604.jpg');
b2= imread(fname);
fname = strcat(DIR, 'pre-2478.jpg');
c1 = imread(fname);
fname = strcat(DIR, '2478.jpg');
c2 = imread(fname);

% [r,v] = size(modified);
% % for  i = 1:r
% %     for j = 1:v
% %         if i>60 && i<240 && j >110&&j<180
% %            continue;
% %         else 
% %             modified(i,j) = 0;
% %         end
% %     end
% % end
% result = pre;
% for  i = 1:r
%     for j = 1:v
%         if modified(i,j) == 0
%             result(i,j) = 0;
%         end
% %         if result(i,j) >180
% %             result(i,j) = 0;
% %         end
%     end
% end

subplot(3,2,1);imshow(a1);title('原图1');
subplot(3,2,2);imshow(a2);title('对比图1');
subplot(3,2,3);imshow(b1);title('原图2');
subplot(3,2,4);imshow(b2);title('对比图2');
subplot(3,2,5);imshow(c1);title('原图3');
subplot(3,2,6);imshow(c2);title('对比图3');