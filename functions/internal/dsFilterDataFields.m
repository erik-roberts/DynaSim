function data = dsFilterDataFields(data, dataOnlyIncludeRE, dataExcludeRE)
%% dsFilterDataFields
% Purpose: include and exclude fields in the data structure
%
% Usage: data = dsFilterDataFields(data, dataOnlyIncludeRE, dataExcludeRE)
%
% Note: exclude is applied after include

includeVars = [{'time', 'varied', 'labels', 'model', 'simulator_options'} data.varied(:)'];
reOnlyIncludeVars = {};
reExcludeVars = {};

flds = fieldnames(data);

if ~isempty(dataOnlyIncludeRE)
  reOnlyIncludeVars = regexp(flds, dataOnlyIncludeRE, 'match');
  reOnlyIncludeVars = [reOnlyIncludeVars{:}];
end

if ~isempty(dataExcludeRE)
  reExcludeVars = regexp(flds, dataExcludeRE, 'match');
  reExcludeVars = [reExcludeVars{:}];
  
  % don't remove the needed vars
  reExcludeVars = reExcludeVars( ~ismember(reExcludeVars(:), includeVars(:)) );
end

% take all include vars
onlyIncludeVars = [includeVars(:); reOnlyIncludeVars(:)];
onlyIncludeVars = unique(onlyIncludeVars);

% remove reExcludeVars
onlyIncludeVars = onlyIncludeVars( ~ismember(onlyIncludeVars(:), reExcludeVars(:)) );

% get excludeVars
excludeVars = flds; % start with all
excludeVars = excludeVars( ~ismember(excludeVars, onlyIncludeVars) );

% remove exclude vars
if ~isempty(excludeVars)
  for iVar = 1:length(excludeVars)
    data = rmfield(data, excludeVars{iVar});
  end
end

end % main