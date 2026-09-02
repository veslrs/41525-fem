% Create a function with idiomatic name-value pair syntax
function ax = fancy_plot(x, y, options)
arguments
    x double
    y double
    options.Color = 'b'
    options.LineWidth = 2
    options.Title = ''
    options.XLabel = ''
    options.YLabel = ''
end

ax = axes;
plot(ax, x, y, 'Color', options.Color, 'LineWidth', options.LineWidth);

if ~isempty(options.Title)
    ax.Title.String = options.Title;
end
if ~isempty(options.XLabel)
    ax.XLabel.String = options.XLabel;
end
if ~isempty(options.YLabel)
    ax.YLabel.String = options.YLabel;
end
end

% Idiomatic usage with named arguments
x = linspace(0, 2*pi, 100);
ax = fancy_plot(x, sin(x), ...
    'Color', 'red', ...
    'LineWidth', 3, ...
    'Title', 'Sine Wave', ...
    'XLabel', 'Radians');
