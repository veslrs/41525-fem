%%% Euler
%%% zeyfa, 09 Sept 2026
function [Ds] = euler(problem, nelem, neqn, nincr, loads, bound, X, IX, mprop)
    % Displacement vector
    D=zeros(neqn,1);
    % Collection of displacement vectors
    Ds = zeros(neqn, nincr);                
    P = build_load(neqn, loads);
    p = zeros(neqn, 1);
    dp_incr = P / nincr;
    for i = 1:nincr
        p = p + dp_incr;
        % calculate k_t
        [K, ~, ~] = build_global_stiffness(problem, X, IX, nelem, neqn, mprop, D);
        % enforce BCs on K and dP
        dp = dp_incr;
        [K, dp] = enforce(K, dp, bound);
        % displacement increments
        dD = K \ dp;
        D = D + dD;
        Ds(:, i) = D;
    end
end