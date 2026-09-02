% MATLAB STORES MATRICES COLUMNWISE
% THE FOUR EXAMPLES BELOW DO THE SAME THING. EXPLAIN THE DIFFERENCES IN RUN
% TIME

% TRY WITH N=10000 and N=25000

N=10000;
%N=25000;

disp('Built in operator');
tic
x= ones(N,N);
y= zeros(N,N);
y= x*10;
toc


disp('By row operator');
tic
x= ones(N,N);
y= zeros(N,N);
for i=1:N
   y= x(:,i)*10;
end
toc

disp('By column operator');
tic
x= ones(N,N);
y= zeros(N,N);
for i=1:N
   y= x(i,:)*10;
end
toc

disp('Element by element one column at a time')
tic
x= ones(N,N);
y= zeros(N,N);
for j=1:N
   for i=1:N
      y= x(i,j)*10;
   end
end
toc

disp('Element by element one row at a time');
tic
x= ones(N,N);
y= zeros(N,N);
for i=1:N
   for j=1:N
      y= x(i,j)*10;
   end
end
toc