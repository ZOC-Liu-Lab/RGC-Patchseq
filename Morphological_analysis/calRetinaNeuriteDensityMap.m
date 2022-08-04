function [neuriteMap]=calRetinaNeuriteDensityMap(x,y)
% This function calculate the mossiac map of a neurite length fallen in meshed cells.
% INPUT:
%     x,y - two values of the DendriteData structure contains the neurite data.
% OUTPUT:
%     neuriteMap -  matrix contains neurite length dendity values.


mapResolution = 20; % the size of mashed cells.
% create the mashed cells.
X = -1000:mapResolution:1000;
Y = -1000:mapResolution:1500;
% calculate the neurite length in each mashed cell.
dMap = zeros( length(X)-1,length(Y)-1 );
for i = 1:length(X)-1
    for j = 1:length(Y)-1
        [idx1] = find(x>X(i));
        [idx2] = find(x<X(i+1));
        idxX = intersect(idx1,idx2);
        [idx1] = find(y>Y(j));
        [idx2] = find(y<Y(j+1));
        idxY = intersect(idx1,idx2);
        idx = intersect(idxX,idxY);
        idx_d = diff(idx);
        sum_d = 0;
        for m = 1:length(idx_d)
            if ~isempty(idx_d) && idx_d(m)==1  % there maybe several sections fall in the same cell, calculate the length of each section and sum them. 
                d = sqrt( (x(idx(m+1))-x(idx(m)))^2 + (y(idx(m+1))-y(idx(m)))^2 );
                sum_d = sum_d+d;
            end
        end
        dMap(i,j) = dMap(i,j)+sum_d;
    end
%     if rem(i,50) == 0
%         fprintf('i = %d.\n',i);
%     end
end
neuriteMap.dMap = dMap;
% get the axis postions of each mashed cells.
X = X(1:end-1)+0.5*mapResolution;
Y = Y(1:end-1)+0.5*mapResolution;
neuriteMap.X = X;
neuriteMap.Y = Y;

end