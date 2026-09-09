%%% Enforce boundary conditions
%%% zeyfa, 09 Sept 2026
function [K, P]=enforce(K, P, bound)
    idx_dofs = ((bound(:, 1) - 1) * 2 + bound(:, 2)).';
    us = bound(:, 3);
    P = P - K(:, idx_dofs) * us;
    K(idx_dofs, :) = 0;
    K(:, idx_dofs) = 0;
    idx = 0;
    for i = idx_dofs
        idx = idx + 1;
        K(i, i) = 1;
        P(i) = us(idx);
    end
end