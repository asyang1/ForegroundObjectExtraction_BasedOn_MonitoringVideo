%视频播放
clear;
clc;

video=VideoReader('highway_gray.avi');     %读取视频文件
vidFrames = read(video);                   % 读取视频中所有数据
numFrames = get(video, 'numberOfFrames');  %获得视频帧的帧数

%从视频帧数据中创建一个MATLAB视频播放结构体
  for k = 1 : numFrames
         mov(k).cdata = vidFrames(:,:,:,k);
         mov(k).colormap = [];
  end   
  hf=figure;                               %创建图像
  %基于视频的宽度和高度重建图片
  set(hf, 'position', [150 150 video.Width video.Height])
  %按照视频帧速率重播视频
  movie(hf, mov, 1, video.FrameRate);