function [historyImages, historyBuffer] = vibeUpdate(buffer, updatingMask, historyImages, historyBuffer, param, ...
    jump, neighborX, neighborY, position)
    %参数
    height  = param.height;
    width   = param.width;
    numberOfHistoryImages   = param.numberOfHistoryImages;   
    
    %背景模型更新
    for indY = 2:height - 1
        shift = floor(rand()*width) + 1;
        indX = jump(shift) + 1;
        while indX < width
            if updatingMask(indY, indX) == 0
                value = buffer(indY, indX);
                if position(shift) <= numberOfHistoryImages
                    historyImages{position(shift)}(indY, indX) = value;
                    historyImages{position(shift)}...
                        (indY + neighborY(shift), indX + neighborX(shift)) = value;
                else
                    pos = position(shift) - numberOfHistoryImages;
                    historyBuffer{pos}(indY, indX) = value;
                    historyBuffer{pos}...
                        (indY + neighborY(shift), indX + neighborX(shift)) = value;
                end
            end
            shift = shift + 1;
            indX = indX + jump(shift);
        end
    end
    
end