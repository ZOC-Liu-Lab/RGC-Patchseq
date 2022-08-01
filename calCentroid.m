function [centroid]=calCentroid(neuriteMap)
% This function calculate the centroid of a neurite from its section length
% density map data.

dMap=neuriteMap.dMap;
X = neuriteMap.X;
Y = neuriteMap.Y;
% get the x value for the centroid.
tau = 0;
for i = 1:length(X)
    for j = 1:length(Y)
        tem_element = dMap(i,j)*X(i);
        tau = tau + tem_element;
    end 
end
x = tau/sum(sum(dMap));
% get the y value for the centroid.
tau = 0;
for i = 1:length(Y)
    for j = 1:length(X)
        tem_element = dMap(j,i)*Y(i);
        tau = tau + tem_element;
    end 
end
y = tau/sum(sum(dMap));
centroid = [x,y];

end