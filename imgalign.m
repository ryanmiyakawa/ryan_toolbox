% function [x val] = imgalign(bad, good, guess, maxdistanceaway)
%
% uses derivative optimization routine to solve for the displacement vector
% between two images.  BAD specifies the image to be aligned, GOOD is the
% reference image, GUESS is an initial guess at the displacement vector, and
% MAXDISTANCEAWAY specifies the maximum displacement vector length

function [x val] = imgalign(bad, good, guess, maxdistanceaway)

[x, val] = fmincon( @(x) mip(good-splineshift(bad, [x(1),x(2)])),guess, [], [], [],[], ...
    -maxdistanceaway*ones(1,2), maxdistanceaway*ones(1,2));
