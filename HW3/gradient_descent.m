function x = gradient_descent(f, f1, x, epsilon)
    k = 0;
    while norm(f1(x)) > epsilon
        k = k + 1;
        d = -f1(x);
        alpha = fminsearch(@(a) f(x + a * d), 1);
        x = x + alpha * d;
        fprintf("k = %d \t", k);
        fprintf('x : [');
        fprintf('%g, ', x(1:end-1));
        fprintf('%g]\n', x(end));
    end

end