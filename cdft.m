% Xk = cdft(xn, n, k)
% xn is input signal
% n should be wav data divided by sampling rate: y/Fs
% k is list of frequencies in Hz that should be outputed
%
% Xk = cdft(xn, FT)
% FT is the Fourier transforming matrix exp(-2i*pi*(k.')*n)

function Xk = cdft(xn, n, k)


% if length(n) ~= length(k)
%     error('k and n should have same length');
% end
% if length(n) ~= size(xn,2)
%     error('xn and n must have the same number of rows');
% end
% if size(n, 1) ~= 1
%     error('n should be a row vector');
% end
% if size(k, 1) ~= 1
%     error ('k should be a row vector');
% end
% 

if nargin == 2 %FT matrix is passed in
    Xk = n*(xn.');
    
elseif nargin == 3
FT = exp(-2i*pi*(k.')*n);
Xk = FT*xn.';
end

