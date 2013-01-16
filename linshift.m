function out = linshift(in, shift)


out = zeros(size(in));
len = length(out);

if shift >= 0 
    out(shift+1:end) = in(1: len-shift);
else
    out(1:len+shift) = in(-shift+1:end);
end
