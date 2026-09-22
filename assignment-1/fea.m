%%% Truss program
%%% original author: olsi
%%% modified by zeyfa, 09 Sept 2026
%%% =======================================================================
%%% zeyfa, 16 Sept 2026: added new control flow handling both mat and geom
%%% non-linearity.
%%%
%%% zeyfa, 20 Sept 2026: modified control flow handling both mat and geom
%%% non-linearity.
%%% 
%%% zeyfa, 22 Sept 2026: modified control flow; updated function calls.
%%% =======================================================================
function fea(input_path)
    close all;
    
    %%% Inputs
    run(input_path)
    
    neqn = size(X,1)*size(X,2);         % Number of equations
    nelem = size(IX,1);                 % Number of elements
    
    fprintf(1, "[INFO] Number of elements: %d\n", nelem);
    fprintf(1, "[INFO] Number of DOFs: %d\n", neqn);
    if nonlinearity
        fprintf(1, "[INFO] Number of iterations: %d\n", nincr);
    end
    
    %%% Solve
    if nonlinearity ~= true
        % solve
        [P, D, Ls, Bs] = linear(loads, X, IX, nelem, neqn, mprop, bound);
        % Post-processing
        [~ ,stress, ~, ~]=recover_all(nonlinearity, mprop,IX,D,nelem,neqn,Bs,Ls,P);
        plot_structure(X,IX,nelem,neqn,bound,loads,D,stress);
    elseif strcmpi(algorithm, "euler")
        % displacements
        Ds = euler(nonlinearity, nelem, neqn, nincr, loads, bound, X, IX, mprop);
        % post-processing
        % plot_force_disp(Ds, IX, mprop, nincr, loads);
        writematrix(Ds, "disps_euler.csv");
    elseif strcmpi(algorithm, "euler-corr")
        % displacements
        Ds = euler_corr(nonlinearity, nelem, neqn, nincr, loads, bound, X, IX, mprop);
        % post-processing
        % plot_force_disp(Ds, IX, mprop, nincr, loads);
        writematrix(Ds, "disps_euler_corr.csv");
    elseif strcmpi(algorithm, "nr")
        % displacements
        Ds = nr(nonlinearity, nelem, neqn, nincr, iter_max, loads, bound, X, IX, mprop, eSTOP);
        % post-processing
        % plot_force_disp(Ds, IX, mprop, nincr, loads);
        writematrix(Ds, "disps_nr.csv");
    elseif strcmpi(algorithm, "nr-modified")
        % displacements
        Ds = nr_modified(nonlinearity, factorization, nelem, neqn, nincr, iter_max, loads, bound, X, IX, mprop, eSTOP);
        % post-processing
        % plot_force_disp(Ds, IX, mprop, nincr, loads);
        writematrix(Ds, "disps_nr_modified.csv");
    else
        error("Please pass the correct argument for algorithm: euler | euler-corr | nr | nr-modified.")
    end
end