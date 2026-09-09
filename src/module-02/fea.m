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
    [K, P, N, R, strain, stress, Ls, Bs] = init(nelem, neqn);
    
    %%% Solve displacements
    if strcmpi(problem, "linear")
        [P, D, Ls, Bs] = linear(P, loads, X, IX, nelem, mprop, K, Ls, Bs, bound);
    elseif strcmpi(problem, "nonlinear")
        if strcmpi(algorithm, "euler")
            
        else
            error("Please pass the correct argument for algorithm: euler | euler-corr | mr | mr-modified.")
        end
    
    else
        error("Please pass the correct argument for problem type: linear | nonlinear.");
    end
    
    %%% Post-processing
    [strain,stress,N,R]=recover_all(mprop,IX,D,nelem,Bs,N,R,Ls,P,strain,stress); % Calculate element 
                                                                                 % stress and strain                                                      
    plot_structure(X,IX,nelem,neqn,bound,loads,D,stress)        % Plot structure
    
end