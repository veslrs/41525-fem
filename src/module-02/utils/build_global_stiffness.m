%%% Build global stiffness matrix
%%% zeyfa, 09 Sept 2026
function [K,Bs,Ls] = build_global_stiffness(problem, X, IX, nelem, mprop, K, Ls, Bs)
    for e=1:nelem
        idx_prop = IX(e, 3);
        idx_node_1 = IX(e, 1);
        idx_node_2 = IX(e, 2);
        % element geometry
        p1 = X(idx_node_1, :);
        p2 = X(idx_node_2, :);
        l_original = norm(p2 - p1);
        Ls(e) = l_original;
        dx = p2(1) - p1(1);
        dy = p2(2) - p1(2);
        %%% assembly
        % strain displacement vector
        B_0 = 1 / l_original^2 * [-dx; -dy; dx; dy];
        Bs(:, e) = B_0;
        % material properties
        % cross-section
        area = mprop(idx_prop, 2);
        % e-modulus
        if strcmpi(problem, "linear")
            emod = mprop(idx_prop, 1);
        elseif strcmpi(problem, "nonlinear")
            epsilon = Bs(:, e).' * D(idx_dofs);
            emod = signorini(mprop, epsilon);
        else
            error("Please pass the correct argument for problem type: linear | nonlinear.");
        end
        % element stiffness matrix
        k_elem = emod * area * l_original * (B_0 * B_0.');
        % index of dofs (for assembly)
        idx_dofs = [IX(e, 1) * 2 - 1, IX(e, 1) * 2, IX(e, 2) * 2 - 1, IX(e, 2) * 2];
        % assemble global stiffness matrix
        K(idx_dofs, idx_dofs) = K(idx_dofs, idx_dofs) + k_elem;
    end
end