function stresses = signorini_strains_to_stresses(strains, idx_elem, IX, mprop)
    idx = IX(idx_elem, 3);
    c1 = mprop(idx, 3);
    c2 = mprop(idx, 4);
    c3 = mprop(idx, 5);
    c4 = mprop(idx, 6);
    lambda = 1 + c4 * strains;
    stresses = c1 * (lambda - lambda.^-2) ...
        + c2 * (1 - lambda.^-3) ...
        + c3 * (1 - 3 * lambda + lambda.^3 - 2 * lambda.^-3 + 3 * lambda.^-2);
end