% Gets point spread function in correct coordinates. Only supports circular
% apertures and PSF right now

function PSF = computePSF(H, lambda, NA, xmin, xmax, res)

Nx = length(H);
dLimit = lambda/NA;
fmin = xmin/dLimit;
fmax = xmax/dLimit;

PSF = cdft2_2(H, linspace(0,1, Nx), linspace(0,1, Nx), linspace(fmin, fmax, res), linspace(fmin, fmax, res));