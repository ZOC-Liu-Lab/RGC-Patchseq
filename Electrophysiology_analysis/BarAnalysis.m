function BarAnalysis(DataPath,SavePath,SaveIndex)
%% main code;
%SINGLENEURONSHOLL plot all RGCs bar results;
% INPUT:
%     DataPath - the path of RGCs bar data.
%     SavePath - the saving path of the plotting results.
%     SaveIndex - 1 means saving results, and 0 means only showing results.

close all;
%% get total files informations;
BarData = GetBarData(DataPath);

%% aclculate and plot dendrite map;
for j = 1:size(BarData,1)
    BarData_Current = BarData{j,3};
    Name = BarData{j,1};
    
    %% Check data;
    BarData_Check = CheckBarData(BarData_Current);
    
    %% get bar direction numbers;
    BarDirectionNumbers = GetBarDirectionNumbers(BarData_Check);
    
    %% analyze bar functional DSI;
    BarResponse = BarData_Check.BarResponse.MeanResponse(1:end-1);
    DSI = GetBarDSI(BarResponse);
    BarData_Check.DSI = DSI;
    
    %% plot selective results;
    PlotBarResults(BarData_Check,BarDirectionNumbers,Name)
    SaveBarResults(SavePath,Name,SaveIndex)
        
end
end