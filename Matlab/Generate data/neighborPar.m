function NB = neighborPar(ID, inc, p)
NB = zeros(size(p, 1), inc);
IDi = ID(:, 2:end);
parfor i = 1:size(p, 1)
	in = IDi(i, :);
    NBs = zeros(1, inc);
	x = p(i, 1)' - p(in, 1);
	y = p(i, 2)' - p(in, 2);
	z = p(i, 3)' - p(in, 3);
	nDis = (x/2 - x').^2 + (y/2 - y').^2 + (z/2 - z').^2;
	nDis(eye(inc, inc) == 1) = 1000;
    Z = in(sum(nDis < (x.^2 + y.^2 + z.^2)/4, 2) <= 0);
	NBs(1:numel(Z)) = Z;
	NB(i, :) = NBs;
end