function [B0,L0,A,E] = elem_get_info(e, IX, X, mprop)
    propno = IX(e,3);
    A = mprop(propno,2);
    E = mprop(propno,1);
    
    idx_p1 = IX(e,1);
    idx_p2 = IX(e,2);
    
    p1 = X(idx_p1,:);
    p2 = X(idx_p2,:);
    L0 = norm(p2 - p1);
    
    dx = p2(1) - p1(1);
    dy = p2(2) - p1(2);
    B0 = (1/(L0)^2) * [-dx ; -dy;  dx;  dy];
end