function Def = tseries()
% tseries  [Not a public function] Default options for tseries class functions.
%
% Backend IRIS function.
% No help provided.

% -IRIS Toolbox.
% -Copyright (c) 2007-2014 IRIS Solutions Team.

%--------------------------------------------------------------------------

Def = struct();

config = irisget();

Def.acf = { ...
    'demean',true,@is.logicalscalar, ...
    'order',0,@is.numericscalar, ...
    'smallsample',true,@is.logicalscalar, ...
    };

Def.bpass = { ...
    'addtrend',true,@is.logicalscalar, ...
    'detrend',true,@is.logicalscalar, ...
    'log',false,@is.logicalscalar, ...
    'method','cf',@(x) ischar(x) && any(strcmpi(x,{'cf','hwfsf'})), ...
    'ttrend',[],@(x) isempty(x) || is.logicalscalar(x), ...
    'unitroot',true,@is.logicalscalar, ...
    'window','hamming',@(x) ischar(x) && any(strcmpi(x,{'hamming','hanning','none'})), ...
    };

Def.chowlin = { ...
    'constant',true,@is.logicalscalar, ...
    'log',false,@is.logicalscalar, ...
    'ngrid',200,@(x) is.numericscalar(x) && x >= 1, ...
    'rho','estimate', ...
    @(x) any(strcmpi(x,{'auto','estimate','negative','positive'})) ...
    || (is.numericscalar(x) && x > -1 && x < 1), ...
    'timetrend',false,@is.logicalscalar, ...
    };

convert = { ...
    'function',[],@(x) isempty(x) || is.func(x) || ischar(x), ...
    'missing',NaN,@(x) (ischar(x) && any(strcmpi(x,{'last'}))) || is.numericscalar(x), ...
    'method',@mean,@(x) is.func(x) || isequal(x,'first') || isequal(x,'last'), ...
    'select',Inf,@(x) isnumeric(x), ...    
    'standinmonth',1,@(x) is.numericscalar(x) || isequal(x,'first') || isequal(x,'last'), ...
    };

Def.convertaggregdaily = [convert,{ ...
    'ignorenan',true,@islogical, ...
    }];

Def.convertaggreg = [convert,{ ...
    'ignorenan',false,@islogical, ...
    }];

Def.convertinterp = [convert,{ ...
    'ignorenan',false,@islogical, ...
    'method','pchip',@(x) ischar(x), ...
    'position','centre',@(x) ischar(x) && any(strncmpi(x,{'c','s','e'},1)), ...
    }];

Def.cumsumk = { ...
    'log',false,@is.logicalscalar, ...
    };

Def.errorbar = { ...
    'relative',true,@is.logicalscalar, ...
    };

Def.expsmooth = { ...
    'init',NaN,@isnumeric, ...
    'log',false,@is.logicalscalar, ...
};

Def.fft = { ...
    'full',false,@is.logicalscalar, ...
    };

Def.filter = { ...
    'change,growth',[],@(x) isempty(x) || is.tseries(x), ...
    'gamma',1,@(x) isa(x,'tseries') || (is.numericscalar(x) && x > 0), ...
    'cutoff',[],@(x) isempty(x) || (isnumeric(x) && all(x(:) > 0)), ...
    'cutoffyear',[],@(x) isempty(x) || (isnumeric(x) && all(x(:) > 0)), ...
    'drift',0,@(x) isnumeric(x) && length(x) == 1, ...
    'gap',[],@(x) isempty(x) || is.tseries(x), ...
    'infoset',2,@(x) isequal(x,1) || isequal(x,2), ...
    'lambda',@auto,@(x) isequal(x,@auto) || isempty(x) ...
    || (isnumeric(x) && all(x(:) > 0)) || (ischar(x) && strcmpi(x,'auto')), ...
    'level',[],@(x) isempty(x) || is.tseries(x), ...
    'log',false,@islogical, ...
    'swap',false,@islogical, ...
    'forecast',[],@(x) isnumeric(x) && length(x) <= 1, ...
    };

Def.myplot = { ...
    'dateformat','config',config.validate.plotdateformat, ...
    'freqletters,freqletter','config',config.validate.freqletters, ...
    'months,month','config',config.validate.months, ...
    'standinmonth','config',config.validate.standinmonth, ...
    'datetick,dateticks',Inf,@(x) isnumeric(x) ...
    || any(strcmpi(x,{'yearstart','yearend','yearly'})) ...
    || is.func(x), ...
    'dateposition','c',@(x) ischar(x) && ~isempty(x) && any(x(1) == 'sec'), ...
    'function',[],@(x) isempty(x) || is.func(x), ...
    'tight',false,@is.logicalscalar, ...
    'xlimmargin','auto',@(x) is.logicalscalar(x) || (ischar(x) && strcmpi(x,'auto')), ...
    };

Def.interp = { ...
    'method','pchip',@ischar, ...
    };

Def.moving = { ...
    'window',Inf,@isnumeric, ...
    'function',@mean,@is.func, ...
    };

Def.barcon = {
    'barwidth',0.8,@is.numericscalar, ...
    'colormap',[],@isnumeric, ...
    'evenlyspread',true,@is.logicalscalar, ...
    'ordering','preserve',@(x) is.anychari(x,{'descend','ascend','preserve'}) ...
    || isnumeric(x), ...
    };

Def.normalise = { ...
    'mode','mult',@(x) any(strncmpi(x,{'add','mult'},3)), ...
    };

Def.pct = { ...
    'outputfreq,freq',[],@(x) isempty(x) ...
    || (is.numericscalar(x) && any(x == [1,2,4,6,12])), ...
    };

Def.plotcmp = { ...
    'compare',[-1;1],@isnumeric, ...
    'cmpcolor,diffcolor',[1,0.75,0.75],@(x) isnumeric(x) && length(x) == 3 && all(x >= 0) && all(x <= 1), ...
    'rhsplotfunc',[],@(x) isempty(x) || is.anychari(char(x),{'bar','area'}), ...
    'cmpplotfunc,diffplotfunc',@bar,@(x) is.anychari(char(x),{'bar','area'}), ...
    };

Def.plotpred = { ...
    'connect',true,@is.logicalscalar, ...
    'firstline',{},@(x) iscell(x) && iscellstr(x(1:2:end)), ...
    'predlines',{},@(x) iscell(x) && iscellstr(x(1:2:end)), ...
    'firstmarker,firstmarkers,startpoint,startpoints','.',@(x) ischar(x) ...
    && any(strcmpi(x,{'none','+','o','*','.','x','s','d','^','v','>','<','p','h'})), ...
    'shownanlines',true,@is.logicalscalar, ...
};

Def.plotyy = { ...
    Def.myplot{:}, ...
    'coincident',false,@is.logicalscalar, ...
    'highlight',[],@isnumeric, ...
    'lhsplotfunc',@plot,@(x) ischar(x) || is.func(x), ...
    'rhsplotfunc',@plot,@(x) ischar(x) || is.func(x), ...
    'lhstight',false,@is.logicalscalar, ...
    'rhstight',false,@is.logicalscalar, ...
    };

Def.regress = {...
    'constant,const',false,@islogical, ...
    'weighting',[],@(x) (isnumeric(x) && isempty(x)) || is.tseries(x),...
    };

Def.spy = { ...
    Def.myplot{:}, ...
    'names,name',{},@iscellstr, ...
    'test',@isfinite,@(x) is.func(x), ...    
    };

Def.trend = { ...
    'break',[],@isnumeric, ...
    'connect',true,@is.logicalscalar, ...
    'diff',false,@is.logicalscalar, ...
    'log',false,@is.logicalscalar, ...
    'season',false,@(x) isempty(x) || is.logicalscalar(x) || is.numericscalar(x), ...
    };

Def.windex = { ...
    'log',false,@islogical, ...
    'method','simple',@(x) ischar(x) && any(strcmpi(x,{'simple','divisia'})), ...
    };

Def.x12 = { ...
    'backcast,backcasts',0,@(x) is.numericscalar(x), ...
    'cleanup,deletetempfiles,deletetempfile,deletex12file,deletex12file,delete',true,@is.logicalscalar, ...
    'dummy',[],@(x) isempty(x) || isa(x,'tseries'), ...
    'dummytype','holiday',@(x) ischar(x) && any(strcmpi(x,{'holiday','td','ao'})), ...
    'display',false,@is.logicalscalar, ...
    'forecast,forecasts',0,@(x) is.numericscalar(x), ...
    'log',false,@is.logicalscalar, ...
    'maxiter',1500,@(x) is.numericscalar(x) && x > 0 && x == round(x), ...
    'maxorder',[2,1],@(x) isnumeric(x) && length(x) == 2 ...
    && any(x(1) == [1,2,3,4]) && any(x(2) == [1,2]), ...
    'missing',false,@is.logicalscalar, ...
    'mode','auto',@(x) (isnumeric(x) && any(x == -1 : 3)) || any(strcmp(x,{'add','a','mult','m','auto','sign','pseudo','pseudoadd','p','log','logadd','l'})), ...
    'output','d11',@(x) ischar(x) || iscellstr(x), ...
    'saveas','',@ischar, ...
    'specfile','default',@(x) ischar(x) || isinf(x), ...
    'tdays,tday',false,@is.logicalscalar, ...
    'tempdir','.',@(x) ischar(x) || is.func(x), ...
    'tolerance',1e-5,@(x) is.numericscalar(x) && x > 0, ...
    };

end