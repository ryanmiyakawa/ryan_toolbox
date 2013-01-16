% Rotates zernike vector by using linear combination of zernikes of same
% order

function out = rotZernVec(in, th)

nZ = length(in);
%zIdx = 0:nZ-1;
zIdx = 1:nZ;

[dummy, mT] = j2nm(zIdx(end));
if mT > 0 % add one more polynomial to pair up
    in = [in 0];
    nZ = nZ + 1;
    %zIdx = 0:nZ-1;
    zIdx = 1:nZ;
end
    
T = zeros(nZ);
for k = 1:length(zIdx)
    [dummy, m] = j2nm(zIdx(k));
    if m == 0
        T(k,k) = 1;
    elseif m < 0
        T(k,k) = cos(m*th);
        T(k,k-1) = sin(m*th);
    else % m > 0
        T(k,k) = cos(m*th);
        T(k,k+1) = -sin(m*th);
    end

end
 
out = (T*(in.')).';

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

