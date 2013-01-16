function p = ellipse(a,b,r,c)

ma = max(a,b);
mi = min(a,b);

if nargin == 2
    r = ma;
    c = ma;
end

if a==1 && b == 1
    p = pad2(1, r,c);
    return;
end
if (a == 1 && b == 2) || (a == 2 && b == 1) || (a == 2 && b == 2)
    p = pad2(1, r,c);
    return;
end


[X,Y] = meshgrid(  linspace(-1,1,ma)  );
frame = zeros(ma);
frame(X.^2/(b/ma)^2+Y.^2/(a/ma)^2 <= 1) = 1;

p = pad2(frame, r,c);