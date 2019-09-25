function NB = neighbor(p)
inc = 20;
x = p(:, 1)' - p(:, 1);
y = p(:, 2)' - p(:, 2);
z = p(:, 3)' - p(:, 3);
d = sqrt(x.^2 + y.^2 + z.^2);
d(d == 0) = 1000;
[~, ID] = sort(d, 2);
N = size(p, 1);
NB = zeros(N, inc);
for i = 1:N
    in = ID(i, 1:inc);
    nDis = sqrt((p(in, 1)' - p(i, 1) + x(in, i)/2).^2 + (p(in, 2)' - p(i, 2) + y(in, i)/2).^2 + (p(in, 3)' - p(i, 3) + z(in, i)/2).^2);
    nDis(eye(inc, inc) == 1) = 1000;
    NBs = in(sum(nDis < d(in, i)/2, 2) <= 0);
    NB(i, 1:numel(NBs)) = NBs;
end