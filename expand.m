function out = expand(in, px)

a = ones(px);

[sr,sc] = size(in);
out = zeros(px*sr, px*sc);
for k = 1:sr
    for m = 1:sc
        if in(k,m) ~= 0
            out((k-1)*px+1:k*px, (m-1)*px+1:m*px) = a*in(k,m);
        end
    end
end