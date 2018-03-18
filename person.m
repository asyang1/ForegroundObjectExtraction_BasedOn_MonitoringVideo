DIR='D:\数学建模\比赛\data\question4\hall\modified\';        %图片所在文件夹
file=dir(strcat(DIR,'*.jpg'));                %读取所有jpg文件
filenum=size(file,1);                         %图片总数
result = cell(filenum,23);
for num = 1:filenum
   fname = strcat(DIR,'1 (', num2str(num), ').jpg');
   frame = imread(fname); 
%    result(num,1) = num;
   collection = zeros(20,3);
   density = 0;
   x=11 ; y=18 ;
   
   for count = 1:8
      point = 0;
      for i = 1:36
         for j = 1 + 22*(count -1) : 22 + 22*(count -1)
             if frame(i,j) ~=0
                 point = point +1;
             end
         end
      end
      per = point*1.5/(22*36);
      collection(count,1) = x +22*(count -1);
      collection(count,2) = y;
      collection(count,3) = per;
      result{num,count+3} = per;
      density =density +per;
   end
   
   y = 18+36;
    for count = 9:16
      point = 0;
      for i = 37:72
         for j = 1 + 22*(count -9) : 22 + 22*(count -9)
             if frame(i,j) ~=0
                 point = point +1;
             end
         end
      end
      per = point*1.5/(22*36);
      collection(count,1) = x +22*(count -9);
      collection(count,2) = y;
      collection(count,3) = per;
      result{num,count+3} = per;
      density =density +per;
    end
   
    x = 22;
    y = 72+36;
    for count = 17:20
      point = 0;
      for i = 73:144
         for j = 1 + 44*(count -17) : 44 + 44*(count -17)
             if frame(i,j) ~=0
                 point = point +1;
             end
         end
      end
      per = point*1.5/(72*44);
      collection(count,1) = x +22*(count -17);
      collection(count,2) = y;
      collection(count,3) = per;
      result{num,count+3} = per;
      density =density +per;
    end
   
    result{num,1} = collection;
    result{num,2}= density;
end

num = 0;
for num = 2:filenum
    current = cell2mat(result(num,1));
    deta_v = 0;
    kk=0;
    for point = 1:20
        for turn = 1:20
            deta_per =   (cell2mat(result(num,point+3)) - cell2mat(result(num-1,point+3)))  -   (    cell2mat(result(num,turn+3))  -  cell2mat(result(num-1,turn+3))   )  ;
            kk =  kk +sqrt((current(point,1) -current(turn,1))^2 + (current(point,2) -current(turn,2))^2)* abs(deta_per)/1000;
        end
    deta_v = deta_v + kk;
    
    end
    result{num,3} = deta_v/2;
end