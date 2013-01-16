function out = gauss1d(sz, peak, sigma, shft)


ind = linspace(-sz/2, sz/2, sz);


out = peak/(sqrt(2*pi)*sigma)*exp( -( (ind-shft).^2)/(2*sigma^2));





