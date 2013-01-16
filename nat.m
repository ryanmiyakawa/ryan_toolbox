function out = nat(sr, sc)
if nargin == 1
    sc = sr;
end

out = unstack(1:sr*sc,sr,sc);
