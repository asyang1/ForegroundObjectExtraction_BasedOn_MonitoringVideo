diff=zeros(rows,filenum-2); %差异矩阵
%diffNew=zeros(size(frame,1),size(frame,2),filenum-2);
%批量帧间差分法的半自适应形态学改进
diffNew=zeros(size(frame,1),size(frame,2));
for j=1:2:filenum-3
    diff(:,j)=abs(XX(:,j)-XX(:,j+2));
end

for j=2:2:filenum-2
    diff(:,j)=abs(XX(:,j)-XX(:,j+2));
end

for j=1:filenum-2
    for i=1:rows
        if diff(i,j)>15
            diff(i,j)=1;
        else
            diff(i,j)=0;
        end
    end
end

for k=1:filenum-2
    diffNew=reshape(diff(:,k),size(frame,1),size(frame,2));
    
    se = strel('square',2);  %按数目膨胀
    diffNewImdilate = imdilate(diffNew,se);
    [diffNewlink8,num] = bwlabel(diffNew,8);
    [diffNewlink8,num1] = bwlabel(diffNewImdilate,8);
    while num1>num/5 %自动膨胀限制
        diffNewImdilate=imdilate(diffNewImdilate,se);
        [diffNewlink8,num1] = bwlabel(diffNewImdilate,8);
    end
    
    B = bwareaopen(diffNewImdilate,300);   %除去小面积
    
    se = strel('square',2);  %膨胀
    diffNewImdilate=imdilate(B,se);
    A=imfill(diffNewImdilate,'holes'); %填洞
    Asum=sum(sum(A)); %筛选
    diffNewImdilate=imdilate(A,se);
    while((sum(sum(diffNewImdilate))<1.5*Asum))  %自动膨胀限制
        diffNewImdilate=imdilate(diffNewImdilate,se);
    end
    
    se=strel('square',2);  %腐蚀
    diffNewErode=imerode(diffNewImdilate,se);
    diffNewErode1=imerode(diffNewErode,se);
    while (sum(sum(diffNewErode1))>0.8*Asum)  %自动腐蚀限制
        diffNewErode1=imerode(diffNewErode1,se);
    end
    
    se=strel('disk',1);  %腐蚀
    diffNewopen=imopen(diffNewErode1,se);
    diffNewclose=imclose(diffNewopen,se);
    diffNewopen=imopen(diffNewclose,se);
    diffNewclose=imclose(diffNewopen,se);
    diffNewopen=imopen(diffNewclose,se);
    diffNewclose=imclose(diffNewopen,se);  %开运算闭运算
    
    x= XX(:,k);
    frameNew=reshape(x,size(frame,1),size(frame,2));
    frameNew1=zeros(size(frame,1),size(frame,2));
    
    for i=20:size(frame,1)
        for j=1:size(frame,2)
            if (diffNewclose(i,j)==1)
                frameNew1(i,j)=frameNew(i,j);
            end
        end
    end
    
    DIR='G:\研究生数学建模\数模竞赛\D自己做\2017年全国研究生数学建模竞赛D题附件\附件2-典型视频\不带晃动-静态背景\office\帧间差分法修改帧\';     %单帧图片所在文件夹
    fname = strcat(DIR, num2str(k), '.jpg');
    imwrite(frameNew1/256,fname);
end


