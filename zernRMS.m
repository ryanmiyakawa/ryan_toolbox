% Computes the rms wavefront error from a vector of p2v coefficients,
% starts with piston

function rmsVal = zernRMS(abvec, domain, flag)
if nargin == 1
    domain = pinhole(500);
end

if nargin > 2 && strcmp(flag, 'all')
    
else
    abvec(1:4) = 0;
end

img = abdom(domain, abvec);
rmsVal = std(img(logical(domain)));
