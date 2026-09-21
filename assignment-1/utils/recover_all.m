%%% This subroutine recovers the element stress, element strain, 
%%% and nodal reaction forces
%%% zeyfa, 09 Sept 2026
function [strain,stress,N,R] = recover_all(problem, mprop,IX,D,nelem,neqn,Bs,Ls,P)
    strain=zeros(nelem,1);                     % Element strain vector 
    stress=zeros(nelem,1);                     % Element stress vector
    N=zeros(nelem,1);                          % Element force vector
    R=zeros(neqn,1);                           % Residual vector
    for e=1:nelem
        idx_prop = IX(e, 3);
        idx_dofs = [IX(e, 1) * 2 - 1, IX(e, 1) * 2, IX(e, 2) * 2 - 1, IX(e, 2) * 2];
        % element strain
        eps = Bs(:, e).' * D(idx_dofs);
        strain(e) = eps;
        % element stress
        if strcmpi(problem, "linear")
            sig = mprop(idx_prop, 1) * eps;
            stress(e) = sig;
        elseif strcmpi(problem, "nonlinear")
            sig = signorini_strains_to_stresses(eps, e, IX, mprop);
            stress(e) = sig;
        else
            error("Please pass the correct argument for problem type: linear | nonlinear.");
        end
        % element forces
        force = sig * mprop(idx_prop, 2);
        N(e) = force;
        % reaction forces
        R(idx_dofs) = R(idx_dofs) + Bs(:, e) * N(e) * Ls(e);
    end
    R = R - P;
end