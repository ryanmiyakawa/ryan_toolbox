% Custom 2D DFT
%
% Will reproduce the results of fft2 if:
% nx = 0:Nx-1
% ny = 0:Ny-1
% kx = (0:Nx-1)/Nx
% ky = (0:Ny-1)/Ny
%
% To center the results around 0 (fftshifted) use:
% kx = linspace(-1/2, 1/2 - 1/Nx, Nx)
% ky = linspace(-1/2, 1/2 - 1/Ny, Ny)


function Xk = cdft2_2(Xn, nx, ny, kx, ky, flag)

if nargin == 6 && strcmp(flag, 'nonuniform')
    [sr, sc] = size(Xn);
    [ksr, ksc] = size(kx);
    Xk = zeros(ksr,ksc);
    Xkm = zeros(ksr, sc);
    for k = 1:sc
        FTy = exp(-2i*pi*(ky(:,k)) *(ny(:,k).'));
        Xkm(:,k) = FTy*Xn(:,k);
    end
    for m = 1:sr
        FTx = exp(-2i*pi*(kx(m,:)).' *nx(m,:));
        Xk(m,:) = FTx*(Xkm(m,:).');
    end
    
    
else
    
    
    if nargin == 1
        [sr, sc] = size(Xn);
        nx = 1:sc;
        ny = 1:sr;
        kx = linspace(-1/2, 1/2 - 1/sc, sc);
        ky = linspace(-1/2, 1/2 - 1/sr, sr);
    end
    
    FTx = exp(-2i*pi*kx.' *nx);
    FTy = exp(-2i*pi*ky.' *ny);
    
    Xk =     (FTx*((FTy*Xn).')).';
end


