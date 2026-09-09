%%% Euler
%%% zeyfa, 09 Sept 2026
function [Ds, Ls] = euler(problem, nelem, neqn, nincr, P, loads, bound, X, IX, mprop, K, Ls, Bs, D)
    Ds = zeros(neqn, nincr);
    P = build_load(P,loads);
    p = zeros(neqn, 1);
    dp_inc = P / nincr;
    for i = 1:nincr
        p = p + dp_inc;
        % calculate k_t
        [K, Bs, Ls] = build_global_stiffness(problem, X, IX, nelem, mprop, K, Ls, Bs, D);
        % enforce BCs on K and dP
        dp = dp_inc;
        [K, dp] = enforce(K, dp, bound);
        % displacement increments
        dD = K \ dp;
        D = D + dD;
        Ds(:, i) = D;
    end
end