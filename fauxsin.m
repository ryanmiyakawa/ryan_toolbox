function out = fauxsin(res, offres, N, flag)
if nargin == 1
    offres = res;
end

ind = linspace(0, 2*pi*N, res);
sind = .5*(sin(ind) + 1);
out = zeros(offres,res);

switch flag
    case 'rand'
        out = rand(offres,res);
        for k = 1:res
            outCol = out(:,k);
            outCol(outCol < sind(k)) = 0;
            outCol(outCol >= sind(k)) = 1;
            out(:,k) = outCol;
        end
    case 'n2one'
        for k = 1:res
            fac =  sind(k);
            factot = 0;
            for m = 1:offres
                factot = factot + fac;
                if factot > 1
                    out(m,k) = 1;
                    factot = mod(factot, 1);
                else
                    out(m,k) = 0;
                end
                
                
            end
            %out(:,k) = circshift(out(:,k), [floor(offres*rand(1)),0]);
        end
    case 'n2onepar'
        factot = zeros(1,res);
        for m = 1:offres
            factot = factot + sind;
            outRow = zeros(1,res);
            outRow(factot>1) = 1;
            factot = mod(factot, 1);
            out(m,:) = outRow;
        end
        for k = 1:res
            out(:,k) = circshift(out(:,k), [floor(offres*rand(1)),0]);
        end
    case 'spsin'
        N = 2;
        slicesize = offres/N;
        % define ind:
        indr = ind;
        indo = 1:offres;
        [iR, iO] = meshgrid(indr, indo);
        out(abs(1 - mod( iO/slicesize, 2)) > .5*(sin(iR)) + .5) = 1;
    case 'realsin'
        out = extrude(.5+.5*sin(ind));
end

