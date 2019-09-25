clc; clear; clf; tic;
rng(1);
load('data/t354814');
t = 354815;
lt = 5.55;
inc = 100;
ID = knnsearch(p(:, 1:3), p(:, 1:3), 'K', inc+1);
while t <= 1e6
    disp(t);
    disp(p(1, :));
	NB = neighbor(ID, inc, p);
    dr = moved(NB, p);
    p(:, 1:3) = p(:, 1:3) + 0.1*dr(:, 1:3) + normrnd(0, 1e-2, size(p, 1), 3);
    if floor(log10(t)*100)/100 > lt
        lt = floor(log10(t)*100)/100;
        p(:, 7) = dr(:, 7);
        p(:, 8) = sum(NB>0, 2);
        save(['data/t' num2str(t) '.mat'], 'p');
        ID = knnsearch(p(:, 1:3), p(:, 1:3), 'K', inc+1);
    end
    t = t + 1;
end
toc;