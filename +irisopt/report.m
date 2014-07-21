function Def = report()
% report  [Not a public function] Default options for report functions.
%
% Backend IRIS function.
% No help provided.

% -IRIS Toolbox.
% -Copyright (c) 2007-2014 IRIS Solutions Team.

%--------------------------------------------------------------------------

Def = struct();

Def.publish = { ...
    'abstract','',@(x) isempty(x) || ischar(x), ...
    'abstractwidth','',@(x) isnumericscalar(x) && x > 0 && x <= 1, ...
    'author','',@ischar, ...
    'cleanup,deletelatex,deletetempfiles',true,@islogicalscalar, ...
    'compile',true,@islogicalscalar, ...
    'date','\today',@ischar, ...
    'epstopdf',Inf,@(x) isequal(x,Inf) || ischar(x), ...
    'fontenc','T1',@ischar, ...
    'maketitle',false,@islogical, ...
    'papersize','letterpaper',@(x) any(strcmpi(x,{'a4','a4paper','letter','letterpaper'})), ...
    'package',{},@(x) ischar(x) || iscellstr(x) || isempty(x), ...
    'preamble','',@ischar, ...
    'progress',false,@islogicalscalar, ...
    'title',Inf,@(x) ischar(x) || isequal(x,Inf), ...
    'timestamp',@() datestr(now()),@(x) ischar(x) || isfunc(x), ...
    'textscale,scale',0.8,@(x) isnumeric(x) && (length(x) == 1 || length(x) == 2), ...
    'tempdir',@() mosw.tempname(pwd()),@(x) isfunc(x) || ischar(x), ...
    };

end
