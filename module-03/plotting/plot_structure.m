%%% Plot structure
%%% zeyfa, 09 Sept 2026
function plot_structure(X,IX,nelem,neqn,bound,loads,D,stress)
    h1=0;h2=0;
    % Plotting Un-Deformed and Deformed Structure
    clf
    hold on
    box on
    for e = 1:nelem
        xx = X(IX(e,1:2),1);
        yy = X(IX(e,1:2),2);
        h1=plot(xx,yy,'k:','LineWidth',1.);
        edof = [2*IX(e,1)-1 2*IX(e,1) 2*IX(e,2)-1 2*IX(e,2)];
        xx = xx + D(edof(1:2:4));
        yy = yy + D(edof(2:2:4));
        sig = stress(e);
        if sig > 0
            h2 = plot(xx,yy,'b','LineWidth',3.5);
        elseif sig < 0
            h2 = plot(xx,yy,'r','LineWidth',3.5);
        else
            h2 = plot(xx,yy,'g','LineWidth',3.5);
        end
    end
    plotsupports
    plotloads
    
    legend([h1 h2],{'Undeformed state',...
        'Deformed state'})
    
    axis equal;
    hold off
    
end