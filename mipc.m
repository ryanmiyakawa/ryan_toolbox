function prod = mipc(A,B, domain)  %matrix inner product
if nargin == 2
    B = A;
end
prod = sum(sum(A.*conj(B).*domain));