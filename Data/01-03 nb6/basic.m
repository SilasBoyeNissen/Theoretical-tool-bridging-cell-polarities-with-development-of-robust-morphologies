clc; clear; clf; tic;
load('data/t316228');
t = 316229;
lt = 0;
l = ones(size(p, 1), 1);
while t <= 1e6
    disp(t);
    disp(p(1, :));
	[~, ID] = mink(sqrt((p(:, 1)' - p(:, 1)).^2 + (p(:, 2)' - p(:, 2)).^2 + (p(:, 3)' - p(:, 3)).^2), 7, 2);
    NB = ID(:, 2:7);
    dr = moved(l, NB, p);
    p(:, 1:6) = p(:, 1:6) + 0.1*dr(:, 1:6) + normrnd(0, 1e-5, size(p, 1), 6);
    p(:, 4:6) = p(:, 4:6)./repmat(sqrt(sum(p(:, 4:6).^2, 2)), 1, 3);
    if floor(log10(t)*100)/100 > lt
        lt = floor(log10(t)*100)/100;
        p(:, 7) = dr(:, 7);
        p(:, 8) = sum(NB>0, 2);
        save(['data/t' num2str(t) '.mat'], 'p');
    end
    t = t + 1;
end
toc;