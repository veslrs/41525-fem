%%% Euler with one-step correction
%%% zeyfa, 10 Sept 2026
function [Ds] = euler_corr(problem, nelem, neqn, nincr, loads, bound, X, IX, mprop)
    % Displacement vector
    D=zeros(neqn,1);
    % Collection of displacement vectors
    Ds = zeros(neqn, nincr);                
    P = build_load(neqn, loads);
    p = zeros(neqn, 1);
    dp_incr = P / nincr;
    R = zeros(neqn, 1);
    for i = 1:nincr
        dp = dp_incr;
        p = p + dp;
        % calculate k_t
        [K, Bs, Ls] = build_global_stiffness(problem, X, IX, nelem, neqn, mprop, D);
        % enforce BCs on K and (dP - R)
        rhs = dp - R;
        [K, rhs] = enforce(K, rhs, bound);
        % displacement increments
        dD = K \ rhs;
        D = D + dD;
        Ds(:, i) = D;
        % one-step correction
        [~,~,~,R] = recover_all(problem, mprop,IX,D,nelem,neqn,Bs,Ls,p);
    end
end