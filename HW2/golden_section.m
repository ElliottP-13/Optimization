clc;
%% Define the function we are optimizing 1.1
f = @(x) x.^2 + 4 * cos(x); % lambda function syntax
f1= @(x) 2 * x - 4 * sin(x);
f2= @(x) 2 - 4 * cos(x);
a = 1;
b = 2;

eps = 0.02;  % epsilon

%% Plot the function
x = a:0.01:b;
plot(x, f(x));

%% Run Golden Section 1.1
o = golden_sec(f, 1, 2, 0.02);
fprintf("Golden Section\n")
for row=1:size(o,1)
    fprintf("k = %i,\t ak = %0.12f,\t bk = %0.12f,\t f(ak) = %0.12f,\t f(bk) = %0.12f\t [%0.6f, %0.6f]\n",o(row, :))
end
% This outputs at the very bottom for some strange reason
%% Run Newton 1.1
o = newtons(f, f1, f2, 1, 10);
fprintf("Newtons:\n")
for row=1:size(o,1)
    fprintf("k = %i,\t xk = %0.12f,\t f(xk) = %0.12f,\t f'(xk) = %0.12f,\t f''(xk) = %0.12f\n",o(row, :))
end

%% Run Custom 1.1
o = custom(f, 1, 1.5, 2, 10);
fprintf("Custom:\n")
for row=1:size(o,1)
    fprintf("k = %i,\t xk = %0.12f,\t f(xk) = % 0.12f\n",o(row, :))
end


%% Define the function we are optimizing 1.2
f = @(x) 8 * exp(1 - x) + 7 * log(x); % lambda function syntax
f1= @(x) -8 * exp(1-x) + 7 * 1/x;
f2= @(x) 8 * exp(1-x) - 7/ x.^2;
a = 1;
b = 2;

eps = 0.02;  % epsilon

%% Plot the function
x = a:0.01:b;
plot(x, f(x));

%% Run Golden Section 1.2
o = golden_sec(f, 1, 2, 0.02);
fprintf("Golden Section\n")
for row=1:size(o,1)
    fprintf("k = %i,\t ak = %0.12f,\t bk = %0.12f,\t f(ak) = %0.12f,\t f(bk) = %0.12f\t [%0.6f, %0.6f]\n",o(row, :))
end

%% Run Newton 1.2
o = newtons(f, f1, f2, 1, 10);
fprintf("Newtons:\n")
for row=1:size(o,1)
    fprintf("k = %i,\t xk = %0.12f,\t f(xk) = %0.12f,\t f'(xk) = %0.12f,\t f''(xk) = %0.12f\n",o(row, :))
end

%% Run Custom 1.2
o = custom(f, 1, 1.5, 2, 10);
fprintf("Custom:\n")
for row=1:size(o,1)
    fprintf("k = %i,\t xk = %0.12f,\t f(xk) = % 0.12f\n",o(row, :))
end

%% Helper Function
function out = golden_sec(f, a, b, eps)
    k = 0;
    out = [k, a, b, f(a), f(b), a, b]; % array of output
        
    ro = (3 - sqrt(5))/2;
    
    while (b - a) >= eps
        k = k + 1;
        a1 = a + ro * (b - a);
        b1 = b - ro * (b - a);
        fa1 = f(a1);  % can store these to re-compute
        fb1 = f(b1);
        if fa1 > fb1
            a = a1;
        else
            b = b1;
        end
        out = [out ; [k, a1, b1, f(a), f(b), a, b]];
        %fprintf("k = %i,\t ak = %0.12f,\t bk = %0.12f,\t f(ak) = %0.12f,\t f(bk) = %0.12f\t [%0.6f, %0.6f]\n",k, a1, b1, fa1, fb1, a, b)
    end
end

function out = newtons(f, f1, f2, x, iter)
    k = 0;
    out = [k, x, f(x), f1(x), f2(x)];
    for i = 1:iter
        k = k + 1;
        x = x - f1(x)/f2(x);
        out = [out ; [k, x, f(x), f1(x), f2(x)]];
    end
end

function out = custom(f, x0, x1, x2, iter)
    k = 3;
    x = [x0, x1, x2];
    out = [k - 2, x(k), f(x(k))];
    for i = 1:iter
        s02 = x(k-0)^2 - x(k-2)^2;
        s10 = x(k-1)^2 - x(k-0)^2;
        s21 = x(k-2)^2 - x(k-1)^2;
        d12 = x(k-1) - x(k-2);
        d20 = x(k-2) - x(k-0);
        d01 = x(k-0) - x(k-1);
        
        num = -f(x(k-1))*s02 - f(x(k-2)) * s10 - f(x(k)) * s21;
        den = f(x(k)) * d12 + f(x(k-1)) * d20 + f(x(k-2)) * d01;
        x(k + 1) = num / (2 * den);
        k = k + 1;
        out = [out ; [k - 2, x(k), f(x(k))]];
    end
end
