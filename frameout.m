clear;
DIR='D:\数学建模\比赛\data\question4\overpass\modified\';        %图片所在文件夹
file=dir(strcat(DIR,'*.jpg'));                %读取所有jpg文件
filenum=size(file,1);                           %图片总数

result = zeros(1,filenum);
point = 1;
for i = 1:filenum
    sumk = 0;
    fname = strcat(DIR, num2str(i), '.jpg');
    frame = imread(fname); 
    sumk = sum(sum(frame));
    if sumk == 0
       point = point +1;
       continue;
    else
        result(1,point) = 1;
    end
    point =point +1;
end

for j = 4:point-4-1
   sum = 0;
   left = 0;
   right = 0;
   for kk =1:3
       %判断左边是否有前景目标
      if result(j-kk)==1
          left =1;
      end
       %判断右边是否有前景目标
      if result(j+kk)==1
         right = 1;
      end
      %若左右都有，则当前设为前景目标
      if (left + right) ==2
          result(1,j) =1;
          break;
      end
   end
end
flag =1;
index = 0;
for o = 1:point-1
   if result(1,o)==1
       a(1,flag) = o;
       flag = flag+1;  
   end
end


length = flag -1;
b(1,1) = a(1,1);
flag =1;
for p = 2:length
   if (a(1,p)-a(1,p-1)) ==1
       continue;
   else 
       b(flag,2) = a(1,p-1);
       flag = flag+1;
       b(flag,1) = a(1,p);
      
   end
end
b(flag,2) = a(1,length);
% fid=fopen('D:\数学建模\比赛\data\question4\Campus\result.txt','wt');
% fprintf(fid,'%g\t',b,'ASCII');
% fclose(fid);

