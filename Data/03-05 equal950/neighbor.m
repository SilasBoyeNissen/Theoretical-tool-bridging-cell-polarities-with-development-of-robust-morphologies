function NB = neighbor(ID, inc, p)
NB = zeros(size(p, 1), inc);
for i = 1:size(p, 1)
    in = ID(i, 2:inc+1);
    x = p(i, 1)' - p(in, 1);
    y = p(i, 2)' - p(in, 2);
    z = p(i, 3)' - p(in, 3);
    nDis = sqrt((p(in, 1)' - p(i, 1) + x/2).^2 + (p(in, 2)' - p(i, 2) + y/2).^2 + (p(in, 3)' - p(i, 3) + z/2).^2);
    nDis(eye(inc, inc) == 1) = 1000;
    NBs = in(sum(nDis < sqrt(x.^2 + y.^2 + z.^2)/2, 2) <= 0);
    NB(i, 1:numel(NBs)) = NBs;
end