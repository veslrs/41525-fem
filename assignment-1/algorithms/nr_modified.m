%%% Newton-Raphson
%%% zeyfa, 10 Sept 2026
%%% =======================================================================
%%% revision history
%%% zeyfa, 16 Sept 2026: added geometrical non-linearity; modified control
%%% flow to handle both mat and geom non-linearity.
%%% =======================================================================
function [Ds] = nr_modified(problem, factorization, nelem, neqn, nincr, iter_max, loads, bound, X, IX, mprop, tol)
    % Displacement vector
    D=zeros(neqn,1);
    % Collection of displacement vectors
    Ds = zeros(neqn, nincr);                
    P = build_load(neqn, loads);
    p = zeros(neqn, 1);
    dp_incr = P / nincr;
    for i = 1:nincr
        p = p + dp_incr;
        D_iter = D;
        [K, Bs, Ls] = build_global_stiffness(problem, X, IX, nelem, neqn, mprop, D_iter);
        % enforce BCs for K (pass dummy parameter p)
        [K, ~] = enforce(K, p, bound);
        if strcmpi(factorization, "lu")
            [L, U] = lu(K);
        elseif strcmpi(factorization, "cholesky")
            C = chol(K);
        else
            error("Please pass the correct argument for factorization algorithm: lu | cholesky.")
        end
        for j = 0:iter_max
            [~,~,~,R_iter] = recover_all(problem, mprop,IX,D_iter,nelem,neqn,Bs,Ls,p);
            % enforce BCs for R (pass dummy parameter K)
            [~, R_iter] = enforce(K, R_iter, bound);
            if norm(R_iter) <= tol * norm(P)
                break;
            end
            if strcmpi(factorization, "lu")
                dD = -(U \ (L \ R_iter));
            elseif strcmpi(factorization, "cholesky")
                dD = -(C \ (C \ R_iter));
            else
                error("Please pass the correct argument for factorization algorithm: lu | cholesky.")
            end
            D_iter = D_iter + dD;
        end
        D = D_iter;
        Ds(:, i) = D;
    end
end