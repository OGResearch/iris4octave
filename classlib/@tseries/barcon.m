function varargout = barcon(varargin)
% barcon  Contribution bar graph for tseries objects.
%
% Syntax
% =======
%
%     [H,Range] = barcon(X,...)
%     [H,Range] = barcon(Range,X,...)
%     [H,Range] = barcon(Ax,Range,X,...)
%
% Input arguments
% ================
%
% * `Ax` [ handle | numeric ] - Handle to axes in which the graph will be
% plotted; if not specified, the current axes will used.
%
% * `Range` [ numeric ] - Date range; if not specified the entire range of
% the input tseries object will be plotted.
%
% * `X` [ tseries ] - Input tseries object whose columns will be ploted as
% a contribution bar graph.
%
% Output arguments
% =================
%
% * `H` [ handle | numeric ] - Handles to the bars plotted.
%
% * `Range` [ numeric ] - Actually plotted date range.
%
% Options
% ========
%
% * `'barWidth='` [ numeric | *`0.8`* ] - Width of bars as a percentage of
% the space each period occupies on the x-axis.
%
% * `'colorMap='` [ numeric | *`get(gcf(),'colorMap')`* ] - Color map used
% to fill the contribution bars.
%
% * `'evenlySpread='` [ *`true`* | `false` ] - Colors picked for the
% contribution bars are evenly spread across the color map.
%
% * `'ordering='` [ `'ascend'` | `'descend'` | *`'preserve'`* | numeric ] -
% Ordering of contributions with the same sign withinin each period;
% `'preserve'` means the original order will be preserved.
%
% See help on [`tseries/plot`](tseries/plot) and the built-in function
% `bar` for other options available.
%
% Description
% ============
%
% Example
% ========
%

% -IRIS Toolbox.
% -Copyright (c) 2007-2014 IRIS Solutions Team.

% AREA, BAR, BARCON, PLOT, PLOTYY, STEM

%--------------------------------------------------------------------------

[varargout{1:nargout}] = tseries.myplot('barcon',varargin{:});

end