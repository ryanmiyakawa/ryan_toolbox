function [] = dispar( ar, flag)

len = length(ar);

str = [];

for k = 1:len
    str = [str sprintf([flag '\n'], ar(k))];
end
disp(str)
