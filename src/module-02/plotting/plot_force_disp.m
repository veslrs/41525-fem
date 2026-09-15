%%% Plot force-displacement curve
%%% zeyfa, 10 Sept 2026
function plot_force_disp(Ds, IX, mprop, nincr, loads)
    area = mprop(1, 2);
    
    disp_numerical = [0, Ds(5, :)];
    disp_analytical = linspace(0, disp_numerical(end), nincr + 1);
    force_analytical = signorini_strains_to_stresses(disp_analytical / 3, 1, IX, mprop) * area;
    force_numerical = linspace(0, loads(1, 3), nincr + 1);
    
    figure;
    plot(disp_analytical, force_analytical, 'b-', 'LineWidth', 2); 
    hold on;
    plot(disp_numerical, force_numerical, 'ro', 'LineWidth', 2); 
    hold off;
    
    legend('Analytical', 'Numerical');
    xlabel('Displacement');
    ylabel('Force');
    title('2-bar simulation');
end