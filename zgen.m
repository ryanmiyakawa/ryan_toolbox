% 8/2012, function out = zgen(domain, order)
%
% This function (has been long coming) creates a zernike polynomial over
% the domain specified by DOMAIN at an arbitrary order ORDER.  If DOMAIN is
% a single number, it is taken to be a pinhole of resolution specified by
% that number.  Flag specifies:
%
%     pt: computes OUT to be a list of values specified by coordinate pairs
%     specified by a N x 2 vector inputed as DOMAIN
% 
%     fn: returns a handle to a function to compute zernikes over DOMAIN
%
%     coef-mat: returns a matrix representing the coefficients of
%     radius-angle products organized in the following way:
%        rows represent exponent of r, starting with r^0
%        cols represent angle in this order: 1, cos(th), sin(th),
%        cos(2*th), sin(2*th), ...

function out = zgen(domain, order, flag)
if nargin == 2
    flag = 'none';
end

switch flag
    case 'pt'
        xind = domain(:,1);
        yind = domain(:,2);
        [TH, R] = cart2pol(xind, yind);
        [n, m] = j2nm(order);
        Z = ZgenNM(n, m);
        out = Z(R, TH);
        out(R>1) = nan;
%         ZgenNMshow(n, m, R, TH);
    case 'fn'
        [n, m] = j2nm(order);
        zRTH = ZgenNM(n,m);
        out = @(x,y) zRTH(sqrt(x.^2 + y.^2), atan2(y,x));
    case 'fnr'
        [n, m] = j2nm(order);
        zRTH = ZgenNM(n,m);
        out = @(r,th) zRTH(r, th);
        
    case 'coef-mat'
        % Build a vector of coefficients where each element represents a
        % sequential polynomial summing L to R along the Zernike tree:
        % [1 r*sin(th) r*cos(th) r^2*sin(2*th) r^2 r^2*cos(2*th), ...]
        [n, m] = j2nm(order);
        
        rCoefs = RgenNMCoef(n,m);
        angCoefs = AgenNMCoef(m);
        out = rCoefs' * angCoefs';
        
        
    case 'none'
        if length(domain) == 1
            % assume DOMAIN is specifying resolution
            domain = pinhole(domain(1));
        end
        [sy, sx] = size(domain);
        xind = linspace(-1, 1, sx);
        yind = linspace(-1, 1, sy);
        [X, Y] = meshgrid(xind, yind);
        idx = find(domain);
        [TH, R] = cart2pol(X(idx), Y(idx));
        [n, m] = j2nm(order);
        Z = ZgenNM(n, m);
        z = Z(R, TH);
        out = domain;
        out(idx) = z;
    case 'basis'
        [sy, sx] = size(domain);
        xind = linspace(-1, 1, sx);
        yind = linspace(-1, 1, sy);
        [X, Y] = meshgrid(xind, yind);
        out = zeros(sx*sy, order + 1);
        out(:,1) = domain(:);
        for k = 1:order
            [n, m] = j2nm(k);
            zRTH = ZgenNM(n,m);
            out(:, k+1) = zRTH(sqrt(X(:).^2 + Y(:).^2), atan2(Y(:),X(:))).*domain(:);
        end
end


function Z = ZgenNM(n,m)
R = RgenNM(n,abs(m));
A = AgenNM(m);
Z = @(r, phi) R(r).*A(phi);



% Forms radial function based on n,m
function f = RgenNM(n,m)
p = (n-m)/2;
f = @(r) 0;

for k = 0:p
    coef = (-1)^k*nchoosek(n-k,k)*nchoosek(n-2*k,(n-m)/2-k);
    ex = (n - 2*k);
    f = @(r) f(r) + coef*r.^ex;
end


% Forms azimuthal function based on n,m
function g = AgenNM(m)
if m > 0
    g = @(phi) cos(m*phi);
elseif m < 0
    g = @(phi) -sin(m*phi);
else
    g = @(phi) 1;
end


% Generates a coefficient vector
function coefs = RgenNMCoef(n,m)
p = (n-m)/2;

coefs = zeros(1,p + 1);
for k = 0:p
    coef = (-1)^k*nchoosek(n-k,k)*nchoosek(n-2*k,(n-m)/2-k);
    ex = (n - 2*k);
    coefs(ex + 1) = coef;
end

% Generates a coefficient vector
function angCoefs = AgenNMCoef(m)
cosCoefs = zeros(1,m);
sinCoefs = zeros(1,m);
if m > 0
    cosCoefs(m) = 1;
elseif m < 0
    sinCoefs(m) = -1;

elseif m == 0
    angCoefs = 1;
    return
end
angCoefs = [cosCoefs; sinCoefs];
angCoefs = angCoefs(:);

function [n,m] = j2nm(j)
% j = j+1; % 0 is piston
smct = 2;
ct = 0;
numInSmct = 3;
while j > 0
    smct = smct + 2;
    j = j - numInSmct;
    numInSmct = smct + 1;
    ct = ct + 1;
end
n = 2*ct;
m = 0;

for k = 1:abs(j)
    if isodd(k)
        n = n - 1;
        m = m + 1;
    end
end
if isodd(abs(j))
    m = -m;
end



