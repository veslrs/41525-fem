% Create figure and axes explicitly
fig = figure;
ax = axes(fig);

% Plot with explicit handle assignment
x = linspace(0, 2*pi, 100);
y = sin(x);
line1 = plot(ax, x, y, 'b-', 'LineWidth', 2);

% Modify properties explicitly
line1.Color = 'red';
line1.LineStyle = '--';
ax.Title.String = 'My Plot';
ax.XLabel.String = 'Time';
ax.YLabel.String = 'Amplitude';
