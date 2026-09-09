% File group10.m, submitted on 7 Sept 2026
% Sido, Khalil Hamid (s233625) & Fang, Zeyuan (zeyfa)
%
% No. of nodes: 8
% No. of elements : 14
% Total length of bar elements: 9.67 [-]
% Load: P = -0.01 [-]
% Vertical displacement on loaded node: -0.13 [-]

% Coordinates of 6 nodes,
X = [ 0.0, 1.0;
      0.5, 2/3;
      1.5, 2/3; 
      1.5, 1/3;
      0.5, 1/3;
      0.5, 0.0;
      1.0, 0.0; 
      2.0, 0.0;
    ];

% Topology matrix IX(node1,node2,propno),
IX = [ 1, 2, 1;
       2, 3, 1;
       1, 5, 1; 
       1, 6, 1;
       2, 5, 1;
       3, 4, 1;
       3, 8, 1;
       5, 6, 1;
       4, 5, 1;
       5, 7, 1;
       4, 7, 1;
       4, 8, 1;
       6, 7, 1;
       7, 8, 1;];
      
% Element property matrix mprop = [ E A ],
mprop = [ 1.0 1.0 ];

% Prescribed loads mat(node,ldof,force)
loads = [ 1   2 -0.01 ];

% Boundary conditions mat(node,ldof,disp)   
bound = [ 7, 1, 0.0;
          7, 2, 0.0;
          8, 2, 0.0];

% Control Parameters
plotdof = 16;

