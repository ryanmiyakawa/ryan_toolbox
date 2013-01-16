function out = gauss2d(sz, peak, width, shft)
if length(sz) == 1
    sr = sz;
    sc = sz;
else
    sr = sz(1);
    sc = sz(2);
end

if nargin == 3
    shftr = 0;
    shftc = 0;
else
    shftr = shft(1);
    shftc = shft(2);
end



indr = linspace(-sr/2, sr/2, sr);
indc = linspace(-sc/2, sc/2, sc);

[iR, iC] = meshgrid(indr, indc);

out = peak/(sqrt(2*pi)*width)*exp( -((iR-shftr).^2 + (iC-shftc).^2)/(2*width^2));





