%%% Build global load vector
%%% zeyfa, 09 Sept 2026
function [D] = euler(problem, ne, nincr, P,  X, IX, mprop, K, Ls, Bs, D)
    P = build_load(P,loads);
    p = zeros(ne, 1);
    dp = P / nincr;
    for i = 1:nincr
        p = p + dp;
        % calculate k_t
        [K, Bs, Ls] = build_global_stiffness(problem, X, IX, ne, mprop, K, Ls, Bs);
        % enforce BCs on K and dP
        [K, dp] = enforce(K, P, bound);
        % displacement increments
        dD = K \ dp;
        D = D + dD;
    end
end