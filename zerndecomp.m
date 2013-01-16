%Zerndecomp Ryan Miyakawa, 8/2006
%Modified 6/01/2007 for display functionality
%Modified 6/08/2007 to fix scaling issues
% Modified 11/2012 to use general GS and projection
%
%function orders = zerndecomp(wave, N, flag)
%
%Decomposes a wavefront into a basis of Zernike polynomials and returns the
%coeffficients in number of waves over the NA.  Since the discrete zernike functions are not orthogonal,
%an orthogonal set is constructed using the gram-schmidt algorithm.  The
%coefficients are matched to this orthogonal basis and then remapped to the
%Zernikes.  Zerndecom automatically crops the wave input to a circle. The
%parameter N specifies the number of basis vectors to in the constructed basis set.  It is
%important to choose an N larger than the highest order Zernike function
%you are interested in, since that function will not necessarily be linearly
%independent with lower orders if a smaller N is chosen
%
%WAVE is the target wavefront.  
%
%FLAG can be set to control display behavior and to monitor progress with a waitbar:
%               a:  display all coefficients
%               s:  display all non-trivial coefficients (TOL = 1e-8)
%               aw:  display all coefficients and show waitbar
%               sw:  display all non-trivial coefficients and show waitbar
%               w: no display, but show waitbar
%               no value:  no display
%
%Zerndecomp requires functions: orthobasis; To run properly

function orders = zerndecomp(wave, N, mask, flag)

%% flag logic
if exist('flag') ~= 1
    flag = 'n';
end
if flag(1) == 'w'
    track = 1;
else
    track = 0;
end
if length(flag) == 2 && flag(2) == 'w'
    track = 1;
    flag = flag(1);
end


zrnOrders = 0:N;
B = cell(1,length(zrnOrders));
for k = 1:length(zrnOrders)
    thisZrnOrder = zrnOrders(k);
    B{k} = zgen(mask, thisZrnOrder);
end

[V T] = GS_basis(B, mask);
orders = projectOnBasis(wave, {V T}, mask, 'VT');


if flag == 'a'
    orders = round(1e14*orders)/1e14; %eliminates roe precision inconsistencies
else
    orders = round(1e8*orders)/1e8; %eliminates roe precision inconsistencies
end

% display
if exist('flag') == 1 && (flag == 's' || flag == 'a')
    load aberrations.mat %cell array with the names of the aberrations
    str =  ['ABERRATIONS:' sprintf('\n')];
    if flag == 'a'
        str = ['COMPLETE CHARACTERIZATION:' sprintf('\n')];
    elseif flag == 's'
        str = ['NONTRIVIAL ABERRATION COEFFICIENTS:' sprintf('\n')];
    end
    for j = 0:N
        if flag == 's' && abs(orders(j+1)) < 1e-8
            continue
        end
        str = [str  'Z_' num2str(j) ' (' [aberrations{j+1} sprintf('): %0.5g\n', orders(j+1))] ];
    end
    disp(str);
end

if track
    close(h);
end
