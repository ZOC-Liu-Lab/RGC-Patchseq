function PlotDendriteThetaData(ThetaRange,ThetaData,SavePath,Name,SaveIndex)
%PLOTASC plots the neuron asymmetry in a 2-dim space.
% INPUT:
%     ThetaData - the polarhistogram data for a RGC's dendrites;
%     ThetaRange - the corresponding coordinates of polar coordinates.
%     Name - RGCs morphological name;
%     SavePath - the saving path of the plotting results.
%     SaveIndex - 1 means saving results, and 0 means only showing results.

%% plot dendrites theta;
h= figure('InvertHardcopy','off','Color',[1 1 1],'Renderer','painters','outerposition',[1 1 500 500]);
polarhistogram('BinEdges',ThetaRange,'BinCounts',ThetaData,'FaceColor','w','EdgeColor',[0 0.4471 0.7412]);
h.CurrentAxes.ThetaTickLabel={};
h.CurrentAxes.RTickLabel={};
title(Name(1:end-4));

%% save results;
SaveName = [SavePath,strcat(Name(1:end-4))];
if SaveIndex == 1
    saveas(h,strcat(SaveName,'.jpg'));
end
close all;

end