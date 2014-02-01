function Def = nnet()
% optim  [Not a public function] Default options for nnet package.
%
% Backend IRIS function.
% No help provided.

% -IRIS Toolbox.
% -Copyright (c) 2007-2014 IRIS Solutions Team.

%--------------------------------------------------------------------------

Def = struct();

Def.nnet = { ...
    'ActivationFn,Activation', 'linear', @(x) iscellstr(x) || ischar(x), ... 
	'OutputFn,Output', 'logistic', @(x) iscellstr(x) || ischar(x), ... 
	'Bias', false, @islogical, ...
    } ;

isPosInt = @(x) floor(x)==x && numel(x)==1 && x>0 ;

Def.estimate = { ...
    'optimset',{},@(x) isempty(x) || isstruct(x) || (iscell(x) && iscellstr(x(1:2:end))), ...
    'solver,optimiser,optimizer','fmin',@(x) (ischar(x) && is.anychari(x,{'fmin','lsqnonlin','pso'})), ...
    'Norm',@(x) norm(x,2), @is.func, ...
    'Select', {'activation','output'}, @iscell, ...
    'display', 'iter', @ischar, ...
    'maxiter', 1e+4, isPosInt, ...
    'maxfunevals', 1e+5, isPosInt, ...
    'tolfun', 1e-6, @(x) is.numericscalar(x) && x>0, ...
    'tolx', 1e-6, @(x) is.numericscalar(x) && x>0, ...
    'nosolution', 'penalty', true, ... % not really an option but needs to be here for optim.myoptimopts
    } ;

Def.eval = {...
    'Ahead', 1, @(x) is.numericscalar(x) && x>0, ...
    'Output', 'tseries', @(x) any(strcmpi(x,{'tseries','dbase'})), ...
    } ;

Def.plot = {...
    'Color,colour', 'blue', @(x) any(strcmpi(x,{'activation','blue'})) || isnumeric(x), ...
    } ;

isPosInt = @(x) is.numericscalar(x) && x>0 && x==floor(x) ;
Def.sstate = {...
    'Tolerance', 1e-6, @(x) is.numericscalar(x) && x>0, ...
    'MaxIt,MaxIter', 1e+4, isPosInt, ...
    } ;

Def.prune = {...
    'EstimationOpts,Estimation', {}, @iscell, ...
    'Depth', 1, isPosInt, ... % how deep to check for anti-symmetry 
    'Method', 'correlation', @(x) any(strcmpi(x,{'correlation','obd'})), ...
    'Norm',@(x) norm(x,2), @is.func, ...
    'Progress', false, @islogical, ...
    'Parallel,UseParallel', false, @islogical, ...
    'Recursive', 0, isPosInt, ...
    'Select','activation', @(x) any(strcmpi(x,{'activation'})), ...
    } ;

end


