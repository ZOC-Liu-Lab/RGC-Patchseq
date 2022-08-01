function BarDirectionNumbers = GetBarDirectionNumbers(BarData_Check)
%SINGLENEURONSHOLL Check bar data of a RGC neuron.
% INPUT:
%     BarData_Check - a checked Bars data;
% OUTPUT:
%     BarDirectionNumbers - moving bar direction numbers;

BarDirectionNumbers = [];
if mod(size(BarData_Check.BarResponse,1),2) == 1
    BarDirectionNumbers = size(BarData_Check.BarResponse,1)-1;
else
    errordlg('Not right');
    return;
end

end