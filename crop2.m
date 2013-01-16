function out = crop2(in, lenr, lenc)


[sr,sc] = size(in);

if lenr > sr && lenc > sc
    out = pad2(in, lenr, lenc);
    return;
end



wr = lenr/2;
wc = lenc/2;
out = zeros(lenr, lenc);
out(1:lenr, 1:lenc) = ...
    in( floor(sr/2-wr+1):floor(sr/2+wr), floor(sc/2 - wc+1):floor(sc/2+wc));