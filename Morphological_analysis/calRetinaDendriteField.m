function [ DendriteData_CalField ] = calRetinaDendriteField(DendriteData_Cal,SomaData)
%SINGLENEURONSHOLL calclulates the density map matrix of a whole neuron.
% INPUT:
%     DendriteData_Cal - a new structure added calculated density map matrix.
%     SomaData - a structure contains the soma data;
% OUTPUT:
%     DendriteData_CalField - added average dendritic density,soma center,the
%     area of the closed contour, etc;


densityMap = DendriteData_Cal.densityMap;

X = densityMap.X;
Y = densityMap.Y;
% smooth the 2-d data.
K = (1/6)*ones(6);
densityMap.dMap = conv2(densityMap.dMap,K,'same');

% interpolit and plot.
x = -1000:0.5:1000;
y = -1000:0.5:1500;
[xq,yq] = meshgrid(x,y);
dMap_new = interp2(X,Y,densityMap.dMap',xq,yq,'makima');
% plot the figure and calculate the dendritic field contour
% figure;
p2 = pcolor(xq,yq,dMap_new/max(max(dMap_new)));
colorbar();
set(p2, 'EdgeColor','none');
hold on;
cs = contour(xq,yq,dMap_new/max(max(dMap_new)),[100,100],'w-'); % get the contour values and add the contour into the figure;
axis equal;

% calculate the area of the closed contour.
dendriticFieldArea = polyarea(cs(1,2:end),cs(2,2:end));

% calculate the soma center.
somaContour = SomaData;
somaCenter = mean(somaContour);

% judge if the soma center is in the dendritic field contour. 
[in,on]=inpolygon(somaCenter(1),somaCenter(2),somaContour(:,1),somaContour(:,2));
%calculate the minimal distance from the soma center to the closed dendritic field contour.
if on == 1
    minDistance = 0; % the soma center is on the dendritic field contour.
elseif in == 1   % the soma center is in the closed dendritic filed contour.
    minDistance = min(sqrt((cs(1,2:end)-somaCenter(1)).^2+(cs(2,2:end)-somaCenter(2)).^2) );
else    % the soma center is out the closed dendritic filed contour.
    minDistance = -min(sqrt((cs(1,2:end)-somaCenter(1)).^2+(cs(2,2:end)-somaCenter(2)).^2) );
end

% add the soma center into the figure;
%plot(somaCenter(1),somaCenter(2),'ko');
hold off;

% calculate the average dendritic density across the dendritic field.
aveDensityValue = sum(sum(DendriteData_Cal.densityMap.dMap))/dendriticFieldArea;

DendriteData_CalField.Dendrites =DendriteData_Cal.Dendrites;
DendriteData_CalField.Soma =SomaData;
DendriteData_CalField.dendriticContour  =cs;
DendriteData_CalField.somaCenter = somaCenter;
DendriteData_CalField.dendriticFieldArea = dendriticFieldArea;
DendriteData_CalField.soma2denField = minDistance;
DendriteData_CalField.aveDensityValue = aveDensityValue;
end

