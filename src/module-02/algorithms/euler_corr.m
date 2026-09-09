%%% Euler with one-step correction
%%% zeyfa, 09 Sept 2026
function [Ds, Ls] = euler_corr(problem, nelem, neqn, nincr, P, loads, bound, X, IX, mprop, K, Ls, Bs, D)
Ds = zeros(neqn, nincr);
P = build_load(P,loads);
p = zeros(neqn, 1);
dp = P / nincr;
for i = 1:nincr
    p = p + dp;
    % calculate k_t
    [K, Bs, Ls] = build_global_stiffness(problem, X, IX, nelem, mprop, K, Ls, Bs, D);
    % enforce BCs on K and dP
    [K, dp] = enforce(K, P, bound);
    % displacement increments
    dD = K \ dp;
    D = D + dD;
    Ds(:, i) = D;
end
end