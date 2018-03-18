clear;
DIR='D:\数学建模\比赛\data\question5\aft-picture\';        %图片所在文件夹
file=dir(strcat(DIR,'*.jpg'));                %读取所有jpg文件
filenum=size(file,1);                         %图片总数
flag= 1;
for num = 1801:filenum 
    fname = strcat(DIR, num2str(num), '.jpg');
    frame = imread(fname);
%     imshow( frame);
%     [r,v] = size(frame);
    
%     for i = 1 :r
%         for j = 1:v
%             if num-1600 >21 && num-1600 <31
%                if i>60 && i<240 && j >90&&j<185
%                    continue;
%                else 
%                    frame(i,j) = 0;
%                    continue;
%                end
%             end
%              if num-1600 >30 && num-1600 < 35
%                if i>60 && i<240 && j >70&&j<181
%                    continue;
%                else 
%                    frame(i,j) = 0;
%                    continue;
%                end
%              end
%              if num-1600 >34
%                if i>60 && i<240 && j >55&&j<127
%                    continue;
%                else 
%                    frame(i,j) = 0;
%                    continue;
%                end
%             end
%             if i>40&& i <220 && j>90 && j<240
%                 continue;
%             else
%                 frame(i,j) = 0;
%             end
%         end
%     end
%     imshow(frame);
%     se = strel('square',2);  %膨胀
%     frame =imdilate(frame,se);
    
    
    for i = 1:20 
        modified_frame= medfilt2(frame,[3,3]);%使用中值滤波去噪
    end
   
%     for i = 1:1
%         se=strel('square',2);  %腐蚀
%         modified_frame=imerode(modified_frame,se);
%     end
% %     
%     [L, k_num]=bwlabel(modified_frame,4); %4连通标记
%     s=zeros(k_num,1);
%     if k_num ~=0
%         for ii=1:k_num
%             s(ii)=sum(sum(L==ii)); %计算每个连通区域的面积
%         end
%         [ms, ind]=max(s);
%         modified_frame=(L==ind);
% %         [ss, IX]=sort(s,'descend'); %面积从大到小排序
% %         modified_frame=xor(modified_frame,L==IX(2)); %从原来图像中扣除面积大小排第二的区域
%     end
   
    
    for i = 1:3
        se = strel('square',2);  %膨胀
        modified_frame =imdilate(modified_frame,se);
    end
    modified_frame = bwareaopen(modified_frame/256,150);   %除去小面积
    modified_frame=imfill( modified_frame,'holes'); %填洞
    %modified_frame = imfilter(frame,fspecial('gaussian'))%高斯滤波
    
%     se=strel('disk',1);  %腐蚀
%     modified_frame=imopen(modified_frame,se);
%     modified_frame=imclose(modified_frame,se);
%     modified_frame=imopen(modified_frame,se);
%     modified_frame=imclose(modified_frame,se);
%     modified_frame=imopen(modified_frame,se);
%     modified_frame=imclose(modified_frame,se);  %开运算闭运算
%         [L,kk]=bwlabel(modified_frame,4);
%         x=zeros(1,kk);
%         for ii=1:kk
%             x(ii)=sum(sum(L==ii));
%         end
%         [m,ind]=max(x);
%         modified_frame=(L==ind);
%         for i = 1:2
%             se=strel('square',2);  %腐蚀
%             modified_frame=imerode(modified_frame,se);
%         end
    
    
    imshow(modified_frame);
    imwrite(modified_frame,strcat('D:\数学建模\比赛\data\question5\modified\',num2str(flag),'.jpg'),'jpg');
    flag = flag+1;
end