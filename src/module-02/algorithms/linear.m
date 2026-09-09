function [P, D, Ls, Bs] = linear(P, loads, X, IX, nelem, mprop, K, Ls, Bs, bound)
    P = build_load(P,loads);       % Build global load vector
    [K, Bs, Ls] = build_global_stiffness("linear", X, IX, nelem, mprop, K, Ls, Bs);    % Build global stiffness matrix
    [K, P]=enforce(K, P, bound);           % Enforce boundary conditions
    D = K \ P;                              % Solve system of equations
end