function varargout = irispathmanager(Req,varargin)
% irispathmanager  [Not a public function] IRIS path manager.
%
% Backend IRIS function.
% No help provided.

% -IRIS Toolbox.
% -Copyright (c) 2007-2014 IRIS Solutions Team.

%--------------------------------------------------------------------------

switch lower(Req)
    case 'cleanup'
        % Remove all IRIS roots and subs found on the Matlab temporary
        % and permanent search paths.
        varargout{1} = {};
        list = which('irisstartup.m','-all');
        if ~iscell(list) % in Octave option -all is not working yet, so the result is [char] as in case w/o options
          list = {list};
        end
        for i = 1 : numel(list)
            root = fileparts(list{i});
            if isempty(root)
                continue
            end
            [~,allp] = irisgenpath(root);
            xxRmPath(allp{:});
            xxRmPath(root);
            varargout{1}{end+1} = root;
        end
        rehash();
    
    case 'addroot'
        % Add the specified root to the temporary search paths.
        addpath(varargin{1},'-begin');
    
    case 'addcurrentsubs'
        % Add subfolders within the current root to the temporary
        % search path.
        [p,allp] = irisgenpath();
        if false % ##### MOSW
            % Do nothing.
        else 
            if ~isempty(p.OctBegin) %#ok<UNRCH>
                addpath(p.OctBegin{:},'-begin');
            end
        end
        if ~isempty(p.Begin)
            addpath(p.Begin{:},'-begin');
        end
        if ~isempty(p.End)
            addpath(p.End{:},'-end');
        end
        if false % ##### MOSW
            % Do nothing.
        else
            if ~isempty(p.OctEnd) %#ok<UNRCH>
                addpath(p.OctEnd{:},'-end');
            end
        end
        varargout{1} = allp;
        
    case 'removecurrentsubs'
        % Remove subfolders within the current root from the temporary
        % and permanent search paths.
        [~,allp] = irisgenpath();
        xxRmPath(allp{:});
        varargout{1} = allp;
end

end


% Subfunctions...


%**************************************************************************


function xxRmPath(varargin)
if isempty(varargin)
    return
end
status = warning('query','all');
if false % ##### MOSW
    warning('off','MATLAB:rmpath:DirNotFound');
else
    warning('off','all');
end
rmpath(varargin{:});
warning(status);
end % xxRmPath()
