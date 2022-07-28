DataPath = '...';
SavePath ='...';
load('...\mycmap2.mat');
PointNum = 50;

SubFile = dir(DataPath);
SubFile_Num = 0;
DendriteData = {};
for i = 1:size(SubFile,1)
    if contains(SubFile(i).name,'.mat')
        SubFile_Num = SubFile_Num + 1;
        DendriteData{SubFile_Num,1} = SubFile(i).name;
        DendriteData{SubFile_Num,2} = SubFile(i).folder;
        DendriteData{SubFile_Num,3} = load(fullfile(SubFile(i).folder,SubFile(i).name));
    end
end

for j = 1:size(DendriteData,1)
    DendriteData_Current = DendriteData{j,3};
    Name = DendriteData{j,1};
    
    x = [mean(DendriteData_Current.soma(:,1)), mean(DendriteData_Current.soma(:,2))];
    
    ASC = {};
    nRow=size(DendriteData_Current.soma,1);
    col_1 = ones(nRow,1)*x(1);
    col_2 = ones(nRow,1)*x(2);
    Rmatrix = [col_1,col_2];
    ASC.Soma.data(:,3:4) = DendriteData_Current.soma(:,1:2)-Rmatrix;
    
    for i=1:length(DendriteData_Current.branch)
        nRow=size(DendriteData_Current.branch{1,i},1);
        col_1 = ones(nRow,1)*x(1);
        col_2 = ones(nRow,1)*x(2);
        Rmatrix = [col_1,col_2];
        ASC.Dendrites(i).data(:,3:4) = DendriteData_Current.branch{1,i}(:,1:2)-Rmatrix;
        ASC.Dendrites(i).data(:,7) = DendriteData_Current.branch{1,i}(:,3);
    end
    ASC.shiftValue = x;
    ASC.FileName = Name;
    
    histoData=[];
    for i = 1:length(ASC.Dendrites)
        histoData = [histoData;ASC.Dendrites(i).data(:,3:4)];
    end
    [Theta_histoData,Rho_histoData] = cart2pol(histoData(:,1),histoData(:,2));
    
    Theta = [];
    Theta = atan2(histoData(:,2),histoData(:,1));
    Distance = [];
    for i = 1:size(histoData,1)
        Distance(i,1) = sqrt(histoData(i,1)^2 + histoData(i,2)^2);
    end
    
    ThetaRange = -pi:2*pi/PointNum:pi;
    ThetaData = [];
    for j = 1:PointNum
        RangeStart = ThetaRange(j);
        RangeEnd = ThetaRange(j+1);
        MatchIndex = [];
        MatchIndex = find(Theta > RangeStart & Theta <= RangeEnd);
        if ~isempty(MatchIndex)
            ThetaData(j,1) = max(Distance(MatchIndex,1));
        else
            ThetaData(j,1) = 0;
        end
    end
    ThetaData = ThetaData/max(ThetaData);
    
    h= figure('InvertHardcopy','off','Color',[1 1 1],'Renderer','painters','outerposition',[1 1 500 500]);
    polarhistogram('BinEdges',ThetaRange,'BinCounts',ThetaData,'FaceColor','w','EdgeColor',[0 0.4471 0.7412]);
    title(Name(1:end-4))

    SaveName = [SavePath,strcat(Name(1:end-4))];
    saveas(h,strcat(SaveName,'.png'));
    saveas(h,strcat(SaveName, '.eps'), 'epsc');
    close all;
    clear('ASC');
end

