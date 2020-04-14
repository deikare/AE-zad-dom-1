%% AE - praca domowa nr 1
%% Bartosz Goławski
%% nr albumu 293452
%% 14.04.2020

clear;
close all

f_holder = @(x, y) ((x^2 + y - 11)^2 + (x + y^2 - 7)^2);

x_min = -6;
x_max = 6;
x_step = 0.1;

y_min = -6;
y_max = 6;
y_step = 0.1;

X = x_min : x_step : x_max;
Y = y_min : y_step : y_max;

Z = zeros(length(X), length(Y));

for i = 1 : length(X)
    for j = 1 : length(Y)
        [Z(i, j), ~, ~] = fun_celu([X(i) Y(j)]);
    end
end

figure;
contour(X, Y, Z, 100);
colormap default;
xlabel('x');
ylabel('y');
title('wykres poziomicowy');

fig = figure;
surf(X, Y, Z);
colormap spring;
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
title('wykres funkcji f');

options = optimoptions('fminunc', 'Algorithm', 'trust-region', 'SpecifyObjectiveGradient', true, 'HessianFcn', 'objective');

rng(30);
N = 40;
rozwiazanie = [];
for i = 1 : N
    x0 = [x_min+(x_max-x_min)*rand(), y_min+(y_max-y_min)*rand()];
    [x,fval,exitflag,output,grad,hessian] = fminunc(@(x)fun_celu(x), x0, options);
    rozwiazanie(i).x0 = x0;
    rozwiazanie(i).x = x;
    rozwiazanie(i).fval = fval;
    rozwiazanie(i).iterations = output.iterations;
    rozwiazanie(i).funcCount = output.funcCount;
    rozwiazanie(i).grad = grad;
end

X_rozw(1, :) = [3.58442834210819,-1.84812654402633];
X_rozw(2, :) = [-2.80511808887431,3.13131251836901];
X_rozw(3, :) = [2.99999999999999,2.00000000000004];
X_rozw(4, :) = [-3.77931025337846,-3.28318599128873];

figure;
syms x y
ezsurf(f_holder, [-6, 6, -6, 6]);
dotSize = 100;
hold on
for i = 1 : size(X_rozw, 1)
    [F_rozw(i), ~, ~] = fun_celu([X_rozw(i, 1) X_rozw(i, 2)]);
    scatter3(X_rozw(i, 1), X_rozw(i, 2), F_rozw(i), dotSize, 'red', 'filled');
end
title('znalezione minima');
xlabel('x');
ylabel('y');
zlabel('f');
hold off

figure;
syms x y
contour(X, Y, Z, 70);
dotSize = 50;
hold on
for i = 1 : size(X_rozw, 1)
    scatter3(X_rozw(i, 1), X_rozw(i, 2), F_rozw(i), dotSize, 'red', 'filled');
end
title('znalezione minima na wykresie poziomicowym');
xlabel('x');
ylabel('y');
zlabel('f');
hold off

