function BarData_Check = CheckBarData(BarData_Current)
%SINGLENEURONSHOLL Check bar data of a RGC neuron.
% INPUT:
%     BarData_Current - a RGC data contained Bar data.
% OUTPUT:
%     BarData_Check - a checked Bars data;

if isfield(BarData_Current,'BarResponse')
    if size(BarData_Current.BarResponse,1) >= 8
        BarData_Check.BarResponse = BarData_Current.BarResponse;
    else
        errordlg('Bar direction is not right');
        return;
    end
else
    errordlg('Not right');
    return;
end


end