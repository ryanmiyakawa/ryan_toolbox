% 7/2012 R Miyakawa
% 
% function out = projectOnBasis(vector, basis, flag)
% Projects vector VECTOR onto basis BASIS.  BASIS need not be
% orthonormalized.  BASIS should be either a cell array of basis vectors,
% or a cell array of the duplet {V T} that is output from the function
% GS_basis.  
% 
% FLAG sets the type of projection and the amount of necessary
% compuatation:
%  flag == '': Assumes basis is not orthonormalized and performs GS
%  flag == 'ON': Projects vector onto basis without using GS
%  flag == 'VT': Uses the duplet {V T} from GS_basis to perform the
%  projection

function out = projectOnBasis(vector, basis, mask, flag)
if nargin == 3
    flag = '';
end

switch flag
    case 'ON'
        % Then project basis
        [sr sc] = size(basis{1});
        if nargin == 2
            mask = ones(sr,sc);
        end
        numB = length(basis);
        out = zeros(numB,1);
        for k = 1:numB
            out(k) = sum(mask(:).*vector(:).*basis{k}(:));
        end
        
    case 'VT'
        V = basis{1};
        T = basis{2};
        if nargin == 2
            mask = ones(size(V{1})); 
        end
        numB = length(V);
        out = zeros(numB,1);
        for k = 1:numB
            out(k) = sum(mask(:).*vector(:).*V{k}(:));
        end
        out = T*out;
        

        
    otherwise
        [V T] = GS_basis(basis, mask);
        numB = length(basis);
        out = zeros(numB,1);
        for k = 1:numB
            out(k) = sum(mask(:).*vector(:).*V{k}(:));
        end
        out = T*out;
end



