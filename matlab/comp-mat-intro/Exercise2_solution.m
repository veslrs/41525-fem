

A = [ 1 1 1; 1 0 -1; -1 2 -1];
B = [1 1 0; 1 -1 1; 1 -1 -2];

% NORMALISE THE ROWS IN A AND B SO THAT EACH ROW IS A UNIT VECTOR
A=[A(1,:)/norm(A(1,:)); A(2,:)/norm(A(2,:)); A(3,:)/norm(A(3,:))]
B=[B(1,:)/norm(B(1,:)); B(2,:)/norm(B(2,:)); B(3,:)/norm(B(3,:))]

% BUILD AN ARRAY OF 3X3 MATRICES WITH A AND B AS THE FIRST TWO ELEMENTS
% CONSULT MATLAB DOCUMENTATION: Multidimensional arrays
C=zeros(3,3,2);
C(:,:,1)=A;
C(:,:,2)=B;
C

