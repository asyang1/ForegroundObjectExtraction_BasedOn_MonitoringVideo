DIR1='G:\研究生数学建模\数模竞赛\D自己做\第5题\2个人\program\所有帧\所有对象\';
%批量处理相关性分析
%开辟相关系数变量数组和显著性水平p值变量数组
r11=zeros(filenum,1);
r12=zeros(filenum,1);
r21=zeros(filenum,1);
r22=zeros(filenum,1);
p11=zeros(filenum,1);
p12=zeros(filenum,1);
p21=zeros(filenum,1);
p22=zeros(filenum,1);
for k=1:filenum
    fname = strcat(DIR1, num2str(k+start1), '1.jpg');
    New1=imread(fname);
    fname = strcat(DIR1, num2str(k+start1), '2.jpg');
    New2=imread(fname);
    img544s1=imread('G:\研究生数学建模\数模竞赛\D自己做\第5题\2个人\program\所有帧\所有对象\5441.jpg');
    img544s2=imread('G:\研究生数学建模\数模竞赛\D自己做\第5题\2个人\program\所有帧\所有对象\5442.jpg');
    
    %自动寻找4张图里面的最小尺寸
    sizeMin=zeros(4,2);
    sizeMin(1,:)=size(New1);
    sizeMin(2,:)=size(New2);
    sizeMin(3,:)=size(img544s1);
    sizeMin(4,:)=size(img544s1);
    sizeMinMin=min(sizeMin);
    
    %匹配最小尺寸
    img544s2=imresize(img544s2,sizeMinMin);
    img544s1=imresize(img544s1,sizeMinMin);
    New1=imresize(New1,sizeMinMin);
    New2=imresize(New2,sizeMinMin);
    
    img544s1=im2double(img544s1);
    img544s2=im2double(img544s2);
    New1=im2double(New1);
    New2=im2double(New2);
    
%拉伸成为一维数组
    aNew1=New1(:);
    a544s1=img544s1(:);
    aNew2=New2(:);
    a544s2=img544s2(:);
    
%相关系数求出
    [r11(k),p11(k)]=corr(aNew1,a544s1);
    [r12(k),p12(k)]=corr(aNew1,a544s2);
    [r21(k),p21(k)]=corr(aNew2,a544s1);
    [r22(k),p22(k)]=corr(aNew2,a544s2);
    
end

figure(1)
subplot(2,1,1)
bar(a544s1);
title('544帧切割图1拉伸后的直方图');
subplot(2,1,2)
bar(a544s2);
title('544帧切割图2拉伸后的直方图');

figure(2)
bar(r11)
hold on
title('每一帧切割图1和544帧切割图1的相关度结果图')
ylabel('相关系数')
xlabel('帧数')
% plot([0,100],[0.2,0.2],'m')

figure(3)
bar(r12)
axis([0 100 0 1])
hold on
title('每一帧切割图1和544帧切割图2的相关度结果图')
ylabel('相关系数')
xlabel('帧数')
plot([0,100],[0.2,0.2],'m')



