function plotting_ex_2()
    clear all; close all;
    Ds_euler = readmatrix("disps_euler.csv");
    Ds_euler_corr = readmatrix("disps_euler_corr.csv");
    Ds_nr = readmatrix("disps_nr.csv");
    Ds_nr_modified = readmatrix("disps_nr_modified.csv");
    loads = linspace(0, 100, 18);
    f = figure();
    
    % Set figure window display size (300pt x 100pt)
    set(f, 'Units', 'points');
    set(f, 'Position', [100, 100, 900, 300]);
    
    % Set print/export dimensions (300pt x 100pt, 3:1 aspect ratio)
    set(f, 'PaperUnits', 'points');
    set(f, 'PaperSize', [900, 300]);
    set(f, 'PaperPosition', [0, 0, 900, 300]);
    
    % overlaying plots: (x = Ds_euler, y = loads)
    % overlaying plot: (x = Ds_euler_corr, y = loads)
    % overlaying plot: (x = Ds_nr, y = loads)
    % overlaying plot: (x = Ds_nr_modified, y = loads)
    hold on
    plot(Ds_euler(48, :), loads, 'DisplayName', 'Euler', LineStyle=':', Color="k", LineWidth=2);
    plot(Ds_euler_corr(48, :), loads, 'DisplayName', 'Euler (corrected)', LineStyle='--', Color="k", LineWidth=2);
    plot(Ds_nr(48, :), loads, 'DisplayName', 'Newton-Raphson', LineStyle='-', Color="k", LineWidth=2);
    plot(Ds_nr_modified(48, :), loads, 'DisplayName', 'Modified Newton-Raphson', LineStyle='none', Marker='o', Color="k", MarkerSize=8, LineWidth=1.5);
    hold off
    
    % Get axes handle
    ax = gca;
    
    % TICK FONT SIZE and DIRECTION
    set(ax, 'FontSize', 12);              % x/y-tick font size
    set(ax, 'TickDir', 'out');            % ticks point outward
    
    % AXES THICKNESS
    set(ax, 'LineWidth', 1.5);            % axes box line width
    
    xlabel('Displacement [-]', FontSize=16, Interpreter='latex');
    ylabel('Load [-]', FontSize=16, Interpreter='latex');
    
    % LEGEND FONT SIZE AND POSITION
    lgd = legend('Location', 'southeast');
    set(lgd, 'FontSize', 12);
    
    % export as PDF
    exportgraphics(f, 'plotting_ex_2.pdf');
end