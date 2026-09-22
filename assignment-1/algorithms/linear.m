function [P, D, Ls, Bs] = linear(loads, X, IX, nelem, neqn, mprop, bound)
    % global load vec
    P = build_load(neqn,loads);
    % global stiffness mat
    [K, Bs, Ls] = build_global_stiffness(false, X, IX, nelem, neqn, mprop);
    % BCs
    [K, P]=enforce(K, P, bound);
    D = K \ P;
end