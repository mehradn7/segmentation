function [C,theta_0,a,b] = conversion(p)

alpha = p(1);
beta = p(2);
gamma = p(3);
delta = p(4);
epsilon = p(5);
phi = p(6);

C = -inv([2*alpha beta ; beta 2*gamma])*[delta ; epsilon];
x_C = C(1);
y_C = C(2);
g = phi+alpha*x_C*x_C+beta*x_C*y_C+gamma*y_C*y_C+delta*x_C+epsilon*y_C;
theta_0 = 1/2*atan(beta/(alpha-gamma));
cos_theta_0 = cos(theta_0);
sin_theta_0 = sin(theta_0);

a = sqrt(-g/(alpha*cos_theta_0*cos_theta_0+beta*sin_theta_0*cos_theta_0+gamma*sin_theta_0*sin_theta_0));
b = sqrt(-g/(alpha*sin_theta_0*sin_theta_0-beta*sin_theta_0*cos_theta_0+gamma*cos_theta_0*cos_theta_0));

if b>a
	theta_0 = theta_0+pi/2;
	aux = a;
	a = b;
	b = aux;
end