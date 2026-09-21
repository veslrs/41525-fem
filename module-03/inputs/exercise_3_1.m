%%% input file, exercise 3.1, week 3
%%% zeyfa, 20 Sept, 2026

% Problem definition
nonlinearity = true;
material_nonlinearity = false;
geometrical_nonlinearity = true;
algorithm = "nr-modified";          % euler | euler-corr | nr | nr-modified
factorization = "lu";         % lu | cholesky

% Number of increments
nincr = 20;

% Coordinates of 3 nodes,
X = [  0.00   0.00 
       1.50  -0.40 
       3.00   0.00 ];

% Topology matrix IX(node1,node2,propno),
IX = [ 1  2  1 
       2  3  1 ];
      
% Element property matrix mprop = [ E A ],
mprop = [ 1  2 ];

% Prescribed loads mat(node,dof,force)
loads = [ 2   1   0.03 ];

% Boundary conditions mat(node,dof,disp)   
bound = [ 1  1  0.0
          1  2  0.0
          3  1  0.0
          3  2  0.0 ];

% Control Parameters
plotdof = 6;
