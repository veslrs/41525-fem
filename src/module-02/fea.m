%%% Truss program
%%% zeyfa, 09 Sept 2026
function fea(input_path)
    close all;
    
    %%% Inputs
    run(input_path)
    
    neqn = size(X,1)*size(X,2);         % Number of equations
    nelem = size(IX,1);                 % Number of elements
    
    fprintf(1, "[INFO] Number of elements: %d\n", nelem);
    fprintf(1, "[INFO] Number of DOFs: %d\n", neqn);
    fprintf(1, "[INFO] Number of iterations: %d\n", nincr);
    
    %%% Initialisation
    [K, D, P, N, R, strain, stress, Ls, Bs] = init(nelem, neqn);
    
    %%% Solve displacements
    if strcmpi(problem, "linear")
        [P, D, Ls, Bs] = linear(P, loads, X, IX, nelem, mprop, K, Ls, Bs, bound);
    elseif strcmpi(problem, "nonlinear")
        if strcmpi(algorithm, "euler")
            [Ds, Ls] = euler(problem, nelem, neqn, nincr, P, loads, bound, X, IX, mprop, K, Ls, Bs, D);
            D = Ds(:, end);
        elseif strcmpi(algorithm, "euler-corr")
            
        else
            error("Please pass the correct argument for algorithm: euler | euler-corr | mr | mr-modified.")
        end
    else
        error("Please pass the correct argument for problem type: linear | nonlinear.");
    end

    c1 = mprop(1, 3);
    c2 = mprop(1, 4);
    c3 = mprop(1, 5);
    c4 = mprop(1, 6);

    area = mprop(1, 2);

    x = [0, Ds(5, :)];
    x2 = linspace(0, 0.2/3, nincr + 1);
    y1 = signorini_stress_strain(x2 , c1, c2, c3, c4) * area;
    y2 = linspace(0, loads(1, 3), nincr + 1);

    figure;
    plot(x2 * 3, y1, 'b-', 'LineWidth', 2); 
    hold on;
    plot(x, y2, 'ro', 'LineWidth', 2); 
    hold off;

    legend('Analytical', 'Numerical');
    xlabel('Displacement');
    ylabel('Force');
    title('2-bar simulation');
    
    %%% Post-processing
    % [strain,stress,N,R]=recover_all(mprop,IX,D,nelem,Bs,N,R,Ls,P,strain,stress); % Calculate element 
    %                                                                              stress and strain                                                      
    % plot_structure(X,IX,nelem,neqn,bound,loads,D,stress)        % Plot structure
    
end