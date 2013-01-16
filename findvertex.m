%finds vertex of even order polynomial that has only minimum
function [val, idx, mn] = findvertex(coef, range, tol)

ind = linspace(range(1), range(2), 2*ceil((range(2) - range(1))/tol));


tot = zeros(1,length(ind));
for k = 1:length(coef)
    tot = tot + coef(length(coef) + 1 - k)*ind.^(k-1);
end

[mn,idx] = min(tot);

val = ind(idx);


