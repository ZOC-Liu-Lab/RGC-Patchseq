function [ThetaData,ThetaRange] = GetThetaData(histoData,PointNum)
%SINGLENEURONSHOLL get ThetaData matrix of a RGC.
% INPUT:
%     histoData - a merged dendrites data from one RGC morphological data;
%     PointNum - Theta range numbers;
% OUTPUT:
%     ThetaData - the polarhistogram data for a RGC's dendrites;
%     ThetaRange - the corresponding coordinates of polar coordinates.

%% get max dendrite data;
Theta = [];
Theta = atan2(histoData(:,2),histoData(:,1));
Distance = [];
for i = 1:size(histoData,1)
    Distance(i,1) = sqrt(histoData(i,1)^2 + histoData(i,2)^2);
end

%% get theta data;
ThetaRange = -pi:2*pi/PointNum:pi;
ThetaData = [];
for j = 1:PointNum
    RangeStart = ThetaRange(j);
    RangeEnd = ThetaRange(j+1);
    MatchIndex = [];
    MatchIndex = find(Theta > RangeStart & Theta <= RangeEnd);
    if ~isempty(MatchIndex)
        ThetaData(j,1) = max(Distance(MatchIndex,1));
    else
        ThetaData(j,1) = 0;
    end
end
ThetaData = ThetaData/max(ThetaData);

end