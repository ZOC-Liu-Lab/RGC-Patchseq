%% load data;
clc,clear,close all;

LoadPath = 'D:\Patch_result\';
[FileName, FilePath] = uigetfile({'*.dat'},'Select patch file',LoadPath);

%% get HEKA data; 
HEKA_Result = HEKA_Importer(fullfile(FilePath, FileName));

%% get raw data and analysis data;
PatchData = HEKA_Result.RecTable;

SerialNumber = PatchData.Rec;
for i = 1:size(PatchData.RecMode,1)
    RecordingMode{i,1} = PatchData.RecMode{i,1}{1,2};  
end
RecordingType = PatchData.Stimulus;
SamplingFrequency = PatchData.SR;

RecordingResult = PatchData.dataRaw;
for j = 1:size(RecordingResult,1)
    TTL{j,1} = RecordingResult{j,1}{1,1};
    LightResponse{j,1} = RecordingResult{j,1}{1,2};
end

RawData = table(SerialNumber,RecordingMode,RecordingType,SamplingFrequency,TTL,LightResponse);

%% delete no TTL signal;
RecordingNum = size(RawData.TTL,1);
k = 1;
while k <= RecordingNum
    Temp = RawData.TTL{k,1};
    if max(Temp) <= 0.9
        RawData(k,:) = [];
        RecordingNum = RecordingNum -1;
        k = k;
    else
        k = k +1;
    end
end

%% save AnalysisData;
DataName = FileName(1:strfind(FileName,'.')-1);

clearvars -except RawData DataName FilePath ;

save([FilePath,DataName,'_PatchResults']);


