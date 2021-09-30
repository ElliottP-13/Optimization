function x = newtons(f, grad, hessian, x, epsilon)
    k = 0;
    while norm(grad(x)) > epsilon
        k = k + 1;
        g = -grad(x);
        F = hessian(x);
        d = F \ g;
        x = x + d;
        
        fprintf("k = %d, f(x) = %0.5f\t", k, f(x));
        fprintf('x : [');
        fprintf('%g, ', x(1:end-1));
        fprintf('%g]\n', x(end));
    end
    
end