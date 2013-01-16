function out = stackup(in,sr,sc)

if nargin == 2
    sc = sr;
end

out = zeros(sr,sc);
out(:) = in;