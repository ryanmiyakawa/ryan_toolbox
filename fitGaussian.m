function [x_star, maxVal, objFn] = fitGaussian(x, y, X0)


[mx, mIdx] = max(y);

% if there is no initial guess, try the cardinal max
if nargin == 3
    X0_est = X0;
else
    X0_est = x(mIdx);
end


avg_0    = X0_est;
stdev_0  = abs((x(end)-x(1)))/length(y);
scale_0  = mx;
offset_0 = min(y);

% create objective
g = @(coef, ind) coef(1)* exp(-(ind - coef(3)).^2/(2*coef(2)^2)) + coef(4);
% create error function:
f = @(coef) sum(abs( g(coef, x) -y).^2);

% set options:
opts = optimset('TolX', 1e-10, 'TolFun', 1e-10, 'display', 'off');
[coef, ~, ~] = fminsearch(f, [scale_0; stdev_0; avg_0; offset_0], opts);



x_star = coef(3);
objFn = @(x) g(coef,x);
maxVal = objFn(x_star);
