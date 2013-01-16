function out = LSUnwrap2(psi, weights)


[sr, sc] = size(psi);
if nargin == 1
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
T=improved_generateT(alphas, betas);
T(1,2)=0;
T(1,sr+1)=0;

% Make A:
A=improved_generateA(alphas, betas);
% set first element to 0 for reference:
V = A*v;
V(1) = 0;

out = reshape(T\V,sr,sc);




function out = wrap(in)
out = mod(pi+in, 2*pi) - pi;
