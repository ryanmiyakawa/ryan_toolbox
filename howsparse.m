function [out str] = howsparse(in, name)
if nargin == 1
    name = 'Matrix';
end


sp = length(find(in(:) == 0));
len = length(in(:));

out = sp/len;

str = sprintf([name ' is %0.2f%% sparse\n'], sp/len*100);