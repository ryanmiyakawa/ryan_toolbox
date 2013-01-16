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


function out = abdom(domain, coef)

[sr, sc] = size(coef);
out = zeros(size(domain));
switch sc
    case 1
        for k = 1:sr
            out = out + coef(k)*zgen(domain, k-1);
        end
    case 2
        
        for k = 1:sr
            out = out + coef(k,2)*zgen(domain, coef(k,1));
        end
    otherwise
        if sr == 1 % then this is case 1 but vector is transposed:
            out = abdom(domain, coef');
        end
end
