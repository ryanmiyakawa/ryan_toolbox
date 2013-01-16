function prod = mip(A,B)  %matrix inner product
if nargin == 1
    B = A;
end
prod = sum(sum(A.*conj(B)));