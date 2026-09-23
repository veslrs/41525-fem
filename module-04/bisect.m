function [rhos, lambda] = bisect(rhos_old, rho_min, V, df, dg, ne, eta)
    lambda_1 = 1e-10;
    lambda_2 = 1e10;
    tol = 1e-5;
    rhos = rhos_old * 0;
    while (lambda_2 - lambda_1) / (lambda_1 + lambda_2) > tol
        lambda_mid = (lambda_1 + lambda_2) / 2;

        for e = 1:ne
            Be = (-df(e) / (lambda_mid * dg(e)))^eta;
            if rhos_old(e) * Be^eta <= rho_min
                rhos(e, 1) = rho_min;
            elseif rhos_old(e) * Be^eta >= 1
                rhos(e, 1) = 1;
            else
                rhos(e, 1) = rhos_old(e) * Be^eta;
            end
        end

        g = rhos.' * dg - V;
        if g > 0
            lambda_1 = lambda_mid;
        else
            lambda_2 = lambda_mid;
        end
    end

    lambda = lambda_mid;
end 