% Custom 2D DFT
%
% Will reproduce the results of fft2 if:
% nx = 1:Nx
% ny = 1:Ny
% kx = (0:Nx-1)/Nx
% ky = (0:Ny-1)/Ny


function [Xk FTx FTy] = cdft2(Xn, nx, ny, kx, ky, flag)


if nargin == 6 && strcmp(flag, 'nonuniform') % Full coordinates specified:
    FTx = exp((-2i*pi) *nx.*kx);
    FTy = exp((-21*pi) *ny.*ky);
elseif nargin == 5
    
    FTx = exp((-2i*pi) * nx.' *kx);
    FTy = exp((-2i*pi) * ny.' *ky);
    
elseif nargin == 3
    FTx = nx;
    FTy = ny;
else
    error('Wrong number of input arguments');
end

Xk = (FTy.')*Xn*FTx;

