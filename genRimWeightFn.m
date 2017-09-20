function f = genRimWeightFn(a,b,c)

f = @(x) (-atan(-b*a)/(atan(b*(1-a))-atan(-b*a)) + atan((x-a)*b)/(atan(b*(1-a))-atan(-b*a)))*(1-c) + c;