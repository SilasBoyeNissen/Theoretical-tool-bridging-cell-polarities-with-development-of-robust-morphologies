function TRI = neighbor(inc, p, pol)
k = 1;
TRI = zeros(6*size(p, 1), 3);
ID = knnsearch(p(:, 1:3), p(:, 1:3), 'K', 2*inc+1);
for i = 1:size(p, 1)
    in = ID(i, 2:inc+1);
    x = p(i, 1)' - p(in, 1);
    y = p(i, 2)' - p(in, 2);
    z = p(i, 3)' - p(in, 3);
    nDis = (x/2 - x').^2 + (y/2 - y').^2 + (z/2 - z').^2;
    nDis(eye(inc, inc) == 1) = 1000;
    NBs = in(sum(nDis < (x.^2 + y.^2 + z.^2)/4, 2) <= 0);
    NBs(acos(p(i, 4:6)*p(NBs, 4:6)') > pol) = [];
    GoA = ones(inc, 1)*NBs(1);
    for j = 2:numel(NBs)
        [~, ib] = ismember(mysetdiff(NBs, GoA), ID(GoA(j-1), min(1:inc*2, size(ID, 2))));
        GoA(j) = ID(GoA(j-1), min(ib(ib>0)));
        TRI(k, :) = [i GoA(j-1) GoA(j)];
        k = k + 1;
    end
	if numel(NBs) > 2
        TRI(k, :) = [i GoA(j) GoA(1)];
        k = k + 1;
	end
end
TRI(k:end, :) = [];