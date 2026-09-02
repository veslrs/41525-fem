% Image is a matrix with 3 rows and 4 columns
% The value of C(i,j) defines the colour of the pixel in position (i,j)
% Counting of both i and j starts in upper left corner
 
figure;
C = [0 2 4 6; 8 10 12 14; 16 18 20 22];
imagesc(C);
colorbar;

% Limits may be set on the colour scale to take out extreme values
figure;
C = [0 2 -4 6; 8 10 12 14; 16 18 200 22];
imagesc(C);
%imagesc(C,[0 25]); % see how this changes the appearance
colorbar;

% Change the colormap to get another colorscale
% Search documentation for 'colormap' in documentation to see options
figure;
C = [0 2 -4 6; 8 10 12 14; 16 18 200 22];
colormap('jet');
imagesc(C,[0 25]);
colorbar;

axis off; % remove axis from plot