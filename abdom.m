% 8/2012 R Miyakawa
%
%
%
% function out = abdom(domain, coef, flag = '')
%
% Creates an aberrated domain specified by DOMAIN and the coefficinets
% vector COEF.  If COEF is a N x 1 vector, ABDOM takes this as coefficients
% of Zernike polynomials 0 -> N - 1.  If COEF is a N x 2 vector, the first
% column specifies the desired aberration number starting with 0 for
% piston, and the second column specifies the magnitude
%
% If flag is set to 'ph', then the zernikes will specify the phase rather
% than amplitude

function out = abdom(domain, coef, flag)

[sr, sc] = size(coef);
out = zeros(size(domain));
switch sc
    case 1
        for k = 1:sr
            %fprintf('Coef: %d, val: %0.2f\n', k-1, coef(k));
            out = out + coef(k)*zgen(domain, k-1);
        end
    case 2
        if sr == 1 %% then this is case 1 with a 1x2 array
            out = abdom(domain, coef');
        else
            for k = 1:sr
                %fprintf('Coef: %d, val: %0.2f\n', coef(k,1), coef(k,2));
                out = out + coef(k,2)*zgen(domain, coef(k,1));
            end
        end
    otherwise
        if sr == 1 % then this is case 1 but vector is transposed:
            out = abdom(domain, coef');
        end
end

if nargin == 3 && strcmp(flag, 'ph')
    out = exp(2i*pi*out).*domain;
end


