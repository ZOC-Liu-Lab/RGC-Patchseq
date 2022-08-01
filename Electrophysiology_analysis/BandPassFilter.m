function FilterData = BandPassFilter(Data,Fs,LowFrequency,HighFrequency,Nth)      
% IIR filter;
% LowFrequency: 100Hz;
% HighFrequency: 3000Hz;
Wn_Low = 2 * LowFrequency / Fs;
Wn_High = 2 * HighFrequency / Fs;

[b,a] = butter(Nth,[Wn_Low,Wn_High]);
FilterData = filter(b, a, Data);
            
end