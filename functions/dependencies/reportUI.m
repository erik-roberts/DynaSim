function ui = reportUI

coder.extrinsic('exist');

isoctave = exist('OCTAVE_VERSION', 'builtin');

if isoctave
  ui = 'octave';
else
  ui = 'matlab';
end

% old version that had issues with mex compilation:
% % function that reports ui, that is whether Octave or matlab is in use
% LIC = license('inuse');
% ui = LIC.feature;
% % matlab toolboxes and octave packages are added to inuse, unfortunately 'matlab'' appears last (after tootlboxes) and octave first (before packages), what follows is a workaround to always report the proper UI:
% if ~strcmp(ui,'octave')
%   ui = 'matlab';

end
