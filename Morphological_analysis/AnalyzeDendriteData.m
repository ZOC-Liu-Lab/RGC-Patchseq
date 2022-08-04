function [Theta_histoData,Rho_histoData,histoData] = AnalyzeDendriteData(DendriteData_Check)
%SINGLENEURONSHOLL Analyze all dendrite matrix of a RGC.
% INPUT:
%     DendriteData_Check - a checked dendrites data;
% OUTPUT:
%     histoData - a merged dendrites data;
%     Theta_histoData,Rho_histoData - Convert the Cartesian coordinates to polar coordinates theta and rho.

%% default parameters;
Theta_histoData = [];
Rho_histoData = [];

%% get Dendrites data;
histoData=[];
for i = 1:length(DendriteData_Check)
    histoData = [histoData;DendriteData_Check{1,i}(:,1:2)];
end
[Theta_histoData,Rho_histoData] = cart2pol(histoData(:,1),histoData(:,2));

end