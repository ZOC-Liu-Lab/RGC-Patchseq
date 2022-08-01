function DendriteData = CheckDendritePosition(DendriteRawData,x)
%SINGLENEURONSHOLL Check the dendrites matrix data of a RGC neuron.
% INPUT:
%     DendriteRawData - raw dendrites matrix.
%     x - the center position of the soma.
% OUTPUT:
%     DendriteData - a checked dendrites data;

%% default parameters;
DendriteData = [];

%% shift the positions of all dendrites.
for i=1:length(DendriteRawData)
    nRow=size(DendriteRawData{1,i},1);
    col_1 = ones(nRow,1)*x(1);
    col_2 = ones(nRow,1)*x(2);
    Rmatrix = [col_1,col_2];
    DendriteData{1,i}(:,1:2) = DendriteRawData{1,i}(:,1:2)-Rmatrix;
    DendriteData{1,i}(:,3) =DendriteRawData{1,i}(:,3);
end

end