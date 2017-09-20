% 8/2012 R Miyakawa
% 
% 
% 
% function out = abdom(domain, coef)
% 
% Creates an aberrated domain specified by DOMAIN and the coefficinets
% vector COEF.  If COEF is a N x 1 vector, ABDOM takes this as coefficients
% of Zernike polynomials 0 -> N - 1.  If COEF is a N x 2 vector, the first
% column specifies the desired aberration number starting with 0 for
% piston, and the second column specifies the magnitude


function out = abdom_fn(coef)
fnCoef = [];
[sr, sc] = size(coef);
switch sc
    case 1
        for k = 1:sr
            fnAr{k} = zgen([], k-1, 'fn');
            fnCoef(k) = coef(k);
        end
    case 2
        for k = 1:sr
            fnAr{k} = zgen([], coef(k,1), 'fn');
            fnCoef(k) = coef(k,2);
        end
    otherwise
        if sr == 1 % then this is case 1 but vector is transposed:
            out = abdom(coef');
        end
end
out = @(x,y) fnSum(fnAr, fnCoef, x, y);





function out = fnSum(fnAr, fnCoef, x, y)
out = 0;
for k = 1:length(fnAr)
    fnk = fnAr{k};
    out = out + fnCoef(k)*fnk(x,y); 
end

