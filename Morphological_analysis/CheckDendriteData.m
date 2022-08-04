function [DendriteData_Check,SomaData] = CheckDendriteData(DendriteData_Current)
%SINGLENEURONSHOLL Check the morphological matrix data of a RGC neuron.
% INPUT:
%     DendriteData_Current - a structure contained dendrites and soma matrix.
% OUTPUT:
%     DendriteData_Check - a checked dendrites data;
%     SomaData - a corrected soma data;

%% get central point;
x = [mean(DendriteData_Current.soma(:,1)), mean(DendriteData_Current.soma(:,2))];

%% shift the postion of the soma.
SomaData = CheckSomaPosition(DendriteData_Current.soma,x);

%% shift the positions of all dendrites.
DendriteData_Check = CheckDendritePosition(DendriteData_Current.branch,x);

end