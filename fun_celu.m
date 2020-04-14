function [f, gradient, hessian] = fun_celu(x)
    f = ((x(1))^2 + x(2) - 11)^2 + (x(1) + (x(2))^2 - 7)^2;
    
    gradient = [4*(x(1))^3 - 42*x(1) + 4*x(1)*x(2) + 2*(x(2))^2 - 14; 4*(x(2))^3 + 2*(x(1))^2 - 26*x(2) + 4*x(1)*x(2) - 22];
    
    hessian(1,1) = 12 * (x(1))^2 - 42 + 4 * x(2);
    hessian(1, 2) = 4 * x(1) + 4 * x(2);
    hessian(2, 1) = hessian(1, 2);
    hessian(2, 2) = 12 * (x(2))^2 - 26 + 4 * x(1);
end

