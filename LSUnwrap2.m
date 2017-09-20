function [out, T, A] = LSUnwrap2(psi, weights, T, A)


[sr, sc] = size(psi);
if exist('weights', 'var') ~= 1 || numel(weights) == 0
    weights = ones(size(psi));
else
    weights = weights/max(weights(:));
end


deltas = wrap(circshift(psi, [0 1]) - psi);
omegas = wrap(circshift(psi, [1 0]) - psi);

a = .35; % Knee
b = 20; % Slope
c = .03; % floor

f = genRimWeightFn(a,b,c);

alphas = f((weights + circshift(weights, [0 1]))/2);
betas = f((weights + circshift(weights, [1 0]))/2);

% Make v:
v = [deltas(:);omegas(:)];


% Make T:
if exist('T', 'var') ~= 1
    T=improved_generateT(alphas, betas);
    T(1,2)=0;
    T(1,sr+1)=0;
end

% Make A:
if exist('A', 'var') ~= 1
    A=improved_generateA(alphas, betas);
end

% set first element to 0 for reference:
V = A*v;
V(1) = 0;

out = reshape(T\V,sr,sc);




function out = wrap(in)
out = mod(pi+in, 2*pi) - pi;
