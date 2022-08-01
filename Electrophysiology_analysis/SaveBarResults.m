function SaveBarResults(SavePath,Name,SaveIndex)
%PLOT plots RGCs Direction Selectivity results.
% INPUT:
%     Name - RGCs name;
%     SavePath - the saving path of the plotting results.
%     SaveIndex - 1 means saving results, and 0 means only showing results.

%% save results;
SaveName = [SavePath,strcat(Name(1:end-4)),'_DirectionSelectivity'];
if SaveIndex == 1
    saveas(gcf,strcat(SaveName,'.jpg'));
end
close all;

end