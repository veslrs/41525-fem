function [ax, lines] = plot_signals(t, signals, names)
% Idiomatic function-based approach
% Returns handles for further modification

fig = figure('Name', 'Signal Plot');
ax = axes(fig);

lines = gobjects(length(signals), 1);  % Pre-allocate line handles

hold(ax, 'on');
for i = 1:length(signals)
    lines(i) = plot(ax, t, signals{i}, 'DisplayName', names{i});
end
hold(ax, 'off');

legend(ax, 'show');
xlabel(ax, 'Time (s)');
ylabel(ax, 'Amplitude');
end

% Usage
t = linspace(0, 1, 100);
signals = {sin(2*pi*5*t), cos(2*pi*3*t)};
names = {'5 Hz', '3 Hz'};
[ax, lines] = plot_signals(t, signals, names);

% Modify the returned handles
lines(1).LineWidth = 3;
