function NB = neighbor(p)
NB = false(size(p, 1), size(p, 1));
d = sqrt((p(:, 1)' - p(:, 1)).^2 + (p(:, 2)' - p(:, 2)).^2 + (p(:, 3)' - p(:, 3)).^2);
d(d == 0) = 100;
NB(d < 2.5) = 1;