function PlotAsymmetryResults(DataPath,SavePath,SaveIndex)
%% main code;
%SINGLENEURONSHOLL plot all RGCs asymmetric results;
% INPUT:
%     DataPath - the path of RGCs morphological data.
%     SavePath - the saving path of the plotting results.
%     SaveIndex - 1 means saving results, and 0 means only showing results.

%% default setting;
close all;
PointNum = 150;

%% get total files informations;
DendriteData = GetAllDendriteData(DataPath);

%% aclculate and plot dendrite map;
for j = 1:size(DendriteData,1)
    DendriteData_Current = DendriteData{j,3};
    Name = DendriteData{j,1};
    
    %% get central correct data;
    [DendriteData_Check,SomaData] = CheckDendriteData(DendriteData_Current);
    
    %% Merge All Dendrite Data;
    [Theta_histoData,Rho_histoData,histoData] = AnalyzeDendriteData(DendriteData_Check);
    
    %% get theta data;
    [ThetaData,ThetaRange] = GetThetaData(histoData,PointNum);
    
    %% plot and save results;
    PlotDendriteThetaData(ThetaRange,ThetaData,SavePath,Name,SaveIndex)
    
end