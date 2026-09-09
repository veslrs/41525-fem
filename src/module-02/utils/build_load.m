%%% Build global load vector
%%% zeyfa, 09 Sept 2026
function [P] = build_load(P, loads)
    for i = 1:size(loads, 1)
        idx = (loads(i, 1) - 1) * 2 + loads(i, 2);
        P(idx) = loads(i, 3);
    end
end