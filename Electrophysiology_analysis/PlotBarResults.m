function PlotBarResults(BarData_Check,BarDirectionNumbers,Name)
%SINGLENEURONSHOLL Check bar data of a RGC neuron.
% INPUT:
%     BarData_Check - a checked Bars data;
%     BarDirectionNumbers - moving bar direction numbers;
%     Name - RGCs name;

%% get RGCs Directive Response data;
ThetaTick = 0:360/BarDirectionNumbers:360;
BarMeanResponse_Raw = BarData_Check.BarResponse.MeanResponse(1:8,1);
BarMeanResponse = [BarMeanResponse_Raw(2:end);BarMeanResponse_Raw(1)];
Rho_Mean = [BarMeanResponse(end);BarMeanResponse]/max(BarMeanResponse)*0.98;

%% plot RGCs Directive Response;
polarplot(deg2rad(ThetaTick),Rho_Mean,'r','LineWidth',3);
set(gca,'ThetaTick',[0:45:360]);
set(gca,'RTick',[0:0.2:1])
set(gca,'RTickLabel',[]);
set(gca,'GridAlpha',0.5,'FontSize',15);
title(Name);

end