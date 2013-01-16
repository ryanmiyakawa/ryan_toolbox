function out = lorentz(in, A, gam, cen)

if nargin == 3
    cen = 0;
end

out = A/pi*(gam./((in - cen).^2 + gam^2));
