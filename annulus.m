function out = annulus(outer,inner, sr, sc)

if nargin == 2
    sr = outer;
    sc = outer;
end

if nargin == 3
    sc = outer;
end

p1 = pinhole(outer, sr, sc);
p2 = ~pinhole(inner, sr, sc);

out = double(p1&p2);