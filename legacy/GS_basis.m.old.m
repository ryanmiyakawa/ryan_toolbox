%8/2012 Ryan Miyakawa  
%function [V,T] = ortho_basisc(domain, order, wflag)
%
% Extends orthobasis to consider an arbitrary basis set of vectors.
% Returns the basis vectors V and the transformation matrix T to get from
% the input basis to the orthonormal basis.

function [V,T] = GS_basis(B, order, domain)

% Check size of domain and basis:
numV = length(B);
if nargin == 1
    order = length(B);
else
    if order < length(B);
        error('Not enough basis vectors to support the desired order');
    end
end

if nargin < 3
    domain = ones(size(B{1}));
end

for k = 1:numV
    if ~all(size(domain) == size(B{k}))
        error('Domain and basis vectors must all be the same size');
    end
end

V = cell(1,order);
D = eye(order);
V{1} = B{1};
vnorm = zeros(1, order);
vnorm(1) = sqrt(mipc(V{1}, V{1}, domain));
V{1} = V{1}/vnorm(1);
D(1) = vnorm(1);
for k=2:order
    V{k} = B{k};
    subtract = 0;
    for m=1:k-1
        D(k,m) = mipc(V{k},V{m}, domain);
        subtract = subtract + D(k,m)*V{m};
    end
    V{k} = V{k} - subtract;
    vnorm(k) = sqrt(mipc(V{k},V{k}, domain));
    V{k} = V{k}/vnorm(k);
    D(k,k) = D(k,k)*vnorm(k);
end
T = inv(D)';
