function PlotDendriteResults(DataPath,SavePath,SaveIndex)
%% main code;
%SINGLENEURONSHOLL plot all RGCs morphological results; 
% INPUT:
%     DataPath - the path of RGCs morphological data.
%     SavePath - the saving path of the plotting results.
%     SaveIndex - 1 means saving results, and 0 means only showing results.

close all;
%% get total files informations;
DendriteData = GetAllDendriteData(DataPath);

%% aclculate and plot dendrite map;
for j = 1:size(DendriteData,1)
    DendriteData_Current = DendriteData{j,3};
    Name = DendriteData{j,1};
    
    %% get central correct data;
    [DendriteData_Check,SomaData] = CheckDendriteData(DendriteData_Current);
    
    %% plot results;
    DendriteData_Cal = calDendriteDensityMap(DendriteData_Check);
    figure;
    DendriteData_CalField = calRetinaDendriteField(DendriteData_Cal,SomaData);
    plotRetinaDendrite(DendriteData_CalField,Name);
    
    %% save results;
    if SaveIndex == 1
        SaveName = [SavePath,strcat(Name(1:end-4))];
        saveas(gcf,strcat(SaveName,'.png'));
    end
    close all;
end