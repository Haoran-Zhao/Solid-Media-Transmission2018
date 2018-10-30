clear all
close all
% Inserting D-H convention parameters
a1 = 0; alpha1 = -pi/2; d1 =0; %revolute
a2 = 0; alpha2 =0; t2 = 0; %prismatic


%Mk3 and needle length dimensions 
nd_l=16.50;

% Inserting joint limits for Arms
t1_min=-pi/2; t1_max = pi/2;
d2_min = -2; d2_max = 2;
nd_min = 6.5; nd_max= 16.5;
 
% Monte Carlo method
% sampling size
N = 1000000;
t1 = t1_min + (t1_max-t1_min)*rand(N,1);
d2 = d2_min + (d2_max-d2_min)*rand(N,1);
nd = nd_min + (nd_max-nd_min)*rand(N,1);

t1_1 = t1_min + (t1_max-t1_min)*rand(N,1);
d2_1 = d2_min + (d2_max-d2_min)*rand(N,1);


wk = zeros(N,3); % work space 

for i = 1:N
A1 = TransMat(a1,alpha1,d1,t1(i));
A2 = TransMat(a2,alpha2,d2(i),t2);
T = A1*A2;
X=T(1,4);
Y=T(2,4);
Z=0;
A3 = TransMat(a1,alpha1,d1,t1_1(i));
A4 = TransMat(a2,alpha2,d2_1(i),t2);
T1 = A3*A4;
X1=T1(1,4);
Y1=T1(2,4);
Z1=-100;
[wk(i,1),wk(i,2),wk(i,3)]=point(X,Y,Z,X1,Y1,Z1,nd(i));
end

range1=4;
separation1=4.5;
phi=atan2(range1,separation1);
theta=linspace(0,2*pi,40);
phi=linspace(0,phi,40);
[theta,phi]=meshgrid(theta,phi);
rho3=6.5;
rho4=16.5;

x3=(rho3-sqrt(range1^2+separation1^2)/2)*sin(phi).*cos(theta);
y3=(rho3-sqrt(range1^2+separation1^2)/2)*sin(phi).*sin(theta);
z3=-rho3*cos(phi);
x4=(rho4-sqrt(range1^2+separation1^2)/2)*sin(phi).*cos(theta);
y4=(rho4-sqrt(range1^2+separation1^2)/2)*sin(phi).*sin(theta);
z4=-rho4*cos(phi);

t= -(rho4-sqrt(range1^2+separation1^2)/2)*sin(atan2(range1,separation1)):-(rho3-sqrt(range1^2+separation1^2)/2)*sin(atan2(range1,separation1));
[X,Y,Z]=cylinder(-t);


figure(1)
scatter3(wk(:,1),wk(:,2),wk(:,3),5,wk(:,3),'.');
hold on
surf(x3,y3,z3)
surf(x4,y4,z4)
surf(X,Y,100*cos(atan2(range1,separation1))*Z-(rho4-sqrt(range1^2+separation1^2)/2)*cos(atan2(range1,separation1))-separation1/2)
view(3);
shading interp
title('Isometric view');
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('z (mm) ');

figure(2)
scatter3(wk(:,1),wk(:,2),wk(:,3),5,wk(:,3),'.');
hold on
surf(x3,y3,z3)
surf(x4,y4,z4)
surf(X,Y,100*cos(atan2(range1,separation1))*Z-(rho4-sqrt(range1^2+separation1^2)/2)*cos(atan2(range1,separation1))-separation1/2)
view(2); % top view
shading interp
title(' Top view');
xlabel('x (mm)');
ylabel('y (mm)');

figure(3)
scatter3(wk(:,1),wk(:,2),wk(:,3),5,wk(:,3),'.');
hold on
surf(x3,y3,z3)
surf(x4,y4,z4)
surf(X,Y,100*cos(atan2(range1,separation1))*Z-(rho4-sqrt(range1^2+separation1^2)/2)*cos(atan2(range1,separation1))-separation1/2)
view([1 0 0]); % y-z plane
shading interp
title('Side view, Y-Z');
ylabel('y (mm)');
zlabel('z (mm)');

% figure(4)
% k=boundary(wk(:,1),wk(:,2),wk(:,3));
% hold on 
% trisurf(k,wk(:,1),wk(:,2),wk(:,3));
% view(3);
% title('Isometric view');
% xlabel('x (mm)');
% ylabel('y (mm)');
% zlabel('z (mm) ');

% 

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