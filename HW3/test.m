clear all;
close all;
clc;

f = @(x) (x(1) - 4)^4 + (x(2) - 3)^2 + 4*(x(3) + 5)^4;
f1 = @(x) [4*(x(1) - 4)^3; 2*(x(2) - 3); 16*(x(3) +5)^3];
x0 = [1; 6 ; -1];

%x = gradient_descent(f, f1, x0, 1e-6);

% Rosenbrock Function
f = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
grad = @(x) [ -400*x(1) * (x(2) - x(1)^2) - 2*(1 - x(1))  ;  200*(x(2) - x(1))^2];
hessian = @(x) [-400 * (x(2) - 3 * x(1)^2) + 2  , -400 * x(1) ; -400 * x(1)  , 200];

x0 = [0;0];
x = newtons(f, grad, hessian, x0, 1e-6);