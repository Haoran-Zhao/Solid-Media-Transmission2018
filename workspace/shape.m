clear all
close all
%workspace1
range=25;
separation=25;
phi=atan2(range,separation);
theta=linspace(0,2*pi,40);
phi=linspace(0,phi,40);
[theta,phi]=meshgrid(theta,phi);
rho1=65;
rho2=165;

x1=(rho1-sqrt(range^2+separation^2))*sin(phi).*cos(theta);
y1=(rho1-sqrt(range^2+separation^2))*sin(phi).*sin(theta);
z1=-rho1*cos(phi);
x2=(rho2-sqrt(range^2+separation^2))*sin(phi).*cos(theta);
y2=(rho2-sqrt(range^2+separation^2))*sin(phi).*sin(theta);
z2=-rho2*cos(phi);

t= -(rho2-sqrt(range^2+separation^2))*sin(atan2(range,separation)):-(rho1-sqrt(range^2+separation^2))*sin(atan2(range,separation));
[X,Y,Z]=cylinder(-t);

figure(1)
surf(x1,y1,z1)
hold on
surf(x2,y2,z2)
surf(X,Y,100*cos(atan2(range,separation))*Z-(rho2-sqrt(range^2+separation^2))*cos(atan2(range,separation))-separation)
view(3)
shading interp
axis equal

%workspace2
range1=50;
separation1=100;
phi=atan2(range1,separation1);
theta=linspace(0,2*pi,40);
phi=linspace(0,phi,40);
[theta,phi]=meshgrid(theta,phi);
rho3=130;
rho4=230;

x3=(rho3-sqrt(range1^2+separation1^2)/2)*sin(phi).*cos(theta);
y3=(rho3-sqrt(range1^2+separation1^2)/2)*sin(phi).*sin(theta);
z3=-rho3*cos(phi);
x4=(rho4-sqrt(range1^2+separation1^2)/2)*sin(phi).*cos(theta);
y4=(rho4-sqrt(range1^2+separation1^2)/2)*sin(phi).*sin(theta);
z4=-rho4*cos(phi);

t= -(rho4-sqrt(range1^2+separation1^2)/2)*sin(atan2(range1,separation1)):-(rho3-sqrt(range1^2+separation1^2)/2)*sin(atan2(range1,separation1));
[X,Y,Z]=cylinder(-t);

figure(2)
surf(x3,y3,z3)
hold on
surf(x4,y4,z4)
surf(X,Y,100*cos(atan2(range1,separation1))*Z-(rho4-sqrt(range1^2+separation1^2)/2)*cos(atan2(range1,separation1))-separation1/2)
view(3)
shading interp
axis equal


