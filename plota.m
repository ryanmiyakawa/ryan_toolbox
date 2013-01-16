function [] = plota(firstArg, nextArg)
if nargin == 2
    plot(firstArg, abs(nextArg));
else
plot(abs(firstArg));
end