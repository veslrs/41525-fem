%%% Signorini stress-strain relation
%%% zeyfa, 09 Sept 2026
%%% mprop: [E, A, c1, c2, c3, c4]
function emod = signorini_strain_to_emod(idx_elem, IX, mprop, strain)
    idx = IX(idx_elem, 3);
    c1 = mprop(idx, 3);
    c2 = mprop(idx, 4);
    c3 = mprop(idx, 5);
    c4 = mprop(idx, 6);
    lambda = 1 + c4 * strain;
    emod = c4 * ( ...
        c1 * (1 + 2 * lambda^-3) ...
        + 3 * c2 * lambda^-4 ...
        + 3 * c3 * (-1 + lambda^2 - 2 * lambda^-3 + 2 * lambda^-4) ...
    );
end