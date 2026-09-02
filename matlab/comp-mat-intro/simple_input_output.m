% PROMPT FOR A VARIALBE ENTERED BY THE KEYBOARD
x=input('Number to be multiplied with 10? ');
Y=x*10;

% THREE WAYS TO DISPLAY THE VALUE OF A VARIABLE IN THE COMMAND WINDOW
Y  % the result of evaluating expressions not ending by ; is displayed
disp(Y); % disp displays the value of the variable without stating the ..
         % variable name
fprintf('%0.2f times 10 is equal to %0.1f\n\n',x,Y); % more complex output
% %0.2f specifies a floating point number with 2 decimals. 
% Read more about specifying our output type and format in ...
% documentation for fprintf. \n starts a new line.

% read string
str=input('Which day is it? ','s');
fprintf('Today is %s\n',str);
