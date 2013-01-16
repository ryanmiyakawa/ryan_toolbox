function out = noisy(in, maxphoton)

maxin = max2(in);
if nargin == 1
    maxphoton = maxin;
end

out = randn(size(in)).*    sqrt(in/maxin*maxphoton)/(maxphoton/maxin) + in;
