function [K, D, P, N, R, strain, stress, Ls, Bs] = init(nelem, neqn)
    K=sparse(neqn,neqn);                % Stiffness matrix
    D=zeros(neqn,1);                        % Displacement vector
    P=zeros(neqn,1);                        % Force vector
    N=zeros(nelem,1);                          % Element force vector
    R=zeros(neqn,1);                        % Residual vector
    strain=zeros(nelem,1);                     % Element strain vector 
    stress=zeros(nelem,1);                     % Element stress vector
    Ls = zeros(nelem, 1);                      % Element initial lengths vector
    Bs = zeros(4, nelem);                      % Collected strain displacement vectors
end