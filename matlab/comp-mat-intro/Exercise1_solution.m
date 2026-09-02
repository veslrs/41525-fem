A=zeros(10,10);
for i=1:10
   for j=1:10
      A(i,j)=(i-2)*(j-3)+0.5;
   end
end


% TRANSLATE THE ELEMENTS IN A SO THAT EACH ELEMENT IN A ROW IS SHIFTED TO
% THE NEXT COLUMN TO THE RIGHT. THE LAST ELEMENT IN A ROW BECOMES THE FIRST
% ELEMENT IN THE SAME ROW.
Aold=A;
tmp=A(:,10);
for i=10:-1:2
   A(:,i)=A(:,i-1);
end
A(:,1)=tmp;    
disp('Translated A:');
A

% or in another way:
A=Aold;
tmp=A(:,10);
A(:,2:10)=A(:,1:9);
A(:,1)=tmp;
A

% or in another way:
A=Aold;
A=circshift(A,1,1);
A


% % FIND THE MAXIMUM AND MINIMUM VALUES IN A USING THE BUILT-IN MAX AND MIN
% FUNCTIONS % CONSULT MATLAB DOCUMENTATION
 maxvalue=max(max(A));
 minvalue=min(min(A));
 fprintf('max: %4.1f min: %4.1f\n\n',maxvalue,minvalue);


% % TRANSFORM THE ELEMENTS OF A TO INTEGER VALUES % CONSULT MATLAB
% DOCUMENTATION ON FLOOR, CEIL AND ROUND
A=floor(A); % ceil and round could also be used as problem is formulated
disp('Integer form of A:');
A 

% FIND ELEMENTS OF A THAT ARE LARGER THAN 0 % CONSULT MATLAB
% DOCUMENTATION: Find Array Elements That Meet a Condition
disp('Elements of A larger than 0:');
A(A>0)
 
% % FIND ALSO THE INDICES OF THESE ELEMENTS
disp('Indices of elements of A larger than 0:');
I=find(A>0)

% DISPLAY THE POSITION OF THESE ELEMENTS GRAPHICALLY to make a binary map
% of what is >0 and <=0
fig1=figure;
B=A>0;
imagesc(B);

% Another way to make a binary map of what is >0 and <=0
fig2=figure;
B=zeros(10,10);
for i=1:size(I) % indices are stored columnwise
% CONSULT MATLAB DOCUMENTATION: Matrix indicing
   x=mod(I(i),10);
   if x==0
      x=10;
   end
   y=ceil(I(i)/10);
   if y==0
      y=1;
   end
  
   B(x,y)=1;
end
imagesc(B);

% FIND THE POSITION OF THE ELEMENTS THAT ARE NOT THE SAME IN A AND C % CONSULT MATLAB
% DOCUMENTATION: Find Array Elements That Meet a Condition
C=A;
for i=1:10
   C(i,i)=20;
end
disp('Matrix with 1 where A and C differ');
D=A~=C

