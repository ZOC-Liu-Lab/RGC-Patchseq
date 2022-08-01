function DendriteData = GetAllDendriteData(DataPath)
%SINGLENEURONSHOLL load all RGCs morphological data; 
% INPUT:
%     DataPath - the path of RGCs morphological data.
% OUTPUT:
%     DendriteData - all RGCs morphological results;

%% get subfile information;
SubFile = dir(DataPath);
SubFile_Num = 0;

%% load and get all folder dendrite data;
DendriteData = {};
for i = 1:size(SubFile,1)
    if contains(SubFile(i).name,'.mat')
        SubFile_Num = SubFile_Num + 1;
        DendriteData{SubFile_Num,1} = SubFile(i).name;
        DendriteData{SubFile_Num,2} = SubFile(i).folder;
        DendriteData{SubFile_Num,3} = load(fullfile(SubFile(i).folder,SubFile(i).name));
    end
end

end