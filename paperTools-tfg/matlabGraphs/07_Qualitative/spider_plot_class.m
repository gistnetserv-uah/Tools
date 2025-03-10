classdef spider_plot_class < matlab.graphics.chartcontainer.ChartContainer & ...
        matlab.graphics.chartcontainer.mixin.Legend
    %spider_plot_class Create a spider or radar plot with individual axes.
    %
    % Syntax:
    %   s = spider_plot_class(P)
    %   s = spider_plot_class(P, Name, Value, ...)
    %   s = spider_plot_class(parent, ___)
    %
    % Input Arguments:
    %   (Required)
    %   P                - The data points used to plot the spider chart. The
    %                      rows are the groups of data and the columns are the
    %                      data points. The axes labels and axes limits are
    %                      automatically generated if not specified.
    %                      [vector | matrix]
    %
    % Name-Value Pair Arguments:
    %   (Optional)
    %   AxesLabels       - Used to specify the label each of the axes.
    %                      [auto-generated (default) | array of strings | 'none']
    %
    %   AxesInterval     - Used to change the number of intervals displayed
    %                      between the webs.
    %                      [3 (default) | integer]
    %
    %   AxesPrecision    - Used to change the precision level on the value
    %                      displayed on the axes.
    %                      [1 (default) | integer | vector]
    %
    %   AxesDisplay      - Used to change the number of axes in which the
    %                      axes text are displayed. 'None' or 'one' can be used
    %                      to simplify the plot appearance for normalized data.
    %                      ['all' (default) | 'none' | 'one']
    %
    %   AxesLimits       - Used to manually set the axes limits. A matrix of
    %                      2 x size(P, 2). The top row is the minimum axes
    %                      limits and the bottow row is the maximum axes limits.
    %                      [auto-scaled (default) | matrix]
    %
    %   FillOption       - Used to toggle color fill option.
    %                      ['off' (default) | 'on']
    %
    %   FillTransparency - Used to set color fill transparency.
    %                      [0.1 (default) | scalar in range (0, 1)]
    %
    %   Color            - Used to specify the line color, specified as an RGB
    %                      triplet. The intensities must be in the range (0, 1).
    %                      [MATLAB Color (default) | RGB triplet]
    %
    %   LineStyle        - Used to change the line style of the plots.
    %                      ['-' (default) | '--' | ':' | '-.' | 'none']
    %
    %   LineWidth        - Used to change the line width, where 1 point is
    %                      1/72 of an inch.
    %                      [0.5 (default) | positive value]
    %
    %   Marker           - Used to change the options.Marker symbol of the plots.
    %                      ['o' (default) | 'none' | '*' | 's' | 'd' | ...]
    %
    %   MarkerSize       - Used to change the options.Marker size, where 1 point is
    %                      1/72 of an inch.
    %                      [8 (default) | positive value]
    %
    %   AxesFontSize     - Used to change the font size of the values
    %                      displayed on the axes.
    %                      [10 (default) | scalar value greater than zero]
    %
    %   LabelFontSize    - Used to change the font size of the labels.
    %                      [10 (default) | scalar value greater than zero]
    %
    %   Direction        - Used to change the direction of rotation of the
    %                      plotted data and axis labels.
    %                      ['clockwise' (default) | 'counterclockwise']
    %
    %   AxesDirection     - Used to change the direction of axes.
    %                      ['normal' (default) | 'reverse' | cell array of character vectors]
    %
    %   AxesLabelsOffset - Used to adjust the position offset of the axes
    %                      labels.
    %                      [0.1 (default) | positive value]
    %
    %   AxesScaling      - Used to change the scaling of the axes.
    %                      ['linear' (default) | 'log' | cell array of character vectors]
    %
    %   AxesColor        - Used to change the color of the spider axes.
    %                      [grey (default) | RGB triplet | hexadecimal color code]
    %
    %   AxesLabelsEdge   - Used to change the edge color of the axes labels.
    %                      [black (default) | RGB triplet | hexadecimal color code | 'none']
    %
    %   LegendLabels     - Used to add the labels to the legend.
    %                      [cell array of character vectors]
    %
    %   LegendHandle     - Used to customize legend settings. 
    %                      [legend handle object]
    %
    % Output Arguments:
    %   (Optional)
    %   s                - Returns a chart class object. These are unique
    %                      identifiers, which you can use to query and
    %                      modify properties of the spider chart.
    %                      [chart class object]
    %
    % Examples:
    %   % Example 1: Minimal number of arguments. All non-specified, optional
    %                arguments are set to their default values. Axes labels
    %                and limits are automatically generated and set.
    %
    %   D1 = [5 3 9 1 2];
    %   D2 = [5 8 7 2 9];
    %   D3 = [8 2 1 4 6];
    %   P = [D1; D2; D3];
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_class(P);
    %   s.LegendLabels = {'D1', 'D2', 'D3'};
    %   s.LegendHandle.Location = 'southoutside';
    %
    %   % Example 2: Manually setting the axes limits and axes precision.
    %                All non-specified, optional arguments are set to their
    %                default values.
    %
    %   D1 = [5 3 9 1 2];
    %   D2 = [5 8 7 2 9];
    %   D3 = [8 2 1 4 6];
    %   P = [D1; D2; D3];
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_class(P);
    %   s.AxesLimits = [1, 2, 1, 1, 1; 10, 8, 9, 5, 10]; % [min axes limits; max axes limits]
    %   s.AxesPrecision = [0, 1, 1, 1, 1];
    %
    %   % Example 3: Set fill option on. The fill transparency can be adjusted.
    %
    %   D1 = [5 3 9 1 2];
    %   D2 = [5 8 7 2 9];
    %   D3 = [8 2 1 4 6];
    %   P = [D1; D2; D3];
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_class(P);
    %   s.AxesLabels = {'S1', 'S2', 'S3', 'S4', 'S5'};
    %   s.AxesInterval = 2;
    %   s.FillOption = 'on';
    %   s.FillTransparency = 0.1;
    %
    %   % Example 4: Maximum number of arguments.
    %
    %   D1 = [5 3 9 1 2];
    %   D2 = [5 8 7 2 9];
    %   D3 = [8 2 1 4 6];
    %   P = [D1; D2; D3];
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_class(P);
    %   s.AxesLabels = {'S1', 'S2', 'S3', 'S4', 'S5'};
    %   s.AxesInterval = 4;
    %   s.AxesPrecision = 0;
    %   s.AxesDisplay = 'one';
    %   s.AxesLimits = [1, 2, 1, 1, 1; 10, 8, 9, 5, 10];
    %   s.FillOption = 'on';
    %   s.FillTransparency =  0.2;
    %   s.Color = [1, 0, 0; 0, 1, 0; 0, 0, 1];
    %   s.LineStyle = '--';
    %   s.LineWidth = 3;
    %   s.Marker =  'd';
    %   s.MarkerSize = 10;
    %   s.AxesFontSize = 12;
    %   s.LabelFontSize = 10;
    %   s.Direction = 'clockwise';
    %   s.AxesDirection = {'reverse', 'normal', 'normal', 'normal', 'normal'};
    %   s.AxesLabelsOffset = 0;
    %   s.AxesScaling = 'linear';
    %   s.LegendLabels = {'D1', 'D2', 'D3'};
    %   s.LegendHandle.Location = 'northeastoutside';
    %
    %   % Example 5: Excel-like radar charts.
    %
    %   D1 = [5 0 3 4 4];
    %   D2 = [2 1 5 5 4];
    %   P = [D1; D2];
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_class(P);
    %   s.AxesInterval = 5;
    %   s.AxesPrecision = 0;
    %   s.AxesDisplay = 'one';
    %   s.AxesLimits = [0, 0, 0, 0, 0; 5, 5, 5, 5, 5];
    %   s.FillOption = 'on';
    %   s.FillTransparency = 0.1;
    %   s.Color = [139, 0, 0; 240, 128, 128]/255;
    %   s.LineWidth = 4;
    %   s.Marker = 'none';
    %   s.AxesFontSize = 14;
    %   s.LabelFontSize = 10;
    %   title('Excel-like Radar Chart',...
    %       'FontSize', 14);
    %   s.LegendLabels = {'D1', 'D2'};
    %
    %   % Example 6: Logarithimic scale on all axes. Axes limits and axes
    %                intervals are automatically set to factors of 10.
    %
    %   D1 = [5 3 9 1 1];
    %   D2 = [5 8 7 2 10];
    %   D3 = [8 2 1 4 100];
    %   P = [D1; D2; D3];
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_class(P);
    %   s.AxesInterval = 2;
    %   s.AxesPrecision = 0;
    %   s.AxesFontSize = 10;
    %   s.AxesLabels = {'Linear Scale', 'Linear Scale', 'Linear Scale', 'Linear Scale', 'Logarithimic Scale'};
    %   s.AxesScaling = {'linear', 'linear', 'linear', 'linear', 'log'};
    %   s.AxesLimits = [1, 1, 1, 1, 1; 10, 10, 10, 10, 100];
    %   s.LegendLabels = {'D1', 'D2', 'D3'};
    %
    % Author:
    %   Moses Yoo, (jyoo at hatci dot com)
    %   2020-11-06: Fix bug in reverse axes direction feature.
    %   2020-10-08: Adjust axes precision to be set to one or more axis.
    %   2020-10-01: Fix legend feature with inherited legend class.
    %   2020-09-30: -Fix axes limit bug. Updated examples.
    %               -Added feature to change spider axes and axes labels edge color.
    %               -Allow logarithmic scale to be set to one or more axis.
    %               -Added feature to allow different line styles, line width,
    %                marker type, and marker sizes for the data groups.
    %               -Allow ability to reverse axes direction.
    %   2020-02-17: Major revision in converting the function into a custom
    %               chart class. New feature introduced in R2019b.
    %   2020-02-12: Fixed condition and added error checking for when only one
    %               data group is plotted.
    %   2020-01-27: Corrected bug where only 7 entries were allowed in legend.
    %   2020-01-06: Added support for tiledlayout feature introduced in R2019b.
    %   2019-11-27: Add option to change axes to logarithmic scale.
    %   2019-11-15: Add feature to customize the plot rotational direction and
    %               the offset position of the axis labels.
    %   2019-10-28: Major revision in implementing the new function argument
    %               validation feature introduced in R2019b. Replaced previous
    %               method of error checking and setting of default values.
    %   2019-10-23: Minor revision to set starting axes as the vertical line.
    %               Add customization option for font sizes and axes display.
    %   2019-10-16: Minor revision to add name-value pairs for customizing
    %               color, Marker, and line settings.
    %   2019-10-08: Another major revision to convert to name-value pairs and
    %               add color fill option.
    %   2019-09-17: Major revision to improve speed, clarity, and functionality
    %
    % Special Thanks:
    %   Special thanks to Gabriela Andrade, Andr�s Garcia, Alex Grenyer,
    %   Omar Hadri, Zafar Ali, Christophe Hurlin, Roman, Mariusz Sepczuk,
    %   Mohamed Abubakr, Maruis Mueller & Nicolai for their feature
    %   recommendations and bug finds. A huge thanks to Jiro Doke and
    %   Sean de Wolski for demonstrating the implementation of argument
    %   validation and custom chart class introduced in R2019b.
    
    %%% Public, SetObservable Properties %%%
    properties(Access = public, SetObservable)
        % Property validation and defaults
        P (:, :) double
        AxesLabels cell % Axes labels
        LegendLabels cell % Legend labels
        LegendHandle % Lengend handle
        AxesInterval (1, 1) double {mustBeInteger, mustBePositive} = 3 % Number of axes grid lines
        AxesPrecision (:, :) double {mustBeInteger, mustBeNonnegative} = 1 % Tick precision
        AxesDisplay char {mustBeMember(AxesDisplay, {'all', 'none', 'one'})} = 'all'  % Number of tick label groups shown on axes
        AxesLimits double = [] % Axes limits
        FillOption matlab.lang.OnOffSwitchState = 'off' % Whether to shade data
        FillTransparency (1, 1) double {mustBeGreaterThanOrEqual(FillTransparency, 0), mustBeLessThanOrEqual(FillTransparency, 1)} % Shading alpha
        Color = get(groot,'defaultAxesColorOrder') % Color order
        LineStyle = '-' % Data line style
        LineWidth (:, :) double {mustBePositive} = 2 % Data line width
        Marker = 'o' % Data marker
        MarkerSize (:, :) double {mustBePositive} = 8 % Data marker size
        AxesFontSize (1, 1) double {mustBePositive} = 10 % Axes tick font size
        LabelFontSize (1, 1) double {mustBePositive} = 10 % Label font size
        Direction char {mustBeMember(Direction, {'counterclockwise', 'clockwise'})} = 'clockwise'
        AxesDirection = 'normal'
        AxesLabelsOffset (1, 1) double {mustBeNonnegative} = 0.1 % Offset position of axes labels
        AxesScaling = 'linear' % Scaling of axes
        AxesColor = [0.6, 0.6, 0.6] % Axes color
        AxesLabelsEdge = 'k' % Axes label color
    end
    
    %%% Private, NonCopyable, Transient Properties %%%
    properties(Access = private, NonCopyable, Transient)
        % Data line object
        DataLines = gobjects(0)
        
        % Background web object
        ThetaAxesLines = gobjects(0)
        RhoAxesLines = gobjects(0)
        
        % Fill shade object
        FillPatches = gobjects(0)
        
        % Web axes tick values
        AxesValues = [];
        
        % Axes label object
        AxesTextLabels = gobjects(0)
        AxesTickLabels = gobjects(0)
        
        % Initialize toggle state
        InitializeToggle = true;
    end
    
    %%% Protected, Dependent, Hidden Properties %%%
    properties(Access = protected, Dependent, Hidden)
        NumDataGroups
        NumDataPoints
    end
    
    methods
        %%% Constructor Methods %%%
        function obj = spider_plot_class(parentOrP, varargin)
            % Validate number of input arguments
            narginchk(1, inf);
            
            % Check if first argument is a graphic object or data
            if isa(parentOrP, 'matlab.graphics.Graphics')
                % spider_plot_class(parent, P, Name, Value, ...)
                args = [{parentOrP, 'P'}, varargin];
            else
                % spider_plot_class(P, Name, Value, ...)
                args = [{'P', parentOrP}, varargin];
            end
            
            % Call superclass constructor method
            obj@matlab.graphics.chartcontainer.ChartContainer(args{:});
        end
        
        %%% Set Methods %%%
        function set.P(obj, value)
            % Set property
            obj.P = value;
            
            % Toggle re-initialize to true if P was changed
            obj.InitializeToggle = true; %#ok<*MCSUP>
        end
        
        function set.AxesLabels(obj, value)
            % Validate axes labels
            validateAxesLabels(value, obj.P);
            
            % Set property
            obj.AxesLabels = value;
            
            % Toggle re-initialize to true if AxesLabels was changed
            obj.InitializeToggle = true;
        end
        
        function set.LegendLabels(obj, value)
            % Validate legend labels
            validateLegendLabels(value, obj.P);
            
            % Set property
            obj.LegendLabels = value;
            obj.LegendVisible = 'on';
            
            % Set legend handle
            obj.LegendHandle = getLegend(obj);
            
            % Toggle re-initialize to true iLegendLabels was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesInterval(obj, value)
            % Set property
            obj.AxesInterval = value;
            
            % Toggle re-initialize to true if AxesInterval was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesPrecision(obj, value)
            % Set property
            obj.AxesPrecision = value;
            
            % Toggle re-initialize to true if AxesPrecision was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesDisplay(obj, value)
            % Set property
            obj.AxesDisplay = value;
            
            % Toggle re-initialize to true if AxesDisplay was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesLimits(obj, value)
            % Set property
            obj.AxesLimits = value;
            
            % Toggle re-initialize to true if AxesLimits was changed
            obj.InitializeToggle = true;
        end
        
        function set.FillOption(obj, value)
            % Set property
            obj.FillOption = value;
            
            % Toggle re-initialize to true if FillOption was changed
            obj.InitializeToggle = true;
        end
        
        function set.FillTransparency(obj, value)
            % Set property
            obj.FillTransparency = value;
            
            % Toggle re-initialize to true if FillTransparency was changed
            obj.InitializeToggle = true;
        end
        
        function set.Color(obj, value)
            % Set property
            obj.Color = value;
            
            % Toggle re-initialize to true if Color was changed
            obj.InitializeToggle = true;
        end
        
        function set.LineStyle(obj, value)
            % Set property
            obj.LineStyle = value;
            
            % Toggle re-initialize to true if LineStyle was changed
            obj.InitializeToggle = true;
        end
        
        function set.LineWidth(obj, value)
            % Set property
            obj.LineWidth = value;
            
            % Toggle re-initialize to true if LineWidth was changed
            obj.InitializeToggle = true;
        end
        
        function set.Marker(obj, value)
            % Set property
            obj.Marker = value;
            
            % Toggle re-initialize to true if Marker was changed
            obj.InitializeToggle = true;
        end
        
        function set.MarkerSize(obj, value)
            % Set property
            obj.MarkerSize = value;
            
            % Toggle re-initialize to true if MarkerSize was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesFontSize(obj, value)
            % Set property
            obj.AxesFontSize = value;
            
            % Toggle re-initialize to true if AxesFontSize was changed
            obj.InitializeToggle = true;
        end
        
        function set.LabelFontSize(obj, value)
            % Set property
            obj.LabelFontSize = value;
            
            % Toggle re-initialize to true if LabelFontSize was changed
            obj.InitializeToggle = true;
        end
        
        function set.Direction(obj, value)
            % Set property
            obj.Direction = value;
            
            % Toggle re-initialize to true if Direction was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesDirection(obj, value)
            % Set property
            obj.AxesDirection = value;
            
            % Toggle re-initialize to true if Direction was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesLabelsOffset(obj, value)
            % Set property
            obj.AxesLabelsOffset = value;
            
            % Toggle re-initialize to true if AxesLabelsOffset was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesScaling(obj, value)
            % Set property
            obj.AxesScaling = value;
            
            % Toggle re-initialize to true if AxesScaling was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesColor(obj, value)
            % Set property
            obj.AxesColor = value;
            
            % Toggle re-initialize to true if AxesColor was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesLabelsEdge(obj, value)
            % Set property
            obj.AxesLabelsEdge = value;
            
            % Toggle re-initialize to true if AxesLabelsEdge was changed
            obj.InitializeToggle = true;
        end
        
        %%% Get Methods %%%
        function num_data_points = get.NumDataPoints(obj)
            % Get number of data points
            num_data_points = size(obj.P, 2);
        end
        
        function num_data_groups = get.NumDataGroups(obj)
            % Get number of data groups
            num_data_groups = size(obj.P, 1);
        end
        
        function axes_labels = get.AxesLabels(obj)
            % Check if value is empty
            if isempty(obj.AxesLabels)
                % Set axes labels
                axes_labels = cellstr("Label " + (1:obj.NumDataPoints));
            else
                % Keep axes labels
                axes_labels = obj.AxesLabels;
            end
        end
        
        function legend_labels = get.LegendLabels(obj)
            % Check if value is empty
            if isempty(obj.LegendLabels)
                % Set legend labels
                legend_labels = cellstr("Data " + (1:obj.NumDataGroups));
            else
                % Keep legend labels
                legend_labels = obj.LegendLabels;
            end
        end
        
        function color = get.Color(obj)
            % Check if value is empty
            if isempty(obj.Color)
                % Set color order
                color = lines(obj.NumDataGroups);
            else
                % Keep color order
                color = obj.Color;
            end
        end
        
        function axes_limits = get.AxesLimits(obj)
            % Check number of data groups and axes limits
            if obj.NumDataGroups == 1 && isempty(obj.AxesLimits)
                error('Error: For one data group, please enter in a range for the axes limits.');
            end
            
            % Validate axes limits
            validateAxesLimits(obj.AxesLimits, obj.P);
            
            % Get property
            axes_limits = obj.AxesLimits;
        end
        
        function axes_precision = get.AxesPrecision(obj)
            % Check if axes precision is numeric
            if isnumeric(obj.AxesPrecision)
                % Check is length is one
                if length(obj.AxesPrecision) == 1
                    % Repeat array to number of data points
                    obj.AxesPrecision = repmat(obj.AxesPrecision, obj.NumDataPoints, 1);
                elseif length(obj.AxesPrecision) ~= obj.NumDataPoints
                    error('Error: Please specify the same number of axes precision as number of data points.');
                end
            else
                error('Error: Please make sure the axes precision is a numeric value.');
            end
            
            % Get property
            axes_precision = obj.AxesPrecision;
        end
        
        function axes_scaling = get.AxesScaling(obj)
            % Check if axes scaling is valid
            if any(~ismember(obj.AxesScaling, {'linear', 'log'}))
                error('Error: Invalid axes scaling entry. Please enter in "linear" or "log" to set axes scaling.');
            end
            
            % Check if axes scaling is a cell
            if iscell(obj.AxesScaling)
                % Check is length is one
                if length(obj.AxesScaling) == 1
                    % Repeat array to number of data groups
                    obj.AxesScaling = repmat(obj.AxesScaling, obj.NumDataPoints, 1);
                elseif length(obj.AxesScaling) ~= obj.NumDataPoints
                    error('Error: Please specify the same number of axes scaling as number of data points.');
                end
            else
                % Repeat array to number of data groups
                obj.AxesScaling = repmat({obj.AxesScaling}, obj.NumDataPoints, 1);
            end
            
            % Get property
            axes_scaling = obj.AxesScaling;
        end
        
        function line_style = get.LineStyle(obj)
            % Check if line style is a char
            if ischar(obj.LineStyle)
                % Convert to cell array of char
                obj.LineStyle = cellstr(obj.LineStyle);
                
                % Repeat cell to number of data groups
                obj.LineStyle = repmat(obj.LineStyle, obj.NumDataGroups, 1);
            elseif iscellstr(obj.LineStyle) %#ok<*ISCLSTR>
                % Check is length is one
                if length(obj.LineStyle) == 1
                    % Repeat cell to number of data groups
                    obj.LineStyle = repmat(obj.LineStyle, obj.NumDataGroups, 1);
                elseif length(obj.LineStyle) ~= obj.NumDataGroups
                    error('Error: Please specify the same number of line styles as number of data groups.');
                end
            else
                error('Error: Please make sure the line style is a char or a cell array of char.');
            end
            
            % Get property
            line_style = obj.LineStyle;
        end
        
        function line_width = get.LineWidth(obj)
            % Check if line width is numeric
            if isnumeric(obj.LineWidth)
                % Check is length is one
                if length(obj.LineWidth) == 1
                    % Repeat array to number of data groups
                    obj.LineWidth = repmat(obj.LineWidth, obj.NumDataGroups, 1);
                elseif length(obj.LineWidth) ~= obj.NumDataGroups
                    error('Error: Please specify the same number of line width as number of data groups.');
                end
            else
                error('Error: Please make sure the line width is a numeric value.');
            end
            
            % Get property
            line_width = obj.LineWidth;
        end
        
        function marker_style = get.Marker(obj)
            % Check if marker type is a char
            if ischar(obj.Marker)
                % Convert to cell array of char
                obj.Marker = cellstr(obj.Marker);
                
                % Repeat cell to number of data groups
                obj.Marker = repmat(obj.Marker, obj.NumDataGroups, 1);
            elseif iscellstr(obj.Marker)
                % Check is length is one
                if length(obj.Marker) == 1
                    % Repeat cell to number of data groups
                    obj.Marker = repmat(obj.Marker, obj.NumDataGroups, 1);
                elseif length(obj.Marker) ~= obj.NumDataGroups
                    error('Error: Please specify the same number of line styles as number of data groups.');
                end
            else
                error('Error: Please make sure the line style is a char or a cell array of char.');
            end
            
            % Get property
            marker_style = obj.Marker;
        end
        
        function marker_size = get.MarkerSize(obj)
            % Check if line width is numeric
            if isnumeric(obj.MarkerSize)
                if length(obj.MarkerSize) == 1
                    % Repeat array to number of data groups
                    obj.MarkerSize = repmat(obj.MarkerSize, obj.NumDataGroups, 1);
                elseif length(obj.MarkerSize) ~= obj.NumDataGroups
                    error('Error: Please specify the same number of line width as number of data groups.');
                end
            else
                error('Error: Please make sure the line width is numeric.');
            end
            
            % Get property
            marker_size = obj.MarkerSize;
        end
        
        function axes_direction = get.AxesDirection(obj)
            % Check if axes direction is a cell
            if iscell(obj.AxesDirection)
                % Check is length is one
                if length(obj.AxesDirection) == 1
                    % Repeat array to number of data groups
                    obj.AxesDirection = repmat(obj.AxesDirection, obj.NumDataPoints, 1);
                elseif length(obj.AxesDirection) ~= obj.NumDataPoints
                    error('Error: Please specify the same number of axes direction as number of data points.');
                end
            else
                % Repeat array to number of data groups
                obj.AxesDirection = repmat({obj.AxesDirection}, obj.NumDataPoints, 1);
            end
            
            % Get property
            axes_direction = obj.AxesDirection;
        end
    end
    
    methods (Access = public)
        function title(obj, title_text, varargin)
            % Get axes and title handles
            ax = getAxes(obj);
            tlt = ax.Title;
            
            % Set title string
            tlt.String = title_text;
            
            % Initialze name-value arguments
            name_arguments = varargin(1:2:end);
            value_arguments = varargin(2:2:end);
            
            % Iterate through name-value arguments
            for ii = 1:length(name_arguments)
                % Set name value pair
                name = name_arguments{ii};
                value = value_arguments{ii};
                tlt.(name) = value;
            end
        end
    end
    
    methods (Access = protected)
        %%% Setup Methods %%%
        function setup(obj)
            % Figure properties
            fig = gcf;
            fig.Color = 'w';
            
            % Axis properties
            ax = getAxes(obj);
            hold(ax, 'on');
            axis(ax, 'square');
            axis(ax, 'off');
            axis(ax, [-1, 1, -1, 1] * 1.3);
        end
        
        %%% Update Methods %%%
        function update(obj)
            % Check re-initialize toggle
            if obj.InitializeToggle
                % Reset graphic objects
                reset_objects(obj);
                initialize(obj);
                
                % Set initialize toggle to false
                obj.InitializeToggle = false;
            end
            
            % Update plot appearance
            update_plot(obj);
        end
        
        function reset_objects(obj)
            % Delete old objects
            delete(obj.DataLines)
            delete(obj.ThetaAxesLines)
            delete(obj.RhoAxesLines)
            delete(obj.FillPatches)
            delete(obj.AxesTextLabels)
            delete(obj.AxesTickLabels)
            
            % Reset object with empty objects
            obj.DataLines = gobjects(0);
            obj.ThetaAxesLines = gobjects(0);
            obj.RhoAxesLines = gobjects(0);
            obj.FillPatches = gobjects(0);
            obj.AxesValues = [];
            obj.AxesTextLabels = gobjects(0);
            obj.AxesTickLabels = gobjects(0);
        end
        
        function initialize(obj)
            % Selected data
            P_selected = obj.P;
            
            % Check axes scaling option
            log_index = strcmp(obj.AxesScaling, 'log');
            
            % If any log scaling is specified
            if any(log_index)
                % Initialize copy
                P_log = P_selected(:, log_index);
                
                % Logarithm of base 10, account for numbers less than 1
                P_log = sign(P_log) .* log10(abs(P_log));
                
                % Minimum and maximun log limits
                min_limit = min(min(fix(P_log)));
                max_limit = max(max(ceil(P_log)));
                recommended_axes_interval = max_limit - min_limit;
                
                % Warning message
                warning('For the log scale values, recommended axes limit is [%i, %i] with an axes interval of %i.',...
                    10^min_limit, 10^max_limit, recommended_axes_interval);
                
                % Replace original
                P_selected(:, log_index) = P_log;
            end
            
            % Axes handles
            ax = getAxes(obj);
            
            % Polar increments
            theta_increment = 2*pi/obj.NumDataPoints;
            rho_increment = 1/(obj.AxesInterval+1);
            
            %%% Scale Data %%%
            % Pre-allocation
            P_scaled = zeros(size(P_selected));
            axes_range = zeros(3, obj.NumDataPoints);
            
            % Check axes scaling option
            axes_direction_index = strcmp(obj.AxesDirection, 'reverse');
            
            % Iterate through number of data points
            for ii = 1:obj.NumDataPoints
                % Group of points
                group_points = P_selected(:, ii);
                
                % Check for log axes scaling option
                if log_index(ii)
                    % Minimum and maximun log limits
                    min_value = min(fix(group_points));
                    max_value = max(ceil(group_points));
                else
                    % Automatically the range of each group
                    min_value = min(group_points);
                    max_value = max(group_points);
                end
                
                % Range of min and max values
                range = max_value - min_value;
                
                % Check if axes_limits is not empty
                if ~isempty(obj.AxesLimits)
                    % Check for log axes scaling option
                    if log_index(ii)
                        % Logarithm of base 10, account for numbers less than 1
                        obj.AxesLimits(:, ii) = sign(obj.AxesLimits(:, ii)) .* log10(abs(obj.AxesLimits(:, ii)));
                        
                        % Manually set the range of each group
                        min_value = obj.AxesLimits(1, ii);
                        max_value = obj.AxesLimits(2, ii);
                        range = max_value - min_value;
                    else
                        % Manually set the range of each group
                        min_value = obj.AxesLimits(1, ii);
                        max_value = obj.AxesLimits(2, ii);
                        range = max_value - min_value;
                    end
                    
                    % Check if the axes limits are within range of points
                    if min_value > min(group_points) || max_value < max(group_points)
                        error('Error: Please make the manually specified axes limits are within range of the data points.');
                    end
                end
                
                % Scale points to range from [0, 1]
                P_scaled(:, ii) = ((group_points - min_value) / range);
                
                % If reverse axes direction is specified
                if axes_direction_index(ii)
                    % Store to array
                    axes_range(:, ii) = [max_value; min_value; range];
                    P_scaled(:, ii) = -(P_scaled(:, ii) - 1);
                else
                    % Store to array
                    axes_range(:, ii) = [min_value; max_value; range];
                end
                
                % Add offset of [rho_increment] and scaling factor of [1 - rho_increment]
                P_scaled(:, ii) = P_scaled(:, ii) * (1 - rho_increment) + rho_increment;
            end
            
            %%% Polar Axes %%%
            % Polar coordinates
            rho = 0:rho_increment:1;
            
            % Check specified direction of rotation
            switch obj.Direction
                case 'counterclockwise'
                    % Shift by pi/2 to set starting axis the vertical line
                    theta = (0:theta_increment:2*pi) + (pi/2);
                case 'clockwise'
                    % Shift by pi/2 to set starting axis the vertical line
                    theta = (0:-theta_increment:-2*pi) + (pi/2);
            end
            
            % Remainder after using a modulus of 2*pi
            theta = mod(theta, 2*pi);
            
            % Iterate through each theta
            for ii = 1:length(theta)-1
                % Convert polar to cartesian coordinates
                [x_axes, y_axes] = pol2cart(theta(ii), rho);
                
                % Plot
                obj.ThetaAxesLines(ii) = line(ax, x_axes, y_axes,...
                    'LineWidth', 1.5, ...
                    'Color', obj.AxesColor,...
                    'HandleVisibility', 'off');
            end
            
            % Iterate through each rho
            for ii = 2:length(rho)
                % Convert polar to cartesian coordinates
                [x_axes, y_axes] = pol2cart(theta, rho(ii));
                
                % Plot
                obj.RhoAxesLines(ii-1) = line(ax, x_axes, y_axes,...
                    'Color', obj.AxesColor,...
                    'HandleVisibility', 'off');
            end
            
            % Set end index depending on axes display argument
            switch obj.AxesDisplay
                case 'all'
                    theta_end_index = length(theta)-1;
                case 'one'
                    theta_end_index = 1;
                case 'none'
                    theta_end_index = 0;
            end
            
            %%% Plot %%%
            % Initialize data children
            for ii = 1:obj.NumDataGroups
                obj.FillPatches(ii) = patch(nan, nan, nan,...
                    'Parent', ax,...
                    'EdgeColor', 'none',...
                    'HandleVisibility', 'off');
                obj.DataLines(ii) = line(nan, nan,...
                    'Parent', ax);
            end
            
            % Iterate through number of data groups
            for ii = 1:obj.NumDataGroups
                % Convert polar to cartesian coordinates
                [x_points, y_points] = pol2cart(theta(1:end-1), P_scaled(ii, :));
                
                % Make points circular
                x_circular = [x_points, x_points(1)];
                y_circular = [y_points, y_points(1)];
                
                % Plot data points
                obj.DataLines(ii).XData = x_circular;
                obj.DataLines(ii).YData = y_circular;
                
                % Check if fill option is toggled on
                obj.FillPatches(ii).XData = x_circular;
                obj.FillPatches(ii).YData = y_circular;
            end
            
            %%% Labels %%%
            % Iterate through number of data points
            for ii = 1:obj.NumDataPoints
                % Convert polar to cartesian coordinates
                [x_axes, y_axes] = pol2cart(theta, rho(end));
                
                % Angle of point in radians
                [horz_align, vert_align, x_pos, y_pos] = obj.quadrant_position(theta(ii));
                
                % Display text label
                obj.AxesTextLabels(ii) = text(ax, x_axes(ii)+x_pos, y_axes(ii)+y_pos, '',...
                    'Units', 'Data',...
                    'HorizontalAlignment', horz_align,...
                    'VerticalAlignment', vert_align,...
                    'EdgeColor', obj.AxesLabelsEdge,...
                    'BackgroundColor', 'w',...
                    'FontSize', obj.LabelFontSize,...
                    'Visible', 'off');
            end
            
            % Iterate through each theta
            for ii = 1:theta_end_index
                % Convert polar to cartesian coordinates
                [x_axes, y_axes] = pol2cart(theta(ii), rho);
                
                % Iterate through points on isocurve
                for jj = 2:length(rho)
                    % Axes increment value
                    min_value = axes_range(1, ii);
                    range = axes_range(3, ii);
                    
                    % If reverse axes direction is specified
                    if axes_direction_index(ii)
                        % Axes increment value
                        axes_value = min_value - (range/obj.AxesInterval) * (jj-2);
                    else
                        % Axes increment value
                        axes_value = min_value + (range/obj.AxesInterval) * (jj-2);
                    end
                    
                    % Check for log axes scaling option
                    if log_index(ii)
                        % Exponent to the tenth power
                        axes_value = 10^axes_value;
                    end
                    
                    % Display axes text
                    obj.AxesValues(ii, jj-1) = axes_value;
                    obj.AxesTickLabels(ii, jj-1) = text(ax, x_axes(jj), y_axes(jj), '',...
                        'Units', 'Data',...
                        'Color', 'k',...
                        'FontSize', obj.AxesFontSize,...
                        'HorizontalAlignment', 'center',...
                        'VerticalAlignment', 'middle',...
                        'Visible', 'off');
                end
            end
        end
        
        function update_plot(obj)
            % Iterate through patch objects
            for ii = 1:numel(obj.FillPatches)
                % Check fill option argument
                if obj.FillOption
                    % Fill in patch with specified color and transparency
                    obj.FillPatches(ii).FaceColor = obj.Color(ii, :);
                    obj.FillPatches(ii).FaceAlpha = obj.FillTransparency;
                else
                    % Set no patch color
                    obj.FillPatches(ii).FaceColor = 'none';
                end
            end
            
            % Iterate through data line objects
            for ii = 1:numel(obj.DataLines)
                % Set line settings
                obj.DataLines(ii).LineStyle = obj.LineStyle{ii};
                obj.DataLines(ii).Marker =  obj.Marker{ii};
                obj.DataLines(ii).Color = obj.Color(ii, :);
                obj.DataLines(ii).LineWidth = obj.LineWidth(ii);
                obj.DataLines(ii).MarkerSize = obj.MarkerSize(ii);
                obj.DataLines(ii).MarkerFaceColor = obj.Color(ii, :);
                obj.DataLines(ii).DisplayName = obj.LegendLabels{ii};
            end
            
            % Check axes display argument
            if isequal(obj.AxesLabels, 'none')
                % Set axes text labels to invisible
                set(obj.AxesTextLabels, 'Visible', 'off')
            else
                % Set axes text labels to visible
                set(obj.AxesTextLabels, 'Visible', 'on')
                
                % Iterate through number of data points
                for ii = 1:obj.NumDataPoints
                    % Display text label
                    obj.AxesTextLabels(ii).String = obj.AxesLabels{ii};
                    obj.AxesTextLabels(ii).FontSize = obj.LabelFontSize;
                    obj.AxesTextLabels(ii).EdgeColor = obj.AxesLabelsEdge;
                end
            end
            
            % Check axes precision argument
            if isequal(obj.AxesPrecision, 'none')
                % Set axes tick label invisible
                set(obj.AxesTickLabels, 'Visible', 'off')
            else
                % Set axes tick label visible
                set(obj.AxesTickLabels, 'Visible', 'on')
                
                % Iterate through axes values rows
                for ii = 1:size(obj.AxesValues, 1)
                    % Iterate through axes values columns
                    for jj = 1:size(obj.AxesValues, 2)
                        % Display and set axes tick label settings
                        text_str = sprintf(sprintf('%%.%if', obj.AxesPrecision(ii)), obj.AxesValues(ii, jj));
                        obj.AxesTickLabels(ii, jj).String = text_str;
                        obj.AxesTickLabels(ii, jj).FontSize = obj.AxesFontSize;
                    end
                end
            end
        end
        
        function [horz_align, vert_align, x_pos, y_pos] = quadrant_position(obj, theta_point)
            % Find out which quadrant the point is in
            if theta_point == 0
                quadrant = 0;
            elseif theta_point == pi/2
                quadrant = 1.5;
            elseif theta_point == pi
                quadrant = 2.5;
            elseif theta_point == 3*pi/2
                quadrant = 3.5;
            elseif theta_point == 2*pi
                quadrant = 0;
            elseif theta_point > 0 && theta_point < pi/2
                quadrant = 1;
            elseif theta_point > pi/2 && theta_point < pi
                quadrant = 2;
            elseif theta_point > pi && theta_point < 3*pi/2
                quadrant = 3;
            elseif theta_point > 3*pi/2 && theta_point < 2*pi
                quadrant = 4;
            end
            
            % Adjust label alignment depending on quadrant
            switch quadrant
                case 0
                    horz_align = 'left';
                    vert_align = 'middle';
                    x_pos = obj.AxesLabelsOffset;
                    y_pos = 0;
                case 1
                    horz_align = 'left';
                    vert_align = 'bottom';
                    x_pos = obj.AxesLabelsOffset;
                    y_pos = obj.AxesLabelsOffset;
                case 1.5
                    horz_align = 'center';
                    vert_align = 'bottom';
                    x_pos = 0;
                    y_pos = obj.AxesLabelsOffset;
                case 2
                    horz_align = 'right';
                    vert_align = 'bottom';
                    x_pos = -obj.AxesLabelsOffset;
                    y_pos = obj.AxesLabelsOffset;
                case 2.5
                    horz_align = 'right';
                    vert_align = 'middle';
                    x_pos = -obj.AxesLabelsOffset;
                    y_pos = 0;
                case 3
                    horz_align = 'right';
                    vert_align = 'top';
                    x_pos = -obj.AxesLabelsOffset;
                    y_pos = -obj.AxesLabelsOffset;
                case 3.5
                    horz_align = 'center';
                    vert_align = 'top';
                    x_pos = 0;
                    y_pos = -obj.AxesLabelsOffset;
                case 4
                    horz_align = 'left';
                    vert_align = 'top';
                    x_pos = obj.AxesLabelsOffset;
                    y_pos = -obj.AxesLabelsOffset;
            end
        end
        
    end
    
end

%%% Custom Validation Functions %%%
% Validate axes labels
function validateAxesLabels(axes_labels, P)
if ~isequal(axes_labels, 'none')
    validateattributes(axes_labels, {'cell'}, {'size', [1, size(P, 2)]}, mfilename, 'axes_labels')
end
end

% Validate legend labels
function validateLegendLabels(legend_labels, P)
if ~isequal(legend_labels, 'none')
    validateattributes(legend_labels, {'cell'}, {'size', [1, size(P, 1)]}, mfilename, 'legend_labels')
end
end

% Validate axes limits
function validateAxesLimits(axes_limits, P)
if ~isempty(axes_limits)
    validateattributes(axes_limits, {'double'}, {'size', [2, size(P, 2)]}, mfilename, 'axes_limits')
    
    % Lower and upper limits
    lower_limits = axes_limits(1, :);
    upper_limits = axes_limits(2, :);
    
    % Difference in upper and lower limits
    diff_limits = upper_limits - lower_limits;
    
    % Check to make sure upper limit is greater than lower limit
    if any(diff_limits < 0)
        error('Error: Please make sure max axes limits are greater than the min axes limits.');
    end
    
    % Check the range of axes limits
    if any(diff_limits == 0)
        error('Error: Please make sure the min and max axes limits are different.');
    end
end
end