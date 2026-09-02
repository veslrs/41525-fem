x=0:2:100; 

y1=105-x.^2/200;
y2=x/2+25;


plot2Dfig=figure;
plot(x,y1,'-','color','red','LineWidth',2,'Marker','o','MarkerSize',2); 
hold on;  % hold on to keep what you just plotted
 
% SCALE AXES
%axis([ 0 100 0 120]);
% ADD LABELS
% title('2D plot','FontSize',14);
% xlabel('x-values','FontSize',14);
% ylabel('y-values','FontSize',14);
% legend('y1');


% PLOT 2 FIGURES IN THE SAME WINDOW
% twofig=figure; 
% xy1fig=subplot(1,2,1);
% plot(x,y1,'-','color','red','LineWidth',2,'Marker','o','MarkerSize',2); 
% title('y1 plot','FontSize',14);
% xlabel('x','FontSize',14);
% ylabel('y1','FontSize',14);
% 
% xy2fig=subplot(1,2,2);
% plot(x,y2,'-','color','blue','LineWidth',4); 
% title('y2 plot','FontSize',14);
% xlabel('x','FontSize',14);
% ylabel('y2','FontSize',14);

% ADD TO THE FIGURE IN THE FIRST WINDOW
% figure(plot2Dfig); % make that figure the currently used again
% y3=x;
% plot(x,y3,'-','color','green','LineWidth',2,'LineStyle',':');

