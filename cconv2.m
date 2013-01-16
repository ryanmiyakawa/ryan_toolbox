%performs 2D circular convolution of two matrices by the FT method

function out = cconv2(a, b)

siza = size(a);
sizb = size(b);

sizeout = [max(siza(1), sizb(1)), max(siza(2), sizb(2))]; 

out = ifft2( fft2(a, sizeout(1), sizeout(2)) .* fft2(b, sizeout(1), sizeout(2)));
