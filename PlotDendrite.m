DataPath = '...';
SavePath ='...';
load('...\mycmap2.mat');

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
    ASC2 = {};
    nRow=size(DendriteData_Current.soma,1);
    col_1 = ones(nRow,1)*x(1);
    col_2 = ones(nRow,1)*x(2);
    Rmatrix = [col_1,col_2];
    ASC2.Soma.data(:,3:4) = DendriteData_Current.soma(:,1:2)-Rmatrix;
    
    for i=1:length(DendriteData_Current.branch)
        nRow=size(DendriteData_Current.branch{1,i},1);
        col_1 = ones(nRow,1)*x(1);
        col_2 = ones(nRow,1)*x(2);
        Rmatrix = [col_1,col_2];
        ASC2.Dendrites(i).data(:,3:4) = DendriteData_Current.branch{1,i}(:,1:2)-Rmatrix;
        ASC2.Dendrites(i).data(:,7) = DendriteData_Current.branch{1,i}(:,3);
    end
    ASC2.shiftValue = x;
    ASC2.FileName = Name;
    
    [ ASC2,h1,h2 ] = calDendriteDensityMap_retina( ASC2, 1);
    h= figure('InvertHardcopy','off','Color',[1 1 1],'Renderer','painters');
    [ ASC2 ] = calDendriteField( ASC2 );
    plotASC(ASC2);
    colormap(mycolor)
    SaveName = [SavePath,strcat(Name(1:end-4))];
    saveas(h,strcat(SaveName,'.jpg'));
    saveas(h,strcat(SaveName, '.eps'), 'epsc');
    close all;
    clear('ASC');
end

