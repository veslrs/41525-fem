% READING AND WRITING DATA FROM AND TO TEXT FILES

% read a file of unknown length with x and y coordinates
inputname = 'xy_points.txt';
infile=fopen(inputname,'r'); % 'r' means the file is open for reading

n=0; % number of valid data lines read is 0
line = fgetl(infile); %read first line

% Number of lines is unknown - so continue reading while the newly read
% line contains characters. When no more lines in file, the line will not
% contain a character and while loop stops
while ischar(line)
   % read variables (2 floating point numbers) from the line into array
   % Check for number of that there are 2 variables
   [data, count]=sscanf(line,'%f');
   if count==2
      n=n+1; % update number of data points
      x(n)=data(1);
      y(n)=data(2);
   else
      disp('Error in input file - continues to read');
   end
   line=fgetl(infile); % read next line before next time through loop
end

% multiply data by 10 and write to output file
x=x*10;
y=y*10;

outputname=input('Name of output file: ','s')
outfile=fopen(outputname,'w'); % create and open file for writing
% If file exists and you want to add new
% data to the end use 'a' (append) instead
% of 'w'

for i=1:n   % use for loop as the number of data points is known (n)
   fprintf(outfile,'%8.2f %8.2f\n',x(i),y(i));
end
fclose(outfile); % close the file to be sure everything is written 
