% randpois(a,n)
%   This function creates a random variable with a Poisson distribution
%   with mean value 'a'.  If a second argument is used, a vector of
%   'n' poisson random variables is created.
%
%   if 'a' is an array and only one parameter is passed, the output array
%   is the same size as 'a' and each pixel in 'a' defines the poisson
%   distribution mean value for each corresponding pixel in the output
%
%   if 'a' is an array and two variables are passed, 'a' is treated as a scalar 
%   equal to the first pixel and the functionality reverts to the scalar 'a'
%   input case

function out = randpois(a,n)

if nargin == 1
    if length(a)>1   % generate a series of random numbers each with individual means
        w=find(a>0);
        out=zeros(size(a));
        n=length(w);
    else
        n=1;
    end;
end;



if nargin == 2   % generate a series of random numbers each with the same mean
    if n > 1
        out=zeros(n,1);
        a=out+a(1);
        w=find(a>0);
        n=length(w);
    end;
end;

if n == 1  % single random number requested
	if a>500   % approximate as Gaussian when mean > 500
        out=randn*sqrt(a)+a;
    else
        lamb=a;
        p=exp(-lamb);
        j=0;
        F=p;
        u=rand(1);
        while( u>F),
            j=j+1;
            p=lamb*p/j; F=F+p; 
        end;
        out=j;
	end;
else    % series of random numbers requested
    for m=1:length(w)
        k = w(m);
		if a(k)>500   % approximate as Gaussian when mean > 500
            out(k)=randn*sqrt(a(k))+a(k);
        else
            lamb=a(k);
            p=exp(-lamb);
            j=0;
            F=p;
            u=rand(1);
            try
            while( u>F),
                j=j+1;
                p=lamb*p/j; F=F+p; 
            end;
            catch
                1
            end
            out(k)=j;
		end;
    end;
end