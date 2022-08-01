function SomaData = CheckSomaPosition(SomaRawData,x)
%SINGLENEURONSHOLL Check the soma matrix data of a RGC neuron.
% INPUT:
%     SomaRawData - raw soma matrix.
%     x - the center position of the soma.
% OUTPUT:
%     SomaData - a checked soma data;

%% default parameters;
SomaData = [];

%% shift the postion of the soma.
nRow=size(SomaRawData,1);
col_1 = ones(nRow,1)*x(1);
col_2 = ones(nRow,1)*x(2);
Rmatrix = [col_1,col_2];
SomaData(:,1:2) = SomaRawData(:,1:2)-Rmatrix;


end