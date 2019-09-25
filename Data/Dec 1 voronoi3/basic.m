clc; clear; clf; tic;
load('data/t0');
t = 1;
l = ones(size(p, 1), 1);
while t <= 1e6
    disp(t);
    disp(p(1, :));
    tt = num2str(t);
	NB = neighbor(p);
    dr = moved(l, NB, p);
    if t < 100 || all(tt(3:end) == '0')
        p(:, 7) = dr(:, 7);
        p(:, 8) = sum(NB, 2);
        save(['data/t' num2str(t) '.mat'], 'p');
    end
    p(:, 1:6) = p(:, 1:6) + 0.1*dr(:, 1:6) + normrnd(0, 1e-5, size(p, 1), 6);
    p(:, 4:6) = p(:, 4:6)./repmat(sqrt(sum(p(:, 4:6).^2, 2)), 1, 3);
    t = t + 1;
end
toc;