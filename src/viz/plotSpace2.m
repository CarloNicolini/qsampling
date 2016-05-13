function h=plotSpace2(vProj,vModul,figtitle)
x=vProj(:,1);
y=vProj(:,2);
z=vModul;
nbSquare=50;
lenx=0;
leny=0;
xlimits=[min(x)-lenx,max(x)+lenx];
ylimits=[min(y)-leny,max(y)+leny];
[xi,yi]=meshgrid(linspace(xlimits(1),xlimits(2),nbSquare),linspace(ylimits(1),ylimits(2),nbSquare));
h=figure();

regular = axes('Parent',h);

zlabel('Quality Value','FontSize',12,'FontName','Helvetica');
xlabel('CC1','FontSize',12,'FontName','Helvetica');
ylabel('CC2','FontSize',12,'FontName','Helvetica');
view([23.5 20]);
grid('on');
hold('all');
zi=griddata(x,y,z,xi,yi);
surf(xi,yi,zi,'Parent',regular); %can use mesh, meshc, surf, surfc surfl
plot3(x,y,z,'ro','MarkerSize',1);
%plot3(x,y,ones(size(x))*min(z(:)),'r.');
title(figtitle,'Interpreter','none'); % to avoid interpretation
hold off;
