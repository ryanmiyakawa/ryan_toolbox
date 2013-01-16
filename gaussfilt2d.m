function [out, Z] = gaussfilt2d(in, cen, width, abcd)

[sr, sc] = size(in);

[R C] = meshgrid(1:sr, 1:sc);

Z = exp(-((cen(2) - R).^2 + (cen(1) - C).^2)/(2*width^2));
Z = Z./max(Z(:));

if nargin == 4
% create zero:
    f = genRimWeightFn(abcd(1), abcd(2), abcd(3));
    Z = f(Z);
    Z = Z - ones(size(in))*abcd(4);
    Z(Z<0) = 0;
    
end
% figure(2)
% plot(Z(floor(sr/2), :));
% figure(5)

out = Z.*in;