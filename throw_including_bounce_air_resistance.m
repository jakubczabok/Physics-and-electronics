% This MATLAB script simulates trajectory of thrown ball on wall with bounce taking into account air resistance 

clear all; close all; clc;

% gravity constant
global g;
g=9.81;

% coefficient of air resitance for ball
global k;
k=0.5;

% importing user's data
global m;
m=input('enter mass [kg]: ');
v0=input('enter initial velocity [m/s]: ');
alpha=input('enter throw angle [degrees]: ');
x0=input('enter initial position on X axis [m]: ');
y0=input('enter initial position on Y axis [m]: ');

% switching degrees to radians
alpha=pi*(alpha/180);

% decomposition of initial velocity for velocities in X and Y axes
vx0=v0*cos(alpha);
vy0=v0*sin(alpha);

% vector of positions and velocities in X and Y axes
wpp = [y0;vy0;x0;vx0];

% maximal time of simulation
tmax = 15;

% function generating vector of derivatives
function dy = f (t , y)
global m;
global g;
global k;
% position on axis Y = y(1)
% velocity in axis Y = y(2)
% position on axis X = y(3)
% velocity in axis X = y(4)
dy(1)=y(2);
dy(2)=-g-k/m*(y(2)*y(2)+y(4)*y(4))^(1/2)*y(2);
dy(3)=y(4);
dy(4)=-k/m*(y(2)*y(2)+y(4)*y(4))^(1/2)*y(4);
end

% function defining moment of fall
function [value,isterminal,direction] = Stop(t, y)
value = y(1);
isterminal = 1;
direction = -1;
end

% time
ts=linspace(0,tmax,tmax*1000);

% solution of differential equation (without bounce)
opcje = odeset('Events', @Stop);
[t,y]=ode45('f',ts,wpp,opcje);

% finding moment of bounce
maxY=max(y(:,1));
bounceindex=[~, index] = max(y(:,1));

% creating matrix with positions and velocities on in axes (until bounce)
y2=y(1:bounceindex, :);

% situation in the moment of bounce
wpp2 = [y(bounceindex,1);y(bounceindex,2);y(bounceindex,3);-y(bounceindex,4)];

% soultion of differential equation (after bounce)
opcje = odeset('Events', @Stop);
[t,y3]=ode45('f',ts,wpp2,opcje);

% whole matrix with positions and velocities
y2=vertcat(y2,y3);

% drawing trajectiory and calculating max height, distance and time of fall
f1=figure(1)
hold on
ylabel("axis Y[m]");
xlabel("axis X[m]");
maxY=max(y2(:,1));
maxX=y2(end,3);
txt=[sprintf("max height=%dm",maxY);sprintf("distance=%dm",maxX);sprintf("time of fall=%ds",t(end))];
annotation('textbox', [0.725, 0.90, 0.1, 0],'String',txt);
y2(end,1)=0;
plot(y2(:,3),y2(:,1));
hold off;
