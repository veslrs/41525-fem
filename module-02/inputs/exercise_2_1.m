%%% input file, exercise 2.1, week 2
%%% zeyfa, 09 Sept, 2026

% Problem definition
problem = "nonlinear";              % linear | nonlinear
algorithm = "euler";          % euler | euler-corr | nr | nr-modified
factorization = "lu";         % lu | cholesky

% Number of increments
nincr = 20;

% Coordinates of 3 nodes,
X = [  0.00  0.00 
       1.50  0.00 
       3.00  0.00 ];

% Topology matrix IX(node1,node2,propno),
IX = [ 1  2  1 
       2  3  1 ];
      
% Element property matrix mprop = [ E A c1 c2 c3 c4 ],
mprop = [ 1  2  1  50  0.1  100 ];

% Prescribed loads mat(node,dof,force)
loads = [ 3   1   200 ];

% Boundary conditions mat(node,dof,disp)   
bound = [ 1  1  0.0
          1  2  0.0
          2  2  0.0
          3  2  0.0 ];

% Control Parameters
plotdof = 6;
