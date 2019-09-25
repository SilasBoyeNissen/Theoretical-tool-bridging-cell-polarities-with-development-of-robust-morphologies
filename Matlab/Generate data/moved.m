function dr = moved(lambdas, NB, p)
b = 5; % beta (always five)
dr = zeros(size(p, 1), 10);
for i = 1:size(p, 1)
	Pi = p(i, :);
	NBi = NB(i, :);
	Pj = p(NBi(NBi>0), :)';
	x = Pj(1, :) - Pi(1);
	y = Pj(2, :) - Pi(2);
	z = Pj(3, :) - Pi(3);
	rij = sqrt(x.^2 + y.^2 + z.^2);
	x = x./rij;
	y = y./rij;
	z = z./rij;
	uPi = x*Pi(4) + y*Pi(5) + z*Pi(6);
	uQi = x*Pi(7) + y*Pi(8) + z*Pi(9);
	uPj = x.*Pj(4, :) + y.*Pj(5, :) + z.*Pj(6, :);
	uQj = x.*Pj(7, :) + y.*Pj(8, :) + z.*Pj(9, :);
	lambda = (lambdas(i, :)+lambdas(NBi(NBi>0), :))'/2;
	S1 = (y*Pi(6)-z*Pi(5)).*(y.*Pj(6, :)-z.*Pj(5, :)) + (z*Pi(4)-x*Pi(6)).*(z.*Pj(4, :)-x.*Pj(6, :)) + (x*Pi(5)-y*Pi(4)).*(x.*Pj(5, :)-y.*Pj(4, :));
	S2 = (Pi(5)*Pi(9) - Pi(6)*Pi(8)).*(Pj(5, :).*Pj(9, :)-Pj(6, :).*Pj(8, :)) + (Pi(6)*Pi(7) - Pi(4)*Pi(9)).*(Pj(6, :).*Pj(7, :)-Pj(4, :).*Pj(9, :)) + (Pi(4)*Pi(8) - Pi(5)*Pi(7)).*(Pj(4, :).*Pj(8, :)-Pj(5, :).*Pj(7, :));
	S3 = (y*Pi(9)-z*Pi(8)).*(y.*Pj(9, :)-z.*Pj(8, :)) + (z*Pi(7)-x*Pi(9)).*(z.*Pj(7, :)-x.*Pj(9, :)) + (x*Pi(8)-y*Pi(7)).*(x.*Pj(8, :)-y.*Pj(7, :));
	S = lambda(1, :).*S1 + lambda(2, :).*S2 + lambda(3, :).*S3;
	gamma = exp(-rij/b*(b-1)) - S/b + 2./rij.*(lambda(1, :).*uPi.*uPj + lambda(3, :).*uQi.*uQj);
	dr(i, 1) = sum(exp(-rij/b).*(lambda(1, :)./rij.*(uPj*Pi(4) + uPi.*Pj(4, :)) + lambda(3, :)./rij.*(uQj*Pi(7) + uQi.*Pj(7, :)) - gamma.*x), 2);
	dr(i, 2) = sum(exp(-rij/b).*(lambda(1, :)./rij.*(uPj*Pi(5) + uPi.*Pj(5, :)) + lambda(3, :)./rij.*(uQj*Pi(8) + uQi.*Pj(8, :)) - gamma.*y), 2);
	dr(i, 3) = sum(exp(-rij/b).*(lambda(1, :)./rij.*(uPj*Pi(6) + uPi.*Pj(6, :)) + lambda(3, :)./rij.*(uQj*Pi(9) + uQi.*Pj(9, :)) - gamma.*z), 2);
	dr(i, 4) = sum(exp(-rij/b).*(lambda(1, :).*(Pj(4, :) - uPj.*x - S1*Pi(4)) + lambda(2, :).*((Pi(8)*Pj(8, :) + Pi(9)*Pj(9, :)).*Pj(4, :) - (Pi(9)*Pj(6, :) + Pi(8)*Pj(5, :)).*Pj(7, :) - S2*Pi(4))), 2);
	dr(i, 5) = sum(exp(-rij/b).*(lambda(1, :).*(Pj(5, :) - uPj.*y - S1*Pi(5)) + lambda(2, :).*((Pi(9)*Pj(9, :) + Pi(7)*Pj(7, :)).*Pj(5, :) - (Pi(7)*Pj(4, :) + Pi(9)*Pj(6, :)).*Pj(8, :) - S2*Pi(5))), 2);
	dr(i, 6) = sum(exp(-rij/b).*(lambda(1, :).*(Pj(6, :) - uPj.*z - S1*Pi(6)) + lambda(2, :).*((Pi(7)*Pj(7, :) + Pi(8)*Pj(8, :)).*Pj(6, :) - (Pi(8)*Pj(5, :) + Pi(7)*Pj(4, :)).*Pj(9, :) - S2*Pi(6))), 2);
	dr(i, 7) = sum(exp(-rij/b).*(lambda(3, :).*(Pj(7, :) - uQj.*x - S3*Pi(7)) + lambda(2, :).*((Pi(5)*Pj(5, :) + Pi(6)*Pj(6, :)).*Pj(7, :) - (Pi(5)*Pj(8, :) + Pi(6)*Pj(9, :)).*Pj(4, :) - S2*Pi(7))), 2);
	dr(i, 8) = sum(exp(-rij/b).*(lambda(3, :).*(Pj(8, :) - uQj.*y - S3*Pi(8)) + lambda(2, :).*((Pi(6)*Pj(6, :) + Pi(4)*Pj(4, :)).*Pj(8, :) - (Pi(6)*Pj(9, :) + Pi(4)*Pj(7, :)).*Pj(5, :) - S2*Pi(8))), 2);
	dr(i, 9) = sum(exp(-rij/b).*(lambda(3, :).*(Pj(9, :) - uQj.*z - S3*Pi(9)) + lambda(2, :).*((Pi(4)*Pj(4, :) + Pi(5)*Pj(5, :)).*Pj(9, :) - (Pi(4)*Pj(7, :) + Pi(5)*Pj(8, :)).*Pj(6, :) - S2*Pi(9))), 2);
	dr(i, 10) = sum(exp(-rij) - S.*exp(-rij/b), 2);
end