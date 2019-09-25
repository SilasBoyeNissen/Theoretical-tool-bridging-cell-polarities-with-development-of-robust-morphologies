function dr = moved(l, NB, p)
b = 5;
N = size(p, 1);
dr = zeros(N, 7);
for i = 1:N
    Pi = p(i, :);
    Pj = p(NB(i, :) == 1, :)';
    x = Pj(1, :) - Pi(1);
    y = Pj(2, :) - Pi(2);
    z = Pj(3, :) - Pi(3);
    d = sqrt(x.^2 + y.^2 + z.^2);
    x = x./d;
    y = y./d;
    z = z./d;
    ld = l(i)./d;
    dbeta = -d/b;
    fac = -l(i).*exp(dbeta);
    uPi = x*Pi(4) + y*Pi(5) + z*Pi(6);
    uPj = x.*Pj(4, :) + y.*Pj(5, :) + z.*Pj(6, :);
    S = (y*Pi(6)-z*Pi(5)).*(y.*Pj(6, :)-z.*Pj(5, :)) + (z*Pi(4)-x*Pi(6)).*(z.*Pj(4, :)-x.*Pj(6, :)) + (x*Pi(5)-y*Pi(4)).*(x.*Pj(5, :)-y.*Pj(4, :));
    par = exp(dbeta*(b-1)) - (l(i)*S+1 - l(i))/b + 2*ld.*uPi.*uPj;
    dr(i, 1) = -sum(exp(dbeta).*(par.*x - ld.*(uPj*Pi(4) + uPi.*Pj(4, :))), 2);
    dr(i, 2) = -sum(exp(dbeta).*(par.*y - ld.*(uPj*Pi(5) + uPi.*Pj(5, :))), 2);
    dr(i, 3) = -sum(exp(dbeta).*(par.*z - ld.*(uPj*Pi(6) + uPi.*Pj(6, :))), 2);
    dr(i, 4:6) = [sum(fac.*(uPj.*x + S*Pi(4) - Pj(4, :)), 2) sum(fac.*(uPj.*y + S*Pi(5) - Pj(5, :)), 2) sum(fac.*(uPj.*z + S*Pi(6) - Pj(6, :)), 2)];
    dr(i, 7) = sum(exp(-d) - l(i)*S.*exp(dbeta) - (1-l(i))*exp(dbeta), 2);
end