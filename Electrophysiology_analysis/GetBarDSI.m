function DSI = GetBarDSI(BarResponse)
%SINGLENEURONSHOLL calculate DSI value from bar data.
% INPUT:
%     BarResponse - Bar response amplitude from all direction.
% OUTPUT:
%     DSI - calculated DSI value;


%% identify whether the response of all direction are equal;
if length(unique(BarResponse)) ~= 1
    %% calculate DSI and OSI value;
    Rmaxresponse = max(BarResponse);
    Rmaxresponse_Direction = find(BarResponse == Rmaxresponse);
    
    %% get Direction and response of Rpref and Rnull;
    [Rpref,Rnull,Rpref_Direction] = GetOppsiteDirection(Rmaxresponse_Direction,BarResponse);
    
    %% calculate DSI value;
    DSI = (Rpref - Rnull)/(Rpref + Rnull);
    
else
    DSI = 0;
end


end