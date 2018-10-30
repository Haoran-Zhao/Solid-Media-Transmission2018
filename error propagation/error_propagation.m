clear all
close all

phi = -atan2(2.5,45):0.01:atan2(2.5,45);
beta = 0:0.01:pi/2;
[phi,beta]=meshgrid(phi,beta);
dx =0.05;
dy=0.05;
dl = 0.1;
f= sqrt((dx-cos(phi).*cos(beta).*dl).^2+(dy-cos(phi).*sin(beta).*dl).^2+(sin(phi).*dl).^2);

figure(1)
surf(phi,beta,f,'EdgeColor','none')
view(3)
title('Isometric view');
xlabel('\beta');
ylabel('\phi');
zlabel('\sigmapt (mm) ');
figure(2)
surf(phi,beta,f,'EdgeColor','none')
view([1 0 0]); % y-z plane
title('Side view, Y-Z');
ylabel('\beta');
zlabel('\sigmapt (mm)');

figure(3)
dl1=0:0.1:1;
f2= sqrt((dx-cos(pi/4).*dl1).^2+(dy-sin(pi/4).*dl1).^2);
plot(dl1,f2)
xlabel('\sigmal');
ylabel('\sigmapt (mm)');



