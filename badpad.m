%pads the wrong way for fftshift

function out = badpad(in, newlen)



len = length(in);

if newlen < len
    out = crop(in,newlen);
elseif newlen == len
    out = in;
else
out = zeros(1,newlen);

start = floor((newlen - len)/2);

out(start+1: start+len) = in;
end