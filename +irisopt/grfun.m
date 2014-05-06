function Def = grfun()
% grfun  [Not a public function] Default options for the +grfun package.
%
% Backend IRIS function.
% No help provided.

% -IRIS Toolbox.
% -Copyright (c) 2007-2014 IRIS Solutions Team.

%--------------------------------------------------------------------------

Def = struct();

caption = { ...
    'caption','',@ischar, ...
    'vposition','top', ...
    @(x) (is.numericscalar(x) && x >= 0 && x <= 1) ...
    || (ischar(x) && any(strcmpi(x,{'top','bottom','centre','center','middle'}))), ...
    'hposition','right', ...
    @(x) ischar(x) && any(strcmpi(x,{'right','left','centre','center','middle'})), ...
    };

Def.bardatatips = { ...
    'format','%g',@ischar, ...
    };

Def.vline = {
    caption{:}, ...
    'excludefromlegend',true,@(isArg)is.logicalscalar(isArg), ...
    'timeposition','middle',@(x) is.anychari(x,{'middle','before','after'}), ...
    }; %#ok<CCAT>

Def.highlight = { ...
    caption{:}, ...
    'around',NaN,@(isArg)is.numericscalar(isArg), ...
    'color,colour',0.8*[1,1,1],@(x) (isnumeric(x) && length(x) == 3) || ischar(x) || (is.numericscalar(x) && x >= 0 && x <= 1), ...
    'excludefromlegend',true,@(isArg)is.logicalscalar(isArg), ...
    'transparent',0,@(x) is.numericscalar(x) && x >= 0 && x <= 1, ...
    }; %#ok<CCAT>

Def.hline = {
    caption{:}, ...
    'excludefromlegend',true,@(isArg)is.logicalscalar(isArg), ...
    }; %#ok<CCAT>

Def.plotcircle = { ...
    'fill',false,@(isArg)is.logicalscalar(isArg), ...
    };

Def.ploteig = { ...
    'ucircle,unitcircle',true,@(isArg)is.logicalscalar(isArg), ...
    'quadrants',true,@(isArg)is.logicalscalar(isArg), ...
    };

Def.plotmat = { ...
    'colnames,colname','auto',@(x) isempty(x) || iscellstr(x) || ischar(x), ...
    'rownames,rowname','auto',@(x) isempty(x) || iscellstr(x) || ischar(x), ...
    'maxcircle',false,@(isArg)is.logicalscalar(isArg), ...
    'naninf','X',@(x) ischar(x) && length(x) == 1, ...
    'scale','auto',@(x) (ischar(x) && strcmpi(x,'auto')) ...
    || (is.numericscalar(x) && x > 0), ...
    'showdiag',true,@(isArg)is.logicalscalar(isArg), ...
    ... Bkw compatibility options:
    'frame',[],@(x) isempty(x) || is.logicalscalar(x), ...
    };

Def.plotneigh = { ...
    'caption',[],@(x) isempty(x) || iscellstr(x), ...
    'plotobj',true,@(x) is.logicalscalar(x) || (iscell(x) && iscellstr(x(1:2:end))), ...
    'plotlik',true,@(x) is.logicalscalar(x) || (iscell(x) && iscellstr(x(1:2:end))), ...
    'plotest',{'marker=','*','linestyle=','none','color=','red'},@(x) is.logicalscalar(x) || (iscell(x) && iscellstr(x(1:2:end))), ...
    'plotbounds',{'color=','red'},@(x) is.logicalscalar(x)  || (iscell(x) && iscellstr(x(1:2:end))), ...
    'subplot','auto',@(x) isnumeric(x) || (ischar(x) && strcmpi(x,'auto')), ...
    'title',{'interpreter=','none'},@(x) isempty(x) || is.logicalscalar(x) || (iscell(x) && iscellstr(x(1:2:end))), ...
    'linkaxes',false,@(isArg)is.logicalscalar(isArg), ...
    };

Def.plotpp = { ...
    'axes',{},@(x) iscell(x) && iscellstr(x(1:2:end)), ...
    'caption',[],@(x) isempty(x) || iscellstr(x), ...
    'describe,describeprior','auto',@(x) isequal(x,'auto') || is.logicalscalar(x), ...
    'ksdensity',[],@(x) isempty(x) || is.intscalar(x), ...
    'figure',{},@(x) iscell(x) && iscellstr(x(1:2:end)), ...
    'plotinit',false,@(x) is.logicalscalar(x) || (iscell(x) && iscellstr(x(1:2:end))), ...
    'plotmode',true,@(x) is.logicalscalar(x) || (iscell(x) && iscellstr(x(1:2:end))), ...
    'plotprior',true,@(x) is.logicalscalar(x) || (iscell(x) && iscellstr(x(1:2:end))), ...
    'plotposter',true,@(x) is.logicalscalar(x) || (iscell(x) && iscellstr(x(1:2:end))), ...
    'plotbounds','auto',@(x) is.logicalscalar(x) || (ischar(x) && strcmpi(x,'auto')) ||  (iscell(x) && iscellstr(x(1:2:end))), ...
    'sigma',3,@(x) is.numericscalar(x) && x > 0, ...
    'subplot','auto',@(x) isequal(x,'auto') ...
    || (isnumeric(x) && length(x) == 2 && all(x == round(x)) && all(x > 0)), ...
    'tight',true,@(isArg)is.logicalscalar(isArg), ...
    'title',true,@(x) is.logicalscalar(x) || (iscell(x) && iscellstr(x(1:2:end))), ...
    'xlims',[],@(x) isempty(x) || isstruct(), ...
    };

Def.ftitle = { ...
    'location','north',@(x) is.anychari(x,{'north','west','east','south'}), ...
    };

Def.title = { ...
    'interpreter','latex',@(x) ischar(x) ...
    && any(strcmpi(x,{'latex','tex','none'})), ...
    };

Def.fsection = { ...
    'close',false,@(isArg)is.logicalscalar(isArg), ...
    'addto','',@ischar, ...
    'orient,orientation','landscape', @(x) isempty(x) ...
    || (ischar(x) && any(strcmpi(x,{'landscape','portrait','tall'}))), ...
    };

end