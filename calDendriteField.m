function [ asc_new ] = calDendriteField( asc )

densityMap = asc.densityMap;

X = densityMap.X;
Y = densityMap.Y;
K = (1/6)*ones(6);
densityMap.dMap = conv2(densityMap.dMap,K,'same');

x = -1000:0.5:1000;
y = -1000:0.5:1500;
[xq,yq] = meshgrid(x,y);
dMap_new = interp2(X,Y,densityMap.dMap',xq,yq,'makima');
p2 = pcolor(xq,yq,dMap_new/max(max(dMap_new)));
colorbar();
set(p2, 'EdgeColor','none');
hold on;
cs = contour(xq,yq,dMap_new/max(max(dMap_new)),[100,100],'w-'); % get the contour values and add the contour into the figure;
axis equal;

dendriticFieldArea = polyarea(cs(1,2:end),cs(2,2:end));

somaContour = asc.Soma.data(:,3:4);
somaCenter = mean(somaContour);

[in,on]=inpolygon(somaCenter(1),somaCenter(2),somaContour(:,1),somaContour(:,2));
if on == 1
    minDistance = 0; 
elseif in == 1   
    minDistance = min(sqrt((cs(1,2:end)-somaCenter(1)).^2+(cs(2,2:end)-somaCenter(2)).^2) );
else    
    minDistance = -min(sqrt((cs(1,2:end)-somaCenter(1)).^2+(cs(2,2:end)-somaCenter(2)).^2) );
end

plot(somaCenter(1),somaCenter(2),'ko');
hold off;

aveDensityValue = sum(sum(asc.densityMap.dMap))/dendriticFieldArea;

asc_new = asc;
asc_new.dendriticContour  =cs;
asc_new.somaCenter = somaCenter;
asc_new.dendriticFieldArea = dendriticFieldArea;
asc_new.soma2denField = minDistance;
asc_new.aveDensityValue = aveDensityValue;
end

