%%% Enforce boundary conditions
%%% zeyfa, 09 Sept 2026
function [K_bc, P_bc]=enforce(K, P, bound)
    K_bc = K;
    P_bc = P;
    idx_dofs = ((bound(:, 1) - 1) * 2 + bound(:, 2)).';
    us = bound(:, 3);
    % non-zero BCs
    P_bc = P_bc - K_bc(:, idx_dofs) * us;
    % BCs - zeros
    K_bc(idx_dofs, :) = 0;
    K_bc(:, idx_dofs) = 0;
    % BCs - diagonal 1s and loads
    linear_diag_idx = sub2ind(size(K_bc), idx_dofs, idx_dofs);
    K_bc(linear_diag_idx) = 1;
    P_bc(idx_dofs) = us;
end