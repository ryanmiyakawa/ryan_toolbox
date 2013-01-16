function out = sround(in, sg)

if nargin == 1
    sg = 1;
end

out = zeros(1, length(in));
for k = 1:length(in)
    out(k) = round(in(k)/sg)*sg;
end
    