clc; clear; clf; tic;
rng(1);
load('data/t1');
t = 2;
lt = 0;
inc = 100;
ID = knnsearch(p(:, 1:3), p(:, 1:3), 'K', inc+1);
while t <= 1e7
    disp(t);
	NB = neighbor(ID, inc, p(:, 1:3));
    dr1 = moved(repmat([0.9*1/2 1/2 0.1*1/2 0], size(p, 1), 1), NB, p);
    dr2 = moved(repmat([0.9*1/2 0   0.1*1/2 0], size(p, 1), 1), NB, p);
    p(:, 1:3) = p(:, 1:3) + 0.2*dr1(:, 1:3) + normrnd(0, 1e-5, size(p, 1), 3);
    p(:, 4:6) = p(:, 4:6) + 0.2*dr2(:, 4:6) + normrnd(0, 1e-5, size(p, 1), 3);
    p(:, 7:9) = p(:, 7:9) + 0.2*dr1(:, 7:9) + normrnd(0, 1e-5, size(p, 1), 3);
    p(:, 4:6) = p(:, 4:6)./repmat(sqrt(sum(p(:, 4:6).^2, 2)), 1, 3);
    p(:, 7:9) = p(:, 7:9)./repmat(sqrt(sum(p(:, 7:9).^2, 2)), 1, 3);
    if floor(log10(t)*100)/100 > lt
        lt = floor(log10(t)*100)/100;
        p(:, 10) = dr1(:, 10);
        p(:, 11) = sum(NB>0, 2);
        save(['data/t' num2str(t) '.mat'], 'p');
        ID = knnsearch(p(:, 1:3), p(:, 1:3), 'K', inc+1);
    end
    t = t + 1;
end
toc;