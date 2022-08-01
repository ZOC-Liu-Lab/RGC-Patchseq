function BarData = GetBarData(DataPath)
%SINGLENEURONSHOLL load all RGCs bar data; 
% INPUT:
%     DataPath - the path of RGCs bar data.
% OUTPUT:
%     BarData - all RGCs bar results;

%% get subfile information;
SubFile = dir(DataPath);
SubFile_Num = 0;

%% load and get all folder dendrite data;
BarData = {};
for i = 1:size(SubFile,1)
    if contains(SubFile(i).name,'.mat')
        SubFile_Num = SubFile_Num + 1;
        BarData{SubFile_Num,1} = SubFile(i).name;
        BarData{SubFile_Num,2} = SubFile(i).folder;
        BarData{SubFile_Num,3} = load(fullfile(SubFile(i).folder,SubFile(i).name));
    end
end

end