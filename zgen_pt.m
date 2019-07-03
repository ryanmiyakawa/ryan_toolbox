% 4/2013, function out = zgen_pt(order, x, y)
%
% Generates the value of the aberration at the specified point.  This
% function is designed to operate more quicly than zgen with flag = 'pt'

function Zv = zgen_pt(order, x, y)

[th, r] = cart2pol(x, y);
[n, m] = j2nm(order);

p = (n-abs(m))/2;

% get radial part
Rv = 0;
for k = 0:p
    
    fprintf('[%d, %d], [%d, %d]\n',n-k, k, n-2*k,  (n-m)/2-k);
    Rv = Rv +  (-1)^k*nchoosek(n-k,k)*nchoosek(n-2*k,(n-abs(m))/2-k)*r.^(n - 2*k);
end

% get azimuthal part
if m > 0
    Av = cos(m*th);
elseif m < 0
    Av = -sin(m*th);
else
    Av = 1;
end
fprintf('%0.2f, %0.2f', Rv, Av);
Zv = Rv*Av;



function [n,m] = j2nm(j)
% j = j+1; % 0 is piston
smct = 2;
ct = 0;
numInSmct = 3;
while j > 0
    smct = smct + 2;
    j = j - numInSmct;
    numInSmct = smct + 1;
    ct = ct + 1;
end
n = 2*ct;
m = 0;

for k = 1:abs(j)
    if isodd(k)
        n = n - 1;
        m = m + 1;
    end
end
if isodd(abs(j))
    m = -m;
end



