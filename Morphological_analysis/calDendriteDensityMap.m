function DendriteData_Cal = calDendriteDensityMap(DendriteData)
%SINGLENEURONSHOLL calclulates the density map matrix of a whole neuron.
% INPUT:
%     DendriteData - a structure contains the morph data;
% OUTPUT:
%     DendriteData_Cal - a new structure added calculated density map matrix.


DendriteData_Cal.Dendrites = DendriteData;

% calculate density map of the basal dendrites.
if ~isempty(DendriteData)
    for j = 1:length(DendriteData)
        x = DendriteData{1,j}(:,1);
        y = DendriteData{1,j}(:,2);
        [DenMap_tem] = calRetinaNeuriteDensityMap(x,y);
        DendriteData_Cal.densityMap{1,j} = DenMap_tem;
    end
else
    DendriteData_Cal.densityMap = [];
end

% calculate the all neurites length density map.
dMap = zeros(size(DenMap_tem.dMap));
densityMap.X = DenMap_tem.X;
densityMap.Y = DenMap_tem.Y;
densityMap.dMap = dMap;
if ~isempty(DendriteData_Cal.Dendrites)
    for j = 1:length(DendriteData)
        dMap = dMap + DendriteData_Cal.densityMap{1,j}.dMap;
    end
end
densityMap.dMap = dMap;
[centroid_allBasalDen]=calCentroid(densityMap);


% save the data into the new structure.
DendriteData_Cal.densityMap = densityMap;
DendriteData_Cal.centroid_allBasalDen = centroid_allBasalDen;

end



