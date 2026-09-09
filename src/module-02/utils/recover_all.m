%%% This subroutine recovers the element stress, element strain, 
%%% and nodal reaction forces
%%% zeyfa, 09 Sept 2026
function [strain,stress,N,R] = recover_all(mprop,IX,D,nelem,Bs,N,R,Ls,P,strain,stress)
    for e=1:nelem
        idx_prop = IX(e, 3);
        idx_dofs = [IX(e, 1) * 2 - 1, IX(e, 1) * 2, IX(e, 2) * 2 - 1, IX(e, 2) * 2];
        % element strain
        eps = Bs(:, e).' * D(idx_dofs);
        strain(e) = eps;
        % element stress
        sig = mprop(idx_prop, 1) * eps;
        stress(e) = sig;
        % element forces
        force = sig * mprop(idx_prop, 2);
        N(e) = force;
        % reaction forces
        R(idx_dofs) = R(idx_dofs) + Bs(:, e) * N(e) * Ls(e);
    end
    R = R - P;
end