%%% Newton-Raphson
%%% zeyfa, 10 Sept 2026
function [Ds] = nr(problem, nelem, neqn, nincr, iter_max, loads, bound, X, IX, mprop)
    eps = 1e-8;
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
        for j = 0:iter_max
            [K, Bs, Ls] = build_global_stiffness(problem, X, IX, nelem, neqn, mprop, D_iter);
            [~,~,~,R_iter] = recover_all(problem, mprop,IX,D_iter,nelem,neqn,Bs,Ls,p);
            [K, R_iter] = enforce(K, R_iter, bound);
            if norm(R_iter) <= eps * norm(P)
                break;
            end
            dD = -(K \ R_iter);
            D_iter = D_iter + dD;
        end
        D = D_iter;
        Ds(:, i) = D;
    end
end