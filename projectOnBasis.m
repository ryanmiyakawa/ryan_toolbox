% 7/2012 R Miyakawa
% 
% function out = projectOnBasis(vector, basis, mask, flag)
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
%  projection, projectOnBasis(vector, {V T}, mask, 'VT')
%
% 11/2016 updating to use SVD instead of GS

function out = projectOnBasis(vector, basis, mask, flag)
if exist('flag', 'var') ~= 1
    flag = '';
end


switch flag
    case 'ON'
        % Then project basis
        if nargin == 2
            mask = ones(size(basis{1}));
        end
        numB    = length(basis);
        out     = zeros(numB,1);
        for k = 1:numB
            out(k) = sum(mask(:).*vector(:).*basis{k}(:));
        end
        
    case 'VT'
        V = basis{1};
        T = basis{2};
        if isempty(mask)
            mask = ones(size(V{1})); 
        end
        numB    = length(V);
        out     = zeros(numB,1);
        for k = 1:numB
            out(k) = sum(mask(:).*vector(:).*V{k}(:));
        end
        out     = T*out;
 
    otherwise
        
        % Extract Cell:
        
        if iscell(basis)
            B = zeros(length(basis{1}(:)), length(basis));
            for k = 1:length(basis)
                B(:,k) = basis{k}(:);
            end
        else
            B = basis;
        end
        
        out = pinv(B)*(mask(:).*vector(:));
        
end



