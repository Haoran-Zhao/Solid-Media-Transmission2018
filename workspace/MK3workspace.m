clear all
close all
% Inserting D-H convention parameters
a1 = 0; alpha1 = -pi/2; d1 =0; %revolute
a2 = 0; alpha2 =0; t2 = 0; %prismatic


%Mk3 and needle length dimensions 
nd_l=16.5;
x1=0; y1=0; z1=0;
x2=0; y2=0; z2=-4.5;

% Inserting joint limits for Arms
t1_min=-pi/2; t1_max = pi/2; %rotate angle range +- pi/2
d2_min = -2.0; d2_max = 2.0; %transition range +- 20mm
nd_min = 6.5; nd_max= 16.5; %needle insert depth 100mm
 
% Monte Carlo method
% sampling size
N = 100000;
t1 = t1_min + (t1_max-t1_min)*rand(N,1);
d2 = d2_min + (d2_max-d2_min)*rand(N,1);
nd = nd_min + (nd_max-nd_min)*rand(N,1);

wk = zeros(N,3); % work space 
wk_mk3 = zeros(N,3);
for i = 1:N
A1 = TransMat(a1,alpha1,d1,t1(i));
A2 = TransMat(a2,alpha2,d2(i),t2);
T = A1*A2;
X=T(1,4);
Y=T(2,4);
Z=0;
[wk(i,1),wk(i,2),wk(i,3)]=point(X,Y,Z,x2,y2,z2,nd(i));
end

%workspace
range=2.0;
separation=4.5;
phi=atan2(range,separation);
theta=linspace(0,2*pi,40);
phi=linspace(0,phi,40);
[theta,phi]=meshgrid(theta,phi);
rho1=6.5;
rho2=16.5;

x1=(rho1-sqrt(range^2+separation^2))*sin(phi).*cos(theta);
y1=(rho1-sqrt(range^2+separation^2))*sin(phi).*sin(theta);
z1=-rho1*cos(phi);
x2=(rho2-sqrt(range^2+separation^2))*sin(phi).*cos(theta);
y2=(rho2-sqrt(range^2+separation^2))*sin(phi).*sin(theta);
z2=-rho2*cos(phi);
t= -(rho2-sqrt(range^2+separation^2))*sin(atan2(range,separation)):-(rho1-sqrt(range^2+separation^2))*sin(atan2(range,separation));
[X,Y,Z]=cylinder(-t);


figure(1)
scatter3(wk(:,1),wk(:,2),wk(:,3),5,wk(:,3),'.');
% hold on 
% surf(x1,y1,z1)
% surf(x2,y2,z2)
% surf(X,Y,100*cos(atan2(range,separation))*Z-(rho2-sqrt(range^2+separation^2))*cos(atan2(range,separation))-45)
view(3);
shading interp
title('Isometric view');
xlabel('x (cm)');
ylabel('y (cm)');
zlabel('z (cm) ');
colorbar

figure(2)
scatter3(wk(:,1),wk(:,2),wk(:,3),5,wk(:,3),'.');
% hold on 
% surf(x1,y1,z1)
% surf(x2,y2,z2)
% surf(X,Y,100*cos(atan2(range,separation))*Z-(rho2-sqrt(range^2+separation^2))*cos(atan2(range,separation))-45)
view(2); % top view
shading interp
title(' Top view');
xlabel('x (cm)');
ylabel('y (cm)');
colorbar


figure(3)
scatter3(wk(:,1),wk(:,2),wk(:,3),5,wk(:,3),'.');
% hold on 
% surf(x1,y1,z1)
% surf(x2,y2,z2)
% surf(X,Y,100*cos(atan2(range,separation))*Z-(rho2-sqrt(range^2+separation^2))*cos(atan2(range,separation))-45)
view([1 0 0]); % y-z plane
shading interp
title('Side view, Y-Z');
ylabel('y (cm)');
zlabel('z (cm)');
colorbar


% 
% for i = 1:N
% A1 = TransMat(a1,alpha1,d1,t1(i));
% A2 = TransMat(a2,alpha2,d2(i),t2);
% T = A1*A2;
% wk_mk3(i,1)=T(1,4);
% wk_mk3(i,2)=T(2,4);
% wk_mk3(i,3)=0;
% end
% figure(4)
% scatter3(wk_mk3(:,1),wk_mk3(:,2),wk_mk3(:,3),5,wk_mk3(:,3),'.');
% view(3); 
% title('Isometric view');
% ylabel('y (mm)');
% zlabel('z (mm)');


function [ T ] = TransMat( a,b,c,d )
T = [ cos(d) -sin(d)*cos(b) sin(d)*sin(b) a*cos(d); sin(d) cos(d)*cos(b) -cos(d)*sin(b) a*sin(d); 0 sin(b) cos(b) c; 0 0 0 1];
end

function [x3,y3,z3]=point(x1,y1,z1,x2,y2,z2,l)
alpha= atan2(z1-z2,sqrt((x1-x2)^2+(y1-y2)^2));
beta= atan2(y1-y2,x1-x2);
% l1=sqrt((x1-x2)^2+(y1-y2)^2+(z1-z2)^2);
% l2=l-l1;
z3=z1-l*sin(alpha);
x3=x1-l*cos(beta)*cos(alpha);
y3=y1-l*sin(beta)*cos(alpha);
end