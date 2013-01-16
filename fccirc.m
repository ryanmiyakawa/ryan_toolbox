%creates a circle of diameter d, centered about the (0,0) fourier component
%after a fftshift.

function out = fccirc(d, rpad, cpad)
if nargin == 1
    rpad = d;
    cpad = d;
end
out = zeros(rpad, cpad);
xcen = floor(cpad/2)+1;
ycen = floor(rpad/2)+1;
[X, Y] = meshgrid(1:rpad,1:cpad);
out( sqrt((X-xcen).^2 + (Y-ycen).^2) <= d/2  ) = 1;