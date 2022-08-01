function [index,waveforms,tscale] = SpikeDetection(Data,wfpara,align,SampleFrequency)
% Get spike waveforms from Raw Data;
%  Data:   data recorded;
%   WFPARA=[gate,lengthT,pregateR,deadT]
%       gate:             Threadhold to indicate a spike occupies;
%       lengthT:         Time duation of each spike; in millisecond;
%       pregateR:       Samples before the Threadhold /samples of one spike;
%       deadT:           Dead time between spikes; in millisecond;
%
%   align:               alignment selection: 'valley(v)','peak(p)','gate(g)';
%                            'valley', all waveforms aligned at the valley of spikes;
%                            'peak', aligned at the maximum points;
%                            'gate', aligned at the threadhold;
%
% Return
%   index:               position of each spike in the raw data;
%   waveforms:      2D array of spikes, spikes arranged by row;
%   tscale:              time scale of spike waveform;

if nargin <=2
    align = 'gate';
end
gate = wfpara(1);
lengthT= wfpara(2);
pregateR = wfpara(3);
deadT = wfpara(4);

lengthN = round(SampleFrequency*lengthT/1000);
segN = round(lengthN/5);
pregateN = round(lengthN*pregateR);
posgateN = lengthN-pregateN-1;
deadN = round(deadT*SampleFrequency/1000);

tscale = (1:lengthN)/SampleFrequency*1000;
ls = length(Data);
midvalue = mean(Data);
%Make room at data's head and tail,avoid array index out of boundary

data = Data;


if gate > midvalue
    ascend = 1;
else
    ascend = 0;
end

ind = 1;
index = [];
waveforms = [];
endpos = ls-2*lengthN-1;
ti = lengthN;


switch align
    case {'gate','g'}
        ti = pregateN+1;
        
        while ti<endpos
            IsSpike = 0;
            if ascend           % threshold above average;
                if data(ti-1)<gate & data(ti)>=gate
                    IsSpike = 1;
                end
            elseif data(ti-1)>gate & data(ti)<=gate  % threshold below average
                IsSpike = 1;
            end
            
            if IsSpike == 1
                index(ind) = ti;
                ind = ind+1;
                ti = ti+posgateN+deadN;
            else
                ti = ti+1;
            end
        end
        
    case {'valley','v'}
        ti = pregateN+1;
        
        while ti < endpos
            edp = ti+lengthN-1;
            [vvalue,vpos] = min(Data(ti:edp));
            while (vpos == lengthN) & (edp < endpos)
                ti = edp-1;
                edp = ti+lengthN-1;
                [vvalue,vpos] = min(Data(ti:edp));
            end
            if vvalue <= gate
                vpos = ti+vpos-1;
                if Data(vpos-pregateN) > vvalue & Data(vpos+posgateN) > vvalue
                    index(ind) = vpos;
                    ind = ind+1;
                end
                ti = vpos+posgateN+1+deadN;
                
            else
                ti = edp+1;
            end
        end
        
    case {'peak', 'p'}
        ti = pregateN+1;
        
        while ti < endpos
            edp = ti+segN-1;
            [pvalue, ppos] = max(data(ti:edp));
            while (ppos == segN) & (edp < endpos)
                ti = edp-1;
                edp = ti+segN-1;
                [pvalue, ppos] = max(data(ti:edp));
            end
            if (pvalue >= gate & ppos ~= 1)
                ppos = ti+ppos-1;
                if data(ppos-pregateN) < pvalue & data(ppos+posgateN) < pvalue
                    index(ind) = ppos;
                    ind = ind+1;
                end
                ti = ppos+posgateN+1+deadN;
            else
                ti = edp+1;
            end
        end
    otherwise
        error('No such aligment method defined!');
end


if nargout > 1
    waveforms = zeros(length(index),lengthN);
    for ti = 1:length(index)
        pos = index(ti);
        waveforms(ti,:) = Data((pos-pregateN):(pos+posgateN));
    end
    
end


