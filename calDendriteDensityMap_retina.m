function [ asc_new,h1,h2 ] = calDendriteDensityMap_retina( asc, ifPlot )

if nargin == 1
    ifPlot = 0;
end

asc_new = asc;
h1 = -1;
h2 = -2;

if ~isempty(asc.Dendrites)
    for j = 1:length(asc.Dendrites)
        [DenMap_tem]=calNeuriteDensityMap(asc.Dendrites(j).data);
        asc_new.Dendrites(j).densityMap = DenMap_tem;
    end
else
    asc_new.Dendrites.densityMap = [];
end

dMap = zeros(size(DenMap_tem.dMap));
densityMap.X = DenMap_tem.X;
densityMap.Y = DenMap_tem.Y;
densityMap.dMap = dMap;
if ~isempty(asc_new.Dendrites)
    for j = 1:length(asc.Dendrites)
        dMap = dMap + asc_new.Dendrites(j).densityMap.dMap;
    end
end
densityMap.dMap = dMap;
[centroid_allBasalDen]=calCentroid(densityMap);


asc_new.densityMap = densityMap;

asc_new.centroid_allBasalDen = centroid_allBasalDen;

if ifPlot
    h1=figure('PaperUnits','points', 'Position',[1,1,1000,1000]);
    p1=pcolor(densityMap.X,densityMap.Y,densityMap.dMap');
    axis equal;
    colorbar();
    set(p1, 'EdgeColor','none');
    xlim([-350 350])
    ylim([-350 350])
        
    X = densityMap.X;
    Y = densityMap.Y;
    x = -1000:1000;
    y = -1000:1500;
    [xq,yq] = meshgrid(x,y);
    dMap_new = interp2(X,Y,densityMap.dMap',xq,yq,'linear');
    p2 = pcolor(xq,yq,dMap_new);
    colorbar();
    set(p2, 'EdgeColor','none');
    hold on;
    axis equal;
    xlim([-350 350])
    ylim([-350 350])
end

end



