% Zerndecomp Ryan Miyakawa, 8/2006
% Modified 6/01/2007 for display functionality
% Modified 6/08/2007 to fix scaling issues
% Modified 11/2012 to use general GS and projection
% Modified 11/2016 Took me 10 years to open up the LA book... doh
%
% [orders,  B] = zerndecomp(wave, N, mask)
%


function [orders, B, rmsMWaves] = zerndecomp(wave, N, mask)

if exist('mask', 'var') ~= 1
    mask = ~(wave == 0 | isnan(wave));
end

% Generate zernike basis from orders 0 to N
B = zgen(mask, N, 'basis');

% Compute Linear LS reconstruction using SVD
orders = pinv(B)*(mask(:).*wave(:));

rmsMWaves = 1000*zernRMS(orders, mask)
fprintf('RMS magnitude in %d Zernikes starting from Z4 is: %0.3f mWaves\n', ...
    N, rmsMWaves);



