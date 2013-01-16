% 9/1/07  Ryan Miyakawa
%
% Discrete Fourier Transform in 2D by vectorized multiplication, which is
% much faster than looping.  IN is the input, OUTRES specifies the output
% resolution which when different from size(IN), is equivalent to padding
% with zeros.  CINRANGE and RINRANGE specifies the window in pixels in which the dft
% is to be taken.
%
% DFT2 is not FFT2, and effectively "zeropads" the input to infinity.


function output = dft2(in, outres, rinrange, cinrange)



[s,s] = size(in);

crange = cinrange*outres/s ;
rrange = rinrange*outres/s ;

in_ind = 1:s;
sx = (crange(2) - crange(1));
sy = (rrange(2) - rrange(1));
onexpixel = sx/outres;
oneypixel = sy/outres;
out_indx = linspace( crange(1)-outres/2 + onexpixel, crange(2)-outres/2, outres);
out_indy = linspace( rrange(1)-outres/2 + oneypixel, rrange(2)-outres/2, outres);
fx = exp((-2*pi*i)/outres * (in_ind-1).' *(out_indx-onexpixel)); 
fy = exp((-2*pi*i)/outres * (in_ind-1).' *(out_indy-oneypixel)); 
output = (fy.')*in*fx;


