function NB = neighbor(p)
[V, C] = voronoin(p(:, 1:3));
S = false(size(p, 1), size(V, 1));
NB = false(size(p, 1), size(p, 1));
for i = 1:size(p, 1)
    S(i, C{i}) = 1;
end
for i = 2:size(V, 1)
    in = (S(:, i) == 1);
    NB(in, in) = 1;
end
NB(eye(size(NB)) == 1) = 0;
NB(sqrt((p(:, 1)' - p(:, 1)).^2 + (p(:, 2)' - p(:, 2)).^2 + (p(:, 3)' - p(:, 3)).^2) > 3) = 0;