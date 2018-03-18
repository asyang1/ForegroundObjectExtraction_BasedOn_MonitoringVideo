clear;
frame = imread('D:\数学建模\比赛\data\question4\hall\pre-picture\pre-picture1.jpg'); 
imshow(frame);
% hold on;
 for i = 1:36
     for j = 1 : 22 
         if i==1
             frame(i,j) = 0;
             plot(j,i,'co','MarkerSize',10,'MarkerSize',5,'MarkerEdgeColor','c','MarkerFaceColor','c');
             hold on;
         end
          if j==1
             frame(i,j) = 0;
              plot(j,i,'co','MarkerSize',10,'MarkerSize',5,'MarkerEdgeColor','c','MarkerFaceColor','c');
              hold on;
          end
          if i==36
             frame(i,j) = 0;
             plot(j,i,'co','MarkerSize',10,'MarkerSize',5,'MarkerEdgeColor','c','MarkerFaceColor','c');
             hold on;
          end
          if j==22
             frame(i,j) = 0;
             plot(j,i,'co','MarkerSize',10,'MarkerSize',5,'MarkerEdgeColor','c','MarkerFaceColor','c');
             hold on;
         end
     end
 end
  
 for i = 37:72
     for j = 1 : 22 
         if i==37
             frame(i,j) = 0;
             plot(j,i,'co','MarkerSize',10,'MarkerSize',5,'MarkerEdgeColor','c','MarkerFaceColor','c');
         end
          if j==1
             frame(i,j) = 0;
             plot(j,i,'co','MarkerSize',10,'MarkerSize',5,'MarkerEdgeColor','c','MarkerFaceColor','c');
          end
          if i==72
             frame(i,j) = 0;
             plot(j,i,'co','MarkerSize',10,'MarkerSize',5,'MarkerEdgeColor','c','MarkerFaceColor','c');
          end
          if j==22
             frame(i,j) = 0;
             plot(j,i,'co','MarkerSize',10,'MarkerSize',5,'MarkerEdgeColor','c','MarkerFaceColor','c');
         end
     end
 end
  
 for i = 73:144
     for j = 1 : 44
         if i==73
             frame(i,j) = 0;
             plot(j,i,'co','MarkerSize',10,'MarkerSize',5,'MarkerEdgeColor','c','MarkerFaceColor','c');
         end
          if j==1
             frame(i,j) = 0;
             plot(j,i,'co','MarkerSize',10,'MarkerSize',5,'MarkerEdgeColor','c','MarkerFaceColor','c');
          end
          if i==144
             frame(i,j) = 0;
             plot(j,i,'co','MarkerSize',10,'MarkerSize',5,'MarkerEdgeColor','c','MarkerFaceColor','c');
          end
          if j==44
             frame(i,j) = 0;
             plot(j,i,'co','MarkerSize',10,'MarkerSize',5,'MarkerEdgeColor','c','MarkerFaceColor','c');
         end
     end
 end
%  plot(76,76,'co','MarkerSize',10,'MarkerSize',5,'MarkerEdgeColor','c','MarkerFaceColor','c');
 imshow(frame);title('图片分割区域大小示例');
% % bar(cell2mat(result(:,3+18)));



% DIR='D:\数学建模\比赛\data\question5\modified\';        %图片所在文件夹
% file=dir(strcat(DIR,'*.jpg'));                %读取所有jpg文件
% filenum=size(file,1);                         %图片总数
% result = zeros(filenum,1);
% for num = 1:filenum 
%     flag = 0;
%     fname = strcat(DIR, num2str(num), '.jpg');
%     frame = imread(fname); 
%     [r,v] = size(frame);
%     for i = 1:r
%         for j = 1:v
%             if frame(i,j) ~=0
%                flag = flag +1;
%             end
%         end
%     end
%     result(num,1) =flag;    
% end
% 
% bar(result);title('ViBe算法处理后的图片像素点总数随帧数的变化')
%     
