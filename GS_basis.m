% 11/2012 Ryan Miyakawa  
% function [V,T] = GS_basis(B, domain)
%
% Extends orthobasis to consider an arbitrary basis set of vectors.
% Returns the basis vectors V and the transformation matrix T to get from
% the input basis to the orthonormal basis.  Update 11/2012, verified
% transformation matrix and made algorithm more numerically stable

function [V,T] = GS_basis(B, domain)

if nargin < 2
    domain = ones(size(B{1}));
end

numV = length(B);
for k = 1:numV
    if ~all(size(domain) == size(B{k}))
        error('Domain and basis vectors must all be the same size');
    end
end

% New GS algorithm:
V = B;
for k = 1:length(V)
    kkNorm = 1/sqrt(mipc(V{k}, V{k}, domain));
    V{k} = V{k}*kkNorm;
    
    for m = k+1:length(V)
        V{m} = V{m} - proj(V{k}, V{m}, domain);
    end
    
end

% Generate transformation.
D = zeros(numV);
for k = 1:length(V)
    for m = 1:k
        D(k,m) = mipc(B{k}, V{m}, domain);
    end
end
T = (inv(D))'; % Ref: page 80 Example 2 of Friedberg, Insel and Spence

%Projection
function out = proj(u,v, domain)
out = u*mipc(u,v,domain)/mipc(u,u,domain);

%matrix inner product
function prod = mipc(A,B, domain)  
if nargin == 2
    B = A;
end
prod = sum(sum(A.*conj(B).*domain));

