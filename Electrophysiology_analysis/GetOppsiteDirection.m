function [Rpref,Rnull,Rpref_Direction] = GetOppsiteDirection(Rmaxresponse_Direction,BarResponse)
%SINGLENEURONSHOLL calculate DSI value from bar data.
% INPUT:
%     BarResponse - Bar response amplitude from all direction.
%     Rmaxresponse_Direction - the direction of the max response amplitude.
% OUTPUT:
%     Rpref - pref direction amplitude value;
%     Rnull - null direction amplitude value;
%     Rpref_Direction - pref direction;

%% get all Oppsite Directions;
DirectionInterval = length(BarResponse)/2;
for i = 1:length(Rmaxresponse_Direction)
    OppsiteDirection(i) = mod(Rmaxresponse_Direction(i)+DirectionInterval,length(BarResponse));
    if OppsiteDirection(i) == 0
        OppsiteDirection(i) = length(BarResponse);
    end
end

%% get Oppsite Directions of min response;
OppsiteResponse = BarResponse(OppsiteDirection);
Rminresponse = min(OppsiteResponse);

%% get Direction and response of Rpref and Rnull;
% Rnull_Direction = OppsiteDirection(find(OppsiteResponse == Rminresponse));
Rnull = Rminresponse;
Rpref_Direction = Rmaxresponse_Direction(find(OppsiteResponse == Rminresponse));
Rpref = unique(BarResponse(Rmaxresponse_Direction));

end