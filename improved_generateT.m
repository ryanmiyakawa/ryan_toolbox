% 6/2011, Grace Gee
% Generates LS matrix T

function out=improved_generateT(al, be)
[n, m]=size(al);
[n2, m2] = size(be);

if (n~=n2) || (m~=m2)
    error('alpha and beta matrices must be the same size')
end


% if nargin == 1
%     % user forgot to enter a and b
%     a = .25;
%     b = 20;
% end
% 
% 
% %n is size, a is units to left/right, b is steepness
% 
% Xm = mean(Xderiv,3);
% Ym = mean(Yderiv,3);
% 
% 
% % y=(atan((x-a)*b)-atan(-a*b))/(atan(b*(1-a))-atan(-a*b)));
% 
% wFn = @(x,a,b) (atan((x-a)*b)-atan(-a*b))/(atan(b*(1-a))-atan(-a*b));
% 
% al = wFn(Xm, a, b);
% be = wFn(Ym,a,b);

out=spalloc(n*m, n*m, 5*n*m);

%matrix al=alpha, be=beta.

al=-1*al(:);
out=out+diag(sparse(al(1:n*m-n)), -n);

be=sparse(be(:));
be(1:n:end) = 0;
out=out+diag(-be(2:end), -1);

out=out+out';

%diag
d=sum(out,2);
out=out-diag(d,0);


    