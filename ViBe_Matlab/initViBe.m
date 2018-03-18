%参数
numberOfSamples         = param.numberOfSamples;
matchingThreshold       = param.matchingThreshold;
matchingNumber          = param.matchingNumber;
updateFactor            = param.updateFactor;
numberOfHistoryImages   = param.numberOfHistoryImages;

%%初始化Vibe算法
historyImages = cell(1, numberOfHistoryImages);
for ii = 1:length(historyImages)
    historyImages{ii} = vidFrame;
end

historyBuffer = cell(1, numberOfSamples - numberOfHistoryImages);
for ii = 1:length(historyBuffer)
    historyBuffer{ii} = vidFrame + double(floor(rand(height, width))*20 - 10);
end

%%随机选取样本
size = 2*max(height, width) + 1;
jump = floor(rand(1, size)*2*updateFactor) + 1;
neighborX = floor(rand(1, size)*3) - 1;
neighborY = floor(rand(1, size)*3) - 1;
position = floor(rand(1, size)*numberOfSamples) + 1;

disp('Initialize ViBe')