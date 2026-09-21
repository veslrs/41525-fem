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
    if strcmpi(problem, "nonlinear")
        fprintf(1, "[INFO] Number of iterations: %d\n", nincr);
    end
    
    %%% Solve
    if strcmpi(problem, "linear")
        % solve
        [P, D, Ls, Bs] = linear(loads, X, IX, nelem, neqn, mprop, bound);
        % Post-processing
        [~ ,stress, ~, ~]=recover_all(problem, mprop,IX,D,nelem,neqn,Bs,Ls,P);
        plot_structure(X,IX,nelem,neqn,bound,loads,D,stress);
    elseif strcmpi(problem, "nonlinear")
        if strcmpi(algorithm, "euler")
            % displacements
            Ds = euler(problem, nelem, neqn, nincr, loads, bound, X, IX, mprop);
            % post-processing
            plot_force_disp(Ds, IX, mprop, nincr, loads);
        elseif strcmpi(algorithm, "euler-corr")
            % displacements
            Ds = euler_corr(problem, nelem, neqn, nincr, loads, bound, X, IX, mprop);
            % post-processing
            plot_force_disp(Ds, IX, mprop, nincr, loads);
        elseif strcmpi(algorithm, "nr")
            % displacements
            Ds = nr(problem, nelem, neqn, nincr, iter_max, loads, bound, X, IX, mprop, 1e-8);
            % post-processing
            plot_force_disp(Ds, IX, mprop, nincr, loads);
        elseif strcmpi(algorithm, "nr-modified")
            % displacements
            Ds = nr_modified(problem, factorization, nelem, neqn, nincr, iter_max, loads, bound, X, IX, mprop, 1e-8);
            % post-processing
            plot_force_disp(Ds, IX, mprop, nincr, loads);
        else
            error("Please pass the correct argument for algorithm: euler | euler-corr | nr | nr-modified.")
        end
    else
        error("Please pass the correct argument for problem type: linear | nonlinear.");
    end
end