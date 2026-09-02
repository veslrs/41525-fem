%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Basis truss program                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function fea()

close all
clc

%--- Input file ----------------------------------------------------------%
% example1                % Input file
% test1                   % Input file
exercise_1                % Input file

neqn = size(X,1)*size(X,2);         % Number of equations
ne = size(IX,1);                    % Number of elements

fprintf(1, "[INFO] Number of elements: %d\n", ne);
fprintf(1, "[INFO] Number of DOFs: %d\n", neqn);

%--- Initialize arrays ---------------------------------------------------%
Kmatr=sparse(neqn,neqn);                % Stiffness matrix
P=zeros(neqn,1);                        % Force vector
D=zeros(neqn,1);                        % Displacement vector
N=zeros(ne,1);                          % Element force vector
R=zeros(neqn,1);                        % Residual vector
strain=zeros(ne,1);                     % Element strain vector 
stress=zeros(ne,1);                     % Element stress vector
Ls = zeros(ne, 1);                      % Element initial lengths vector
Bs = zeros(4, ne);                      % Collected strain displacement vectors

%--- Calculate displacements ---------------------------------------------%
[P]=buildload(X,IX,ne,P,loads,mprop);       % Build global load vector

[Kmatr,Bs,Ls]=buildstiff(X,IX,ne,mprop,Kmatr,Ls,Bs);    % Build global stiffness matrix

[Kmatr,P]=enforce(Kmatr,P,bound);           % Enforce boundary conditions

D = Kmatr \ P;                              % Solve system of equations

[strain,stress,N,R]=recover(mprop,X,IX,D,ne,Bs,N,R,Ls,P,strain,stress); % Calculate element 
                                                                        % stress and strain
                                                        
%--- Plot results --------------------------------------------------------%                                                        
PlotStructure(X,IX,ne,neqn,bound,loads,D,stress)        % Plot structure

return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Build global load vector %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [P]=buildload(X,IX,ne,P,loads,mprop)

for i=1:size(loads,1)
    idx = (loads(i, 1) - 1) * 2 + loads(i, 2);
    P(idx) = loads(i, 3);
end

return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Build global stiffness matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [K,Bs,Ls]=buildstiff(X,IX,ne,mprop,K,Ls,Bs)

% This subroutine builds the global stiffness matrix from
% the local element stiffness matrices
        
for e=1:ne
    idx_prop = IX(e, 3);
    idx_node_1 = IX(e, 1);
    idx_node_2 = IX(e, 2);
    % material properties
    emod = mprop(idx_prop, 1);
    area = mprop(idx_prop, 2);
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
    % element stiffness matrix
    k_elem = emod * area * l_original * (B_0 * B_0.');
    % index of dofs (for assembly)
    idx_dofs = [IX(e, 1) * 2 - 1, IX(e, 1) * 2, IX(e, 2) * 2 - 1, IX(e, 2) * 2];
    % assemble global stiffness matrix
    K(idx_dofs(1):idx_dofs(2), idx_dofs(1):idx_dofs(2)) = K(idx_dofs(1):idx_dofs(2), idx_dofs(1):idx_dofs(2)) + k_elem(1:2, 1:2);
    K(idx_dofs(1):idx_dofs(2), idx_dofs(3):idx_dofs(4)) = K(idx_dofs(1):idx_dofs(2), idx_dofs(3):idx_dofs(4)) + k_elem(1:2, 3:4);
    K(idx_dofs(3):idx_dofs(4), idx_dofs(1):idx_dofs(2)) = K(idx_dofs(3):idx_dofs(4), idx_dofs(1):idx_dofs(2)) + k_elem(3:4, 1:2);
    K(idx_dofs(3):idx_dofs(4), idx_dofs(3):idx_dofs(4)) = K(idx_dofs(3):idx_dofs(4), idx_dofs(3):idx_dofs(4)) + k_elem(3:4, 3:4);
end
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Enforce boundary conditions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This subroutine enforces the support boundary conditions

function [K,P]=enforce(K,P,bound)
    idx_dofs = ((bound(:, 1) - 1) * 2 + bound(:, 2)).';
    K(idx_dofs, :) = 0;
    K(:, idx_dofs) = 0;
    for i = idx_dofs
        K(i, i) = 1;
    end
    P(idx_dofs) = bound(:, 3);
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Calculate element strain and stress %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [strain,stress,N,R]=recover(mprop,X,IX,D,ne,Bs,N,R,Ls,P,strain,stress)

% This subroutine recovers the element stress, element strain, 
% and nodal reaction forces
        
    for e=1:ne
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
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Plot structure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function PlotStructure(X,IX,ne,neqn,bound,loads,D,stress)

% This subroutine plots the undeformed and deformed structure

h1=0;h2=0;
% Plotting Un-Deformed and Deformed Structure
clf
hold on
box on
for e = 1:ne
    xx = X(IX(e,1:2),1);
    yy = X(IX(e,1:2),2);
    h1=plot(xx,yy,'k:','LineWidth',1.);
    edof = [2*IX(e,1)-1 2*IX(e,1) 2*IX(e,2)-1 2*IX(e,2)];
    xx = xx + D(edof(1:2:4));
    yy = yy + D(edof(2:2:4));
    sig = stress(e);
    if sig > 0
        h2 = plot(xx,yy,'b','LineWidth',3.5);
    elseif sig < 0
        h2 = plot(xx,yy,'r','LineWidth',3.5);
    else
        h2 = plot(xx,yy,'g','LineWidth',3.5);
    end
end
plotsupports
plotloads

legend([h1 h2],{'Undeformed state',...
                'Deformed state'})

axis equal;
hold off

return
