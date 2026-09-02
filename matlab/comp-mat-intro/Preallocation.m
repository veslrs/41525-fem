% MatLab can increase the array or matrix size on the fly.
% For large arrays/matrices it is faster to preallocate.


% Increase array on the fly
tic % starts timer
x = 0;
for k = 2:100000000
   x(k) = x(k-1) + 5;
end
toc % stops timer and displays elapsed time


% Preallocate
tic
x = zeros(1, 100000000);
for k = 2:10000000
   x(k) = x(k-1) + 5;
end
toc


