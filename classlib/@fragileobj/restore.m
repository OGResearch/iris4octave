function C = restore(C,This,varargin)
% restore  [Not a public function] Replace protected charcodes with
% original strings.
%
% Backend IRIS function.
% No help provided.

% -IRIS Toolbox.
% -Copyright (c) 2007-2014 IRIS Solutions Team.

opt = passvalopt('fragileobj.restore',varargin{:});

%--------------------------------------------------------------------------

% Return immediately.
if isempty(C) || isempty(This)
    return
end

ptn = regexppattern(This);
if is.matlab % ##### MOSW
    rplFunc = @doReplace; %#ok<NASGU>
    C = regexprep(C,ptn,'${rplFunc($0)}');
else
    C = mosw.octfun.dregexprep(C,ptn,'doReplace',0); %#ok<UNRCH>
end


    function C = doReplace(C0)
        K = fragileobj.char2dec(C0) - This.Offset;
        C = This.Store{K};
        if opt.delimiter
            C = [This.Open{K},C,This.Close{K}];
        end
    end % doReplace()


end