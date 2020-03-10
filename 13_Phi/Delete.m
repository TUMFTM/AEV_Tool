%% delete workspace except Database
function clearex(varargin)

a = evalin('base','HVAC_Data');

var = (size(varargin));

for i=1:nargin
    var{i}=varargin{i};
end

assignin('base','ClEaRGsJioU',var);
var = evalin('base','who(ClEaRGsJioU{:})');

clearvar = a(~ismember(a,var));
assignin('base','ClEaRGsJioU',clearvar);

evalin('base','clear(ClEaRGsJioU{:},''ClEaRGsJioU'')')

% clearvars