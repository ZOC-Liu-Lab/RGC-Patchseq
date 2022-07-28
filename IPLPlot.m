clear all;
close all;
clc;
DataPath = '...';
SavePath = '...';

SubFile = dir(DataPath);
SubFile_Num = 0;
IPLData = {};
for i = 1:size(SubFile,1)
    if contains(SubFile(i).name,'.mat')
        SubFile_Num = SubFile_Num + 1;
        IPLData{SubFile_Num,1} = SubFile(i).name;
        IPLData{SubFile_Num,2} = SubFile(i).folder;
        IPLData{SubFile_Num,3} = load(fullfile(SubFile(i).folder,SubFile(i).name));
    end
end

[FileName, FilePath] = uigetfile({'*.csv'},'Select data informations','D:\PatchAnalysis\');
[~,~,IPLInformations] = xlsread(fullfile(FilePath,FileName));

for i = 1:size(IPLData,1)
    IPLName = IPLData{i,1}(1:end-4);
    for j = 1:size(IPLInformations,1)
        if strcmp(IPLName,IPLInformations{j,1})
            IPLData{i,4} = IPLInformations{j,2};
            j
        end
    end
end

XNew = 0:0.01:1;
for i = 1:size(IPLData,1)
    x = IPLData{i, 3}.IPLaxis;
    y = IPLData{i, 3}.IPL/max(IPLData{i, 3}.IPL);
    YNew = interp1(x,y,XNew,'makima');
    YNew(find(YNew<0)) = 0;
    IPLData{i,6}.x = XNew;
    IPLData{i,6}.y = YNew;
end

ClusterName = {};
for i = 1:size(IPLData,1)
    if ~isempty(IPLData{i,4})
        Name = string(IPLData{i,4});
        if isempty(ClusterName)
            ClusterName = [ClusterName;Name];
        elseif max(strcmp(ClusterName,Name)) == 0
            ClusterName = [ClusterName;Name];
        end
    end
end

MorphologyResults = {};
for i = 1:size(ClusterName,1)
    MatchNameNum = 0;
    for j = 1:size(IPLData,1)
        if ~isempty(IPLData{j,4})
            Name = string(IPLData{j,4});
            if strcmp(ClusterName{i,1},Name)
                MatchNameNum = MatchNameNum + 1;
                MorphologyResults{i,1} = ClusterName{i,1};
                MorphologyResults{i,2}(MatchNameNum,:) = IPLData(j,:);
            end
        end
    end
end

figure('position',[1 1 200 1000]);
PlotCluster = {'1wt','27','2aw','37','4ow','5si','6sn','7i/7o','73','8n','82wo','8w'};
for k = 1:length(PlotCluster)
    PlotName = PlotCluster{1,k};
    subplot(length(PlotCluster),1,k);
    hold on;
    for i = 1:size(MorphologyResults,1)
        Name = MorphologyResults{i,1};
        if strcmp(PlotName,Name)
            Data = MorphologyResults{i,2};
            DataNum = size(Data,1);
            XALL = [];
            YALL = [];
            for j = 1:DataNum
                x = Data{j, 6}.x;
                y = Data{j, 6}.y;
                
                plot(x,y,'Color',[0.6745,0.6745,0.6745]);
                XALL = [XALL;x];
                YALL = [YALL;y];
            end
            XALL_M = median(XALL,1);
            YALL_M =median(YALL,1);
            
            s = smooth(YALL_M,'moving');
            plot(XALL_M,s/max(s),'color','r','LineWidth',2);
            plot([0.28 0.28],[0 1],'Color','k','LineStyle','--','LineWidth',1);
            plot([0.62 0.62],[0 1],'Color','k','LineStyle','--','LineWidth',1);
            title([Name,'(',num2str(DataNum),')'],'color','b','Position',[0 1]);
            hold off;
            axis off
        end
    end
end
Name = 'Merge';
SaveInfo = [SavePath,Name];
saveas(gcf,strcat(SaveInfo,'.jpg'));
saveas(gcf,strcat(SaveInfo, '.eps'), 'psc2');
close all;

