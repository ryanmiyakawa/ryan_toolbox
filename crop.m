
%crops symmetrically

function out = crop(in, len)
s = length(in);
w = (len/2);
out = zeros(1, len);
out(1:len) = ...
    in( floor(s/2-w+1):floor(s/2+w));