function data_out = dsResampleData(data, fs, varargin)
% dsResampleData - Resamples DynaSim data structure data
%
% Usage:
%   data_out = dsResampleData(data,'option',value)
%
% Inputs:
%   - data: DynaSim data structure (see dsCheckData)
%   - fs: data resampled to fs using a polyphase anti-aliasing filter
%
% Outputs:
%   - data_out: data structure all fields replaced by their decimated values
%
% See also: resample, dsPlotFR, dsAnalyzeStudy, dsSimulate, dsCheckData, dsSelectVariables

%% 1.0 Check inputs

data = dsCheckData(data, varargin{:});
% note: calling dsCheckData() at beginning enables analysis function to
% accept data matrix [time x cells] in addition to DynaSim data structure.

%% do the decimating
data_out = data;
for i = 1:length(data)
    % Identify all fields in data containing simulated output
    labels = data(i).labels;
    
    % Sweep through these fields and decimate
    for j = 1:length(labels)
        singleBool = isa(data(i).(labels{j}), 'single');
        
        if singleBool
          data_out(i).(labels{j}) = single(resample(double(data(i).(labels{j})), double(data(i).time), fs));
        else
          data_out(i).(labels{j}) = resample(data(i).(labels{j}), data(i).time, fs);
        end
    end
    
end


end
