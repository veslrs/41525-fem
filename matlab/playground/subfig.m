% Create figure with tiled layout (idiomatic for subplots)
fig = figure;
tiledlayout(2, 2, 'TileSpacing', 'compact');

% Tile 1
ax1 = nexttile;
x = linspace(0, 2*pi, 100);
plot(ax1, x, sin(x), 'b-');
ax1.Title.String = 'sin(x)';

% Tile 2
ax2 = nexttile;
plot(ax2, x, cos(x), 'r-');
ax2.Title.String = 'cos(x)';

% Tile 3
ax3 = nexttile;
plot(ax3, x, tan(x), 'g-');
ax3.Title.String = 'tan(x)';
ax3.YLim = [-5 5];

% Tile 4
ax4 = nexttile;
scatter(ax4, randn(100, 1), randn(100, 1));
ax4.Title.String = 'Random Data';
