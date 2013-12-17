function [OutData] = eval(This,InData,Range,varargin)

% -IRIS Toolbox.
% -Copyright (c) 2007-2013 IRIS Solutions Team.

if nargin<3
	Range = Inf ;
end
if ischar(Range)
	varargin = [Range, varargin] ;
	Range = Inf ;
end
pp = inputParser() ;
pp.addRequired('This',@(x) isa(x,'nnet')) ;
pp.addRequired('Data',@(x) isa(x,'tseries') || isa(x,'struct')) ;
pp.addOptional('Range',@(x) isnumeric(x) && isvector(x)) ;
pp.parse(This,InData,Range) ;
if This.nAlt>1
	utils.error('nnet:eval',...
		'Eval does not support input neural network objects with multiple parameterizations.') ;
end
if isinf(Range)
	if isstruct(InData)
		Var = cellfun(@(x) x{1}, ...
			regexp(This.Inputs,'\{[-\+]?\d*}','split'), ...
			'UniformOutput', false) ;
		Range = dbrange(InData,Var) ;
	else
		Range = range(InData) ;
	end
end

% Parse options
options = passvalopt('nnet.eval',varargin{:}) ;

% Handle data
if isstruct(InData)
	[InData] = datarequest('Inputs',This,InData,Range) ;
end
if options.Ahead>1 && This.nOutputs>1
	options.Output = 'dbase' ;
end

% Body
switch options.Output
	case 'tseries'
		OutData = tseries() ;
	case 'dbase'
		OutData = struct() ;
		for iOutput = 1:This.nOutputs
			OutData.(This.Outputs{iOutput}) = tseries() ;
		end
end
if options.Ahead>1
	kPred = InData ;
	for k = 1:options.Ahead
		kPred = eval(This,kPred,Range) ;
		switch options.Output
			case 'dbase'
				for iOutput = 1:This.nOutputs
					OutData.(This.Outputs{iOutput})(Range+k-1,k) = kPred(:,iOutput) ;
				end
			case 'tseries'
				% only one output if output is tseries and ahead>1
				OutData(Range+k-1,k) = kPred(:) ;
		end
	end
else	
	% Hidden Layers
	for iLayer = 1:This.nLayer
		OutData = tseries() ;
		for iNode = 1:This.Layout(iLayer)
			OutData(Range,iNode) ...
				= eval(This.Neuron{iLayer}{iNode},InData) ;
		end
	end
	
end

end

