%基于样本局部密度的离群检测点
N = filenum;  %帧数
k = 3;   %选择3个最近的样本点作为k近邻的点，该点数可能超过3因为可能很多样本点到该点的距离相等
original_pic = XX; %保存原始像素
result= zeros(rows,N); %声明结果矩阵的大小

%求均值背景图
mXX = mean(XX , 2);
DIR='D:\数学建模\比赛\data\question1\office\background\';     %单帧图片所在文件夹

x= mXX;
frameNew=reshape(x,size(frame,1),size(frame,2));
% se=strel('disk',6);
% frameNew1=imopen(frameNew,se);
% frameNew2=imclose(frameNew1,se);
fname = strcat(DIR, num2str(1), '.jpg');
imwrite(frameNew/256,fname);

%初始化样本模型，采用单帧初始化，640*480邻域样本数为8
N0 = 8;  %样本容量为8
[f_r,f_v] = size(frame);
mXX = reshape(mXX,120,160); %获取空间上的邻域
background = zeros(rows,4); %初始化背景模型矩阵
flag = 1;
for i = 1:f_r
   for j = 1:f_v
       if  i == 1 && j == 1
            background(flag,1) = mXX(1,1);
            background(flag,2) = mXX(1,2);
            background(flag,3) = mXX(2,1);
            background(flag,4) = mXX(2,2);
            background(flag,5) = mXX(1,1);
            background(flag,6) = mXX(1,2);
            background(flag,7) = mXX(2,1);
            background(flag,8) = mXX(2,2);
       elseif i == 1 && j == f_v
            background(flag,1) = mXX(1,f_v);
            background(flag,2) = mXX(1,f_v-1);
            background(flag,3) = mXX(2,f_v);
            background(flag,4) = mXX(2,f_v-1);
            background(flag,5) = mXX(1,f_v);
            background(flag,6) = mXX(1,f_v-1);
            background(flag,7) = mXX(2,f_v);
            background(flag,8) = mXX(2,f_v-1);
       elseif i == f_r && j == 1
            background(flag,1) = mXX(f_r,1);
            background(flag,2) = mXX(f_r-1,1);
            background(flag,3) = mXX(f_r-1,2);
            background(flag,4) = mXX(f_r,2);
            background(flag,5) = mXX(f_r,1);
            background(flag,6) = mXX(f_r-1,1);
            background(flag,7) = mXX(f_r-1,2);
            background(flag,8) = mXX(f_r,2);
       elseif i == f_r && j == f_v
            background(flag,1) = mXX(f_r,f_v);
            background(flag,2) = mXX(f_r,f_v-1);
            background(flag,3) = mXX(f_r-1,f_v);
            background(flag,4) = mXX(f_r-1,f_v-1);
            background(flag,5) = mXX(f_r,f_v);
            background(flag,6) = mXX(f_r,f_v-1);
            background(flag,7) = mXX(f_r-1,f_v);
            background(flag,8) = mXX(f_r-1,f_v-1);
       elseif  i == 1 && j >1 && j < f_v
            background(flag,1) = mXX(1,j);
            background(flag,2) = mXX(1,j-1);
            background(flag,3) = mXX(1,j+1);
            background(flag,4) = mXX(2,j);
            background(flag,5) = mXX(1,j);
            background(flag,6) = mXX(1,j-1);
            background(flag,7) = mXX(1,j+1);
            background(flag,8) = mXX(2,j);
       elseif  i == f_r && j >1 && j < f_v
            background(flag,1) = mXX(f_r,j);
            background(flag,2) = mXX(f_r,j-1);
            background(flag,3) = mXX(f_r,j+1);
            background(flag,4) = mXX(f_r-1,j);
            background(flag,5) = mXX(f_r,j);
            background(flag,6) = mXX(f_r,j-1);
            background(flag,7) = mXX(f_r,j+1);
            background(flag,8) = mXX(f_r-1,j);
       elseif  j == 1 && i >1 && i < f_r
            background(flag,1) = mXX(i,1);
            background(flag,2) = mXX(i-1,1);
            background(flag,3) = mXX(i+1,1);
            background(flag,4) = mXX(i,2);
            background(flag,5) = mXX(i,1);
            background(flag,6) = mXX(i-1,1);
            background(flag,7) = mXX(i+1,1);
            background(flag,8) = mXX(i,2);
       elseif   j == f_v && i >1 && i < f_r
            background(flag,1) = mXX(i,f_v);
            background(flag,2) = mXX(i-1,f_v);
            background(flag,3) = mXX(i+1,f_v);
            background(flag,4) = mXX(i,f_v-1);
            background(flag,5) = mXX(i,f_v);
            background(flag,6) = mXX(i-1,f_v);
            background(flag,7) = mXX(i+1,f_v);
            background(flag,8) = mXX(i,f_v-1);
       else
            background(flag,1) = mXX(i,j);
            background(flag,2) = mXX(i,j+1);
            background(flag,3) = mXX(i,j-1);
            background(flag,4) = mXX(i+1,j+1);
            background(flag,5) = mXX(i+1,j);
            background(flag,6) = mXX(i+1,j-1);
            background(flag,7) = mXX(i-1,j+1);
            background(flag,8) = mXX(i-1,j);
       end
       flag = flag + 1;
   end
end



%判断背景像素
Nstart = 1; %设定起始帧
for point_num = 1:rows
   current = original_pic(point_num,:);  
   for per = Nstart: filenum
        p_near = cell(5,N0);  %初始化，第一行用来存放k_near,第二行用来存放局部可达密度
        background(point_num,N0+1) = current(1,per); %提取当前帧的像素放到样本点的最后一位
        for s_num = 1:N0+1
           k_flag = 1;
           k_dis = zeros(2,N0);
           for i = 1:N0+1

               if i == s_num  %轮到了点本身，则跳过不进行距离求取
                  continue; 
               end

                k_dis(1,k_flag) = abs(background(point_num,s_num) - background(point_num,i)); %计算该帧的点到所有点的距离
                k_dis(2,k_flag) = i;  %保存该点的位置
                k_flag = k_flag + 1;
           end
           ksort_dis = sortrows( k_dis',1)';  %对k_dis从小到大排序

           %确定满足k近邻的个数，由于可能出现距离相等的情况，个数可能大于k
           for i = 1:N0

               if i == N0  %若i到了N0 - 1还没有循环完，则所有的点都是k近邻的点
                   break;
               end
               flag = 0;
               if ksort_dis(1,i+1) == ksort_dis(1,i)
                   flag = 1;
               end
               if  i >= k  && flag ==0 
                   maxk_dis = ksort_dis(1,i);
                   k_length = i;
                   break;
               end
           end

           p_near{1,s_num} = ksort_dis(:,1:k_length); %将k均值保存到k_near中

           %修正当前点的可达距离
           reach_near = ksort_dis(:,1:k_length);
           reach_sum = 0
           for i = 1:k_length
              if reach_near(1,i) < maxk_dis
                  reach_near(1,i) = maxk_dis;
              end
              reach_sum = reach_sum + reach_near(1,i);
           end

           lrdk_p = 1/(reach_sum/k_length); %求局部可达密度

           %为了便于后续计算，将无穷大设为100
           if lrdk_p  == inf   
               lrdk_p = 100;
           end

           p_near{2,s_num} = lrdk_p; %将其保存在p_near第二行  
           p_near{3,s_num} = k_length;  %第三行保存k近邻的样本个数大小即Nk

        end

        %计算所有像素的背景因子
        for num = 1:N0+1
           sum = 0;
           Nk = p_near{3,num};
           for i = 1:Nk
               q_flag =  p_near{1,num}(2,i);  %取得其邻域的脚标
               sum = sum + p_near{2,q_flag}/p_near{2,num};  %累加
           end
           p_near{4,num} = sum/Nk;
           p_near{5,num} = num;
        end

        %判断该帧像素点是否为背景像素
        sum = 0;
        Nk = p_near{3,N0+1};

        %若为一点局部可达密度无穷大，则直接将该点设为背景因子
        if p_near{2,N0+1} == 100
           temp = 0;
           continue;
        end

        for i = 1:p_near{3,N0+1}
           q_flag =  p_near{1,N0+1}(2,i);  %取得其邻域的脚标
           sum = sum + p_near{4,q_flag};  %累加局部背景因子LBF
        end
        mean = sum/N0 ;  %求该点像素的近邻域样本点的LBF均值

        if p_near{4,num} > mean
           temp = 0;
        else
           temp = 1;
        end
        
%         %若当前像素为背景像素,则进行背景模型迭代
%         if temp == 0
%             p_near = sortrows(p_near',4)';
%             if p_near{5,1} ~= N0+1
%                 background(point_num,p_near{5,1}) = current(1,per);
%             end
%         end
       
        result(point_num,per) = temp;
   end
end

XXnew = original_pic;
for i=1:rows
    for j=1:N    
        if result(i,j) == 0
            XXnew(i,j) =  0;
        end
    end
end

DIR='D:\数学建模\比赛\data\question1\office\aft-picture\';     %单帧图片所在文件夹

for k = 1: N  %将矩阵还原为filenum-1张图片
    x= XXnew(:,k);
    frameNew=reshape(x,size(frame,1),size(frame,2));
    se=strel('disk',6);
    frameNew1=imopen(frameNew,se);
    frameNew2=imclose(frameNew1,se);
    fname = strcat(DIR, num2str(k), '.jpg');
    imwrite(frameNew/256,fname);
end


