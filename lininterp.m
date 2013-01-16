% function out = lininterp(X0, Y0, X1min, X1max, N)
% Interpolates a data set using the values in arrays X0 and Y0
function out = lininterp(X0, Y0, X1min, X1max, N)
out = zeros(1,N);
inds = linspace(X1min, X1max, N);
for k = 1:N
    out(k) = findVal(X0,Y0, inds(k));
end



function out = findVal(X0, Y0, in)

inds = find(in < X0);

if isempty(inds)
    out = Y0(end);
    return
elseif inds(1) == 1
    out = Y0(1);
    return
end

ind = inds(1);

dx = X0(ind) - X0(ind-1);

F1 = (in - X0(ind-1))/dx;
F2 = (X0(ind) - in)/dx;

out = Y0(ind-1)*F2 + Y0(ind)*F1;