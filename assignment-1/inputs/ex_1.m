% Input file for exercise 1.1, assignment 1
% Created with:       FlExtract v1.13
% Element type:       truss
% Number of nodes:    16
% Number of elements: 32
% modified by zeyfa, 21 Sept 2026

clear all;

% Problem definition
nonlinearity = false;
material_nonlinearity = false;
geometrical_nonlinearity = false;

% Node coordinates: x, y
X = [
0	0
0	250
0	500
0	750
0	1000
250	0
250	250
250	500
250	750
250	1000
500	750
500	1000
750	750
750	1000
1000	750
1000	1000
];
% Element connectivity: node1_id, node2_id, material_id
IX = [
2	1	1
6	1	1
3	2	1
8	2	1
7	2	1
6	2	1
4	3	1
8	3	1
5	4	1
10	4	1
9	4	1
8	4	1
10	5	1
9	5	1
7	6	1
8	7	1
9	8	1
10	9	1
11	9	1
12	10	1
11	10	1
12	11	1
14	11	1
13	11	1
14	12	1
13	12	1
14	13	1
16	13	1
15	13	1
16	14	1
15	14	1
16	15	1
];
% Element properties: Young's modulus, area
mprop = [
70000	200
];
% Nodal displacements: node_id, degree of freedom (1 - x, 2 - y), displacement
bound = [
1	1	0
1	2	0
6	2	0
% 11  1   -10     % prescribed displacement in x-direction at node B (ex 1.6)
% 11  2   10      % prescribed displacement in y-direction at node B (ex 1.6)
];
% Nodal loads: node_id, degree of freedom (1 - x, 2 - y), load
loads = [
15	2	-10000
];
% Control parameters
plotdof = 32;
