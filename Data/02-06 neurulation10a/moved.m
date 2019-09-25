function dr = moved(l, NB, p)
b = 5;
n = 1;
dr = zeros(size(p, 1), 10);
for i = 1:size(p, 1)
    Pi = p(i, :);
    NBi = sort(NB(i, :));
    Pj = p(NBi(NBi>0), :)';
    x = Pj(1, :) - Pi(1);
    y = Pj(2, :) - Pi(2);
    z = Pj(3, :) - Pi(3);
    d = sqrt(x.^2 + y.^2 + z.^2);
    A = min(l(i, :), l(NBi(NBi>0), :))';
    x = x./d;
    y = y./d;
    z = z./d;
    sc = 1./(n*d.^n);
    ex = exp(-(d/b).^n);
    uPi = x*Pi(4) + y*Pi(5) + z*Pi(6);
    uPj = x.*Pj(4, :) + y.*Pj(5, :) + z.*Pj(6, :);
    S1 = (y*Pi(6)-z*Pi(5)).*(y.*Pj(6, :)-z.*Pj(5, :)) + (z*Pi(4)-x*Pi(6)).*(z.*Pj(4, :)-x.*Pj(6, :)) + (x*Pi(5)-y*Pi(4)).*(x.*Pj(5, :)-y.*Pj(4, :));
    S2 = (Pi(5)*Pi(9) - Pi(6)*Pi(8)).*(Pj(5, :).*Pj(9, :)-Pj(6, :).*Pj(8, :)) + (Pi(6)*Pi(7) - Pi(4)*Pi(9)).*(Pj(6, :).*Pj(7, :)-Pj(4, :).*Pj(9, :)) + (Pi(4)*Pi(8) - Pi(5)*Pi(7)).*(Pj(4, :).*Pj(8, :)-Pj(5, :).*Pj(7, :));
    AA = A(1, :).*S1 + A(2, :).*S2 + A(3, :);
    par = exp(-(d/b).^n*(b^n-1)) - AA/b.^n + 2*sc.*A(1, :).*uPi.*uPj;
    dr(i, 1) = sum(n*d.^(n-1).*ex.*(A(1, :).*sc.*(uPj*Pi(4) + uPi.*Pj(4, :)) - par.*x), 2);
    dr(i, 2) = sum(n*d.^(n-1).*ex.*(A(1, :).*sc.*(uPj*Pi(5) + uPi.*Pj(5, :)) - par.*y), 2);
    dr(i, 3) = sum(n*d.^(n-1).*ex.*(A(1, :).*sc.*(uPj*Pi(6) + uPi.*Pj(6, :)) - par.*z), 2);
    dr(i, 4) = sum(ex.*(A(1, :).*(Pj(4, :) - uPj.*x - S1*Pi(4)) + A(2, :).*((Pi(8)*Pj(8, :) + Pi(9)*Pj(9, :)).*Pj(4, :) - (Pi(9)*Pj(6, :) + Pi(8)*Pj(5, :)).*Pj(7, :) - S2*Pi(4))), 2);
    dr(i, 5) = sum(ex.*(A(1, :).*(Pj(5, :) - uPj.*y - S1*Pi(5)) + A(2, :).*((Pi(9)*Pj(9, :) + Pi(7)*Pj(7, :)).*Pj(5, :) - (Pi(7)*Pj(4, :) + Pi(9)*Pj(6, :)).*Pj(8, :) - S2*Pi(5))), 2);
    dr(i, 6) = sum(ex.*(A(1, :).*(Pj(6, :) - uPj.*z - S1*Pi(6)) + A(2, :).*((Pi(7)*Pj(7, :) + Pi(8)*Pj(8, :)).*Pj(6, :) - (Pi(8)*Pj(5, :) + Pi(7)*Pj(4, :)).*Pj(9, :) - S2*Pi(6))), 2);
    dr(i, 7) = sum(ex.*(A(2, :).*((Pi(5)*Pj(5, :) + Pi(6)*Pj(6, :)).*Pj(7, :) - (Pi(5)*Pj(8, :) + Pi(6)*Pj(9, :)).*Pj(4, :) - S2*Pi(7))), 2);
    dr(i, 8) = sum(ex.*(A(2, :).*((Pi(6)*Pj(6, :) + Pi(4)*Pj(4, :)).*Pj(8, :) - (Pi(6)*Pj(9, :) + Pi(4)*Pj(7, :)).*Pj(5, :) - S2*Pi(8))), 2);
    dr(i, 9) = sum(ex.*(A(2, :).*((Pi(4)*Pj(4, :) + Pi(5)*Pj(5, :)).*Pj(9, :) - (Pi(4)*Pj(7, :) + Pi(5)*Pj(8, :)).*Pj(6, :) - S2*Pi(9))), 2);
    dr(i, 10) = sum(exp(-d.^n) - AA.*ex, 2);
end