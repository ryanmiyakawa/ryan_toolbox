function out = extrude(in, len)
if nargin == 1
    len = max(size(in));
end

[sr,sc] = size(in);

if sc == 1
    out = in*ones(1,len);
elseif sr == 1
    out = ones(len,1)*in;
else
    error('ERROR: input must be a 1-D vector')
end

